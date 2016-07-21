# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  completed    :boolean          default(FALSE), not null
#  completed_at :datetime
#  user_id      :integer
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_b872a6760a  (user_id => users.id)
#

class Project < ApplicationRecord
  belongs_to :user
end
