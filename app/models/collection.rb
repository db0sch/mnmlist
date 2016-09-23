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
  # acts_as_votable gem (a collection can be voted by a user)
  acts_as_votable

  # Public_activity gem, for keeping track of of everything done by users on collections.
  include PublicActivity::Common
  # tracked owner: ->(controller, model) { controller && controller.current_user }

  # ALGOLIA Search Engine

  include AlgoliaSearch

  algoliasearch do
    attribute :title, :tagline, :description

    add_attribute :collection_stars do
      get_likes.size
    end

    attributesToIndex ['title', 'tagline', 'description']

    customRanking ['desc(collection_stars)']
  end

end
