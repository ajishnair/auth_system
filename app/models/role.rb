class Role < ActiveRecord::Base
  belongs_to :user
  has_many :accesses, :through => :role_accesses
  has_many :role_accesses
end