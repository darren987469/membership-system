# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    begin
      DatabaseCleaner.clean
    rescue NoMethodError => error
      # workaround for transaction.rollback, where transaction is nil
      raise unless error.message == "undefined method `rollback' for nil:NilClass"
    end
  end
end
