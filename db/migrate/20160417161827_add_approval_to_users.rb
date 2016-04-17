class AddApprovalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :approval_digest, :string
    add_column :users, :approved, :boolean, default: false
    add_column :users, :approved_at, :datetime
  end
end
