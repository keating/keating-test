class AddLockVersionToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :lock_version, :integer
  end
end
