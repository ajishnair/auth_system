class User < ActiveRecord::Base
  has_many :posts
	has_many :roles, :through => :user_roles
  has_many :user_roles

  def permissions
    accesses = []
    for role in self.roles
      accesses.push(*(role.accesses.pluck(:name)))
    end
    accesses.uniq
  end

  def access_roles
    self.roles.pluck(:name)
  end
end
