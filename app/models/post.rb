class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_title, against: :title
  mount_uploader :post_cover, PostCoverUploader
end
