class Post < ActiveRecord::Base
	#attr_accessible  :content, :title
  belongs_to :user
  
	validates :title,  :presence => true
  validates :content, :presence => true,
                    :length => { :minimum => 5 }
end
