# Make Oktokit mock to use only Gitlab.
require 'octokit/client'

module Octokit
  class Client
    def contents(repo, options={})
      return []
    end

    def pull_request(repo, number, options = {})
      return []
    end

    def compare(repo, start, endd, options = {})
      result = []
      def result.commits
        []
      end
      def result.files
        []
      end
      result
    end

    def create_release(repo, tag_name, options = {})
      return []
    end

    def create_deployment(repo, ref, options = {})
      return []
    end

    def create_deployment_status(deployment_url, state, options = {})
      return []
    end

    def add_comment(repo, number, comment, options = {})
      return []
    end

    def branch(repo, branch, options = {})
      result = {}
      def result.commit
        return {:sha => "none"}
      end
      return result
    end

    def combined_status(repo, ref, options = {})
      return {}
    end

    def commit(repo, sha, options = {})
      return []
    end
  end
end

require 'application_helper'
module ApplicationHelper
  def github_ok?
    return true
  end
end
