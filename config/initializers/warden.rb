require 'warden'

Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.where(id: id).first
end

require 'warden/strategies/basic_strategy'
require 'warden/strategies/session_strategy'

Rails.application.config.middleware.insert_after(ActionDispatch::Flash, Warden::Manager) do |manager|
  manager.default_strategies :basic, :session
  manager.failure_app = Class.new do
    def self.call(env)
      [401, {}, StringIO.new]
    end
  end
end
