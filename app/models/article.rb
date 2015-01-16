class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :title, presence: true,
    length: { minimum: 5 }

  #searchable do
    #string :title
    #text :title
    #integer :user_id
    #string :description
    #text :description
  #end

  #def self.search(search)
    #if search
      #where('title LIKE ? or text LIKE ?', "%#{search}%", "%#{search}%")
    #else
      #all
    #end
  #end
end
