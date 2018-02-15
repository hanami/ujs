# frozen_string_literal: true

require "pathname"

module Hanami
  # Unobtrusive JavaScript
  #
  # @since 0.1.0
  module UJS
    require "hanami/ujs/version"
  end
end

if defined?(Hanami::Assets)
  Hanami::Assets.sources << Pathname.new(__dir__).join("ujs", "assets").realpath
end
