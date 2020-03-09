class CreateRelationshipRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :relationship_requests do |t|
      t.references :requester, foreign_key: { to_table: :users }
      t.references :recipient, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :relationship_requests, %i[requester_id recipient_id], unique: true
  end
end
