class ReleaseService
  def initialize(project)
    @project = project
  end

  def create_release!(attrs = {})
    release = @project.releases.create!(attrs)
    push_tag_to_git_repository(release)
    start_deploys(release)
    release
  end

  private

  def push_tag_to_git_repository(release)
    GITHUB.create_release(@project.repo_name, release.version, target_commitish: release.commit)
  end

  def start_deploys(release)
    deploy_service = DeployService.new(release.author)

    @project.auto_release_stages.each do |stage|
      deploy_service.deploy!(stage, reference: release.version)
    end
  end
end
