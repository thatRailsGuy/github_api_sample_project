# == Schema Information
#
# Table name: pulls
#
#  id               :integer          not null, primary key
#  gh_id            :integer
#  repo_gh_id       :integer
#  state            :string
#  gh_number        :integer
#  title            :string
#  body             :text
#  gh_created_at    :datetime
#  gh_updated_at    :datetime
#  gh_closed_at     :datetime
#  gh_merged_at     :datetime
#  merge_commit_sha :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  first_commit_at  :datetime
#

require 'test_helper'

class PullTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
