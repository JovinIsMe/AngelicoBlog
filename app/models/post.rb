# == Schema Information
#
# Table name: posts
#
#  id               :bigint(8)        not null, primary key
#  title            :string
#  body             :text
#  description      :text
#  slug             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  banner_image_url :string
#  author_id        :integer
#  published        :boolean          default(FALSE)
#  published_at     :datetime
#

class Post < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :author

  scope :most_recent, -> {
    order(published_at: :desc)
  }

  scope :published, -> {
    where(published: true)
  }

  def should_generate_new_friendly_id?
    title_changed?
  end

  def display_published_time
    "Published on #{published_at.strftime('%-d %-b %Y %H:%M:%S %z')}"
  end

  def publish
    update(published: true, published_at: Time.current)
  end

  def unpublish
    update(published: false, published_at: nil)
  end
end
