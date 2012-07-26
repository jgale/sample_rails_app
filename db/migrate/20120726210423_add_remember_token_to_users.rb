class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :remember_token, :string
  	# Note that, because we expect to retrieve users by remember token, we’ve added an index (Box 6.2) to the remember_token column.
  	# e.g. allows you to do: User.find_by_remember_token(cookies[:remember_token])
    add_index  :users, :remember_token
  end
end
