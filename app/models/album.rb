class Album < ActiveRecord::Base
	belongs_to :user 
	belongs_to :genre
	has_many :reviews

	#has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	#validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

	#below used to associate paperclip based album_img with Album model
	#album_img added to Book via migration
								#album_index for images passed thru index 	#album_show for images on show pages
	has_attached_file :album_img, styles: { album_index: "350x350>", album_show: "250x250>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :album_img, content_type: /\Aimage\/.*\z/


end
