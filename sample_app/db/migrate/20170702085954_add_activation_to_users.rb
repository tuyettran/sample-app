class AddActivationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :is_activated, :boolean, default: false
    add_column :users, :activated_at, :datetime
  end
end
