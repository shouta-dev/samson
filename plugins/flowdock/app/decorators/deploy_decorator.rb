Deploy.class_eval do
  def default_flowdock_message(user)
    ":pray: #{user_tag(user)} is requesting approval for deploy #{deploy_url}"
  end

  def deploy_url
    Rails.application.routes.url_helpers.project_deploy_url(self.stage.project, self)
  end

  private

  def user_tag(user)
    "@#{user.email.match(/(.*)@/)[1]}"
  end
end