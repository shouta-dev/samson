class ChangelogsController < ApplicationController
  before_action :check_params

  def show
    @start_date = Date.strptime(params[:start_date], '%Y-%m-%d')
    @end_date = Date.strptime(params[:end_date], '%Y-%m-%d')

    @project = Project.find_by_param!(params[:project_id])
    @changeset = Changeset.new(@project.repo_name, "master@{#{@start_date}}", "master@{#{@end_date}}")
  end

  private

  def check_params
    if params[:start_date].blank? || params[:end_date].blank?
      redirect_to start_date: (Date.today.beginning_of_week - 3.days).to_s, end_date: Date.today.to_s
    end
  end
end
