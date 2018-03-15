# frozen_string_literal: true

RSpec.describe "Disable", type: :integration do
  it "successfully disable submit button" do
    with_project do
      generate "action web home#index --url=/"
      rewrite "apps/web/templates/home/index.html.erb", <<~CODE
        <%=
          form_for :search, "/search", "id": "my-form" do
            div do
              label "Term", for: :q
              text_field :q
            end

            div do
              submit "Search", "id": "submit-button", "data-disable-with": "Searching.."
            end
          end
        %>

        <div id="console"></div>
      CODE

      generate "action web search#index --url=/search --method=POST"

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
          function log(text) {
            append("console", "<p>" + text + "</p>");
          }

          function append(domID, html) {
            el = document.getElementById(domID);
            el.innerHTML += html;
          }

          var submitHandler = function(event) {
            event.preventDefault();

            window.setTimeout(function(){
              var submitButton = document.getElementById("submit-button");

              log("disabled: " + submitButton.disabled);
              log("label: " + submitButton.innerHTML);
            }, 1000);
          };

          var myForm = document.getElementById("my-form");
          myForm.addEventListener("submit", submitHandler);
        })();
      CODE

      server do
        visit "/"

        fill_in "Term", with: "Hanami"
        click_button "Search"

        expect(current_path).to eq("/")

        within "#console" do
          expect(page).to have_content("disabled: true")
          expect(page).to have_content("label: Searching..")
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
