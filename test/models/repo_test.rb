# == Schema Information
#
# Table name: repos
#
#  id                 :integer          not null, primary key
#  gh_id              :integer
#  name               :string
#  organization_gh_id :integer
#  description        :string
#  gh_created_at      :datetime
#  gh_updated_at      :datetime
#  gh_pushed_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class RepoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
