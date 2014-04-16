class Name < ActiveRecord::Base
  has_many :mentions
  has_many :cases, :through => :mentions
end
