class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy #jak usuniesz posta to z komentarzami
	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence: true
end
