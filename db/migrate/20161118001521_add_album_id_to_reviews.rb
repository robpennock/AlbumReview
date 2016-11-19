class AddAlbumIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :album_id, :integer
  end
end
