class Collection < ApplicationRecord
  has_many :resources, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user

  validates :title, presence: true;
  validates :title, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true;
  validates :description, length: { minimum: 5 }

  # acts_as_followable gem in order to allow users to follow a collection
  acts_as_followable

end
