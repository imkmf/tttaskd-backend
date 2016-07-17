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

class Project < ApplicationRecord
  belongs_to :user
end
