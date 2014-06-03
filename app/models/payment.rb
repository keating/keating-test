class Payment < ActiveRecord::Base

  NO_CONDITION = 'There is no service_id or line_item_id'

  # the result format
  # {result: boolean, message: string, error_type: class}
  def self.with hash
    return {result: false, message: NO_CONDITION} unless hash[:service_id] and hash[:line_item_id]
    begin
      Payment.transaction do
        payment = Payment.where(hash).first
        unless payment
          payment = Payment.create(hash)
        end
        yield(payment) if block_given?
      end
      result = {result: true}
    rescue Exception => e
      result = {result: false, message: e.message, error_type: e.class}
    end
    result
  end
end