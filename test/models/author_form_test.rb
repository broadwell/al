# == Schema Information
#
# Table name: author_forms
#
#  id         :integer          not null, primary key
#  author_id  :integer
#  form_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AuthorFormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
