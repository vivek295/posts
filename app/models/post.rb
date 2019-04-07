class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  include SoftDelete
end