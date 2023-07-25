# https://github.com/thoughtbot/factory_bot/issues/359
module FactoryBot::Syntax::Methods
  def attributes_with_foreign_keys_for(*args)
    FactoryBot.build(*args).attributes.delete_if do |k, v|
      ["id", "type", "created_at", "updated_at"].member?(k)
    end
  end
end
