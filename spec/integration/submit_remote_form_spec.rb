# frozen_string_literal: true

RSpec.describe "Submit remote form", type: :integration do
  it "successfully sends AJAX request" do
    with_project do
      generate "action web home#index --url=/"
      rewrite "apps/web/templates/home/index.html.erb", <<~CODE
        <%=
          form_for :search, "/search", remote: true do
            div do
              label "Term", for: :q
              text_field :q
            end

            div do
              submit "Search"
            end
          end
        %>

        <div id="results">
        </div>

        <div id="console">
        </div>
      CODE

      generate "action web search#index --url=/search --method=POST"
      rewrite "apps/web/controllers/search/index.rb", <<~CODE
        module Web::Controllers::Search
          class Index
            include Web::Action
            expose :results

            def call(params)
              @results = [{ project: params.get(:search, :q) }]
              self.format = :json if xhr?(params.env)
            end

            private

            def xhr?(env)
              env["HTTP_X_REQUESTED_WITH"] == "XmlHttpRequest"
            end
          end
        end
      CODE

      write "apps/web/templates/search/index.json.erb", <<~CODE
        <%= results.to_json %>
      CODE

      rewrite "apps/web/templates/application.html.erb", <<~CODE
        <!DOCTYPE html>
        <html>
          <head>
            <title>Web</title>
            <%= favicon %>
            <%= csrf_meta_tags %>
          </head>
          <body>
            <%= yield %>
            <%= javascript "hanami-ujs", "home" %>
          </body>
        </html>
      CODE

      write "apps/web/assets/javascripts/home.js", <<~CODE
        (function() {
          function log(event) {
            append("console", "<p>" + event.type + "</p>");
            // console.log(event);
          }

          function append(domID, html) {
            el = document.getElementById(domID);
            el.innerHTML += html;
          }

          function reset(domID) {
            el = document.getElementById(domID);
            el.innerHTML = "";
          }

          var ajaxBeforeHandler = function(event) {
            log(event);
          };

          var ajaxCompleteHandler = function(event) {
            log(event);
            var data = JSON.parse(event.detail.responseText);

            reset("results");
            data.map( function(item) {
              append("results", "<p>" + item.project + "</p>");
            })
          };

          document.addEventListener("ajax:before", ajaxBeforeHandler);
          document.addEventListener("ajax:complete", ajaxCompleteHandler);
        })();
      CODE

      server do
        visit "/"

        fill_in "Term", with: "Hanami"
        click_button "Search"

        expect(current_path).to eq("/")

        within "#results" do
          expect(page).to have_content("Hanami")
        end

        within "#console" do
          expect(page).to have_content("ajax:before")
          expect(page).to have_content("ajax:complete")
        end
      end
    end
  end

  private

  def with_project
    super("bookshelf", gems: { "hanami-ujs" => { path: Pathname.new(__dir__).join("..", "..").realpath.to_s } }) do
      replace_last "apps/web/application.rb", "# sessions :cookie, secret: ENV['WEB_SESSIONS_SECRET']", "sessions :cookie, secret: ENV['WEB_SESSIONS_SECRET']"
      bundle_install
      yield
    end
  end
end
