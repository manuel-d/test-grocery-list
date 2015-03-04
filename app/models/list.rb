class List < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true,
	length: { minimum: 1 }
	validates :user_id, presence: true
end
