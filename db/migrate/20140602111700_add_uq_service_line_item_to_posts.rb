class AddUqServiceLineItemToPosts < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("ALTER TABLE payments ADD CONSTRAINT uq_service_line_item UNIQUE (service_id, line_item_id)")
  end

  def down
    ActiveRecord::Base.connection.execute("ALTER TABLE payments DROP index uq_service_line_item")
  end
end
