# frozen_string_literal: true

require 'devise'
require 'support/request_spec_helper'

RSpec.configure do |config|
  config.include RequestSpecHelper, type: :request
end
