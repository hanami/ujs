# Hanami::UJS

Unobtrusive JavaScript (UJS) for [Hanami](http://hanamirb.org).

## Status

[![Gem Version](http://img.shields.io/gem/v/hanami-ujs.svg)](https://badge.fury.io/rb/hanami-ujs)

## Installation

Add this line to your Hanami project's `Gemfile`:

```ruby
gem "hanami-ujs"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hanami-ujs

## Usage

### Setup

You have to add two lines to the application layout (eg. `apps/web/templates/application.html.erb`):

  1. `<%= csrf_meta_tags %>` inside `<head>`
  2. `<%= javascript "hanami-ujs" %>` the location is optional, but before `</body>` is a good spot.

### Events

Hanami UJS fires events to notify listeners that a certain operation happened:

  * `"ajax.before"`
  * `"ajax.complete"`

You can listen to these events with:

```js
(function() {
  var ajaxBeforeHandler = function(event) {
    console.log(event);
  };

  var ajaxCompleteHandler = function(event) {
    console.log(event);
  };

  document.addEventListener("ajax:before", ajaxBeforeHandler);
  document.addEventListener("ajax:complete", ajaxCompleteHandler);
})();
```

### AJAX Form

```erb
<%=
  form_for :search, "/search", remote: true do
    # ...

    submit "Search"
  end
%>
```

When the user will hit "Search" the form will be sent via AJAX.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hanami/ujs.

## Acknowledgements

This gem JavaScript code is from the great [vanilla-ujs](https://rubygems.org/gems/vanilla-ujs) gem,
which is MIT licensed (Copyright (c) 2013 Łukasz Niemier). Thank you for your awesome work!

## Copyright

Copyright © 2018 Luca Guidi – Released under MIT License
