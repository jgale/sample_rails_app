class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # includes a composite index that enforces uniqueness of pairs of (follower_id, followed_id),
    # so that a user can’t follow another user more than once.
    # We could also add a uniqueness validation to the Relationship model, but because it is always
    # an error to create duplicate relationships, the unique index is sufficient for our purposes.
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
