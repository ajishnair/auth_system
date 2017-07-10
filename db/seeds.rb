# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
RoleAccess.delete_all
UserRole.delete_all
Post.delete_all
User.delete_all
Role.delete_all
Access.delete_all

Access.create([{ name: 'READ'}, {name: 'WRITE'}, {name: 'UPDATE'}, {name: 'DELETE'}, {name: 'GRANT'}, {name: 'REVOKE'}])
read_id = Access.find_by(:name => 'READ').id
write_id = Access.find_by(:name => 'WRITE').id
update_id = Access.find_by(:name => 'UPDATE').id
delete_id = Access.find_by(:name => 'DELETE').id
grant_id = Access.find_by(:name => 'GRANT').id
revoke_id = Access.find_by(:name => 'REVOKE').id

Role.create([{name: 'USER'}, {name: 'MODERATOR'}, {name: 'ADMIN'}, {name: 'ANONYMOUS'}])

anonymous_role_id = Role.find_by(:name => 'ANONYMOUS').id
RoleAccess.create([{role_id: anonymous_role_id, access_id: read_id}])

user_role_id = Role.find_by(:name => 'USER').id
RoleAccess.create([{role_id: user_role_id, access_id: read_id}])
RoleAccess.create([{role_id: user_role_id, access_id: write_id}])
RoleAccess.create([{role_id: user_role_id, access_id: update_id}])

moderator_role_id = Role.find_by(:name => 'MODERATOR').id
RoleAccess.create([{role_id: moderator_role_id, access_id: read_id}])
RoleAccess.create([{role_id: moderator_role_id, access_id: write_id}])
RoleAccess.create([{role_id: moderator_role_id, access_id: update_id}])
RoleAccess.create([{role_id: moderator_role_id, access_id: delete_id}])

User.create([{name: 'user'}, {name: 'moderator'}, {name: 'anonymous'}])

user_id = User.find_by(:name => 'user').id
moderator_id = User.find_by(:name => 'moderator').id
anonymous_id = User.find_by(:name => 'anonymous').id

UserRole.create([{user_id: user_id, role_id: user_role_id}, {user_id: moderator_id, role_id: moderator_role_id}, {user_id: anonymous_id, role_id: anonymous_role_id}])