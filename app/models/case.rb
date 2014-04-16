class Case < ActiveRecord::Base
  has_many :mentions
  has_many :names, :through => :mentions
end
