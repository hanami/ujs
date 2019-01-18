# frozen_string_literal: true

RSpec.describe "Hanami::UJS::VERSION" do
  it "exposes version" do
    expect(Hanami::UJS::VERSION).to eq("0.2.0")
  end
end
