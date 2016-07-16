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
#

class Project < ApplicationRecord
end
