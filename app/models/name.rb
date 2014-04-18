class Name < ActiveRecord::Base
  has_many :mentions
  has_many :cases, :through => :mentions

  def self.search(search)
    if(search)
      self.where("name LIKE ?", "%#{search}%")
    else
      self.all
    end
  end
end
