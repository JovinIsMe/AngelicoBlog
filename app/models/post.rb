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
#  image :string
#  author_id        :integer
#  published        :boolean          default(FALSE)
#  published_at     :datetime
#

class Post < ApplicationRecord

  acts_as_taggable

  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :image, ImageUploader

  belongs_to :author

  PER_PAGE = 3

  scope :most_recent, -> {
    order(published_at: :desc)
  }

  scope :published, -> {
    where(published: true)
  }

  scope :recent_paginated, -> (page) {
    most_recent.paginate(:page => page, per_page: PER_PAGE)
  }

  scope :with_tag, -> (tag) { tagged_with(tag) if tag.present? }

  scope :list_for, -> (page, tag) do
    recent_paginated(page).with_tag(tag)
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

  def display_published_time
    if published
      "Published on #{published_at.strftime('%-d %-b %Y %H:%M:%S %z')}"
    else
      'Not published yet'
    end
  end

  def publish
    update(published: true, published_at: Time.current)
  end

  def unpublish
    update(published: false, published_at: nil)
  end
end
