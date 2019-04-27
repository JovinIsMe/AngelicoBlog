class ChangeBannerImageUrlToImage < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :banner_image_url, :image
  end
end
