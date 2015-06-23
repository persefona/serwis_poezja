class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy #jak usuniesz posta to z komentarzami
	belongs_to :category
	belongs_to :topic
	belongs_to :user
	validates :title, presence: true, length: { minimum: 3 }
	validates :body, presence: true

	
	
end
