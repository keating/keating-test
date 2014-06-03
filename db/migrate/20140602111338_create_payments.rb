class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :service_id
      t.integer :line_item_id
      t.string :remark

      t.timestamps
    end
  end
end
