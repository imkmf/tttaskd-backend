# == Schema Information
#
# Table name: contexts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  notes      :text
#
# Indexes
#
#  index_contexts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_6d2943ccf8  (user_id => users.id)
#

class Context < ApplicationRecord
  belongs_to :user
end
