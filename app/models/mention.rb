class Mention < ActiveRecord::Base
  belongs_to :case
  belongs_to :name
end
