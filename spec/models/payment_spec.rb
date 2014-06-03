require 'spec_helper'

describe Payment do
  describe "with" do
    context "without service_id" do
      it "fail" do
        result = Payment.with({line_item_id: 1})
        expect(result[:result]).to eq(false)
        expect(result[:message]).to eq('There is no service_id or line_item_id')
        expect(Payment.count).to eq(0)
      end
    end

    context "without line_item_id" do
      it "fail" do
        result = Payment.with({service_id: 1})
        expect(result[:result]).to eq(false)
        expect(result[:message]).to eq('There is no service_id or line_item_id')
        expect(Payment.count).to eq(0)
      end
    end

    context "with service_id and line_item_id" do

      let(:valid_condition) { {service_id: 1, line_item_id: 1} }

      describe "pay one by one" do
        it "one process" do
          result = Payment.with(valid_condition)
          expect(result[:result]).to eq(true)
          expect(Payment.count).to eq(1)
        end

        it "same service and line item" do
          result = Payment.with(valid_condition)
          expect(result[:result]).to eq(true)

          result = Payment.with(valid_condition)
          expect(result[:result]).to eq(true)

          expect(Payment.count).to eq(1)
        end

        it "different services and line items" do
          result = Payment.with(valid_condition)
          expect(result[:result]).to eq(true)

          result = Payment.with({service_id: 2, line_item_id: 2})
          expect(result[:result]).to eq(true)

          expect(Payment.count).to eq(2)
        end
      end

      describe "pay at the same time" do
        it "main thread will fail if no payment" do
          t = Thread.new do
            result = Payment.with(valid_condition) { sleep 1 }
            expect(result[:result]).to eq(true)
          end

          sleep 0.3
          result = Payment.with(valid_condition)
          expect(result[:result]).to eq(false)
          expect(result[:error_type]).to eq(ActiveRecord::RecordNotUnique)

          t.join
        end

        it "main thread will succeed if there is payment" do
          FactoryGirl.create(:payment, valid_condition)

          t = Thread.new do
            result = Payment.with(valid_condition) { sleep 1 }
            expect(result[:result]).to eq(true)
          end

          sleep 0.3
          result = Payment.with(valid_condition)
          expect(result[:result]).to eq(true)

          t.join
        end

        it "main thread can update payment if sub thread did not update" do
          FactoryGirl.create(:payment, valid_condition)

          t = Thread.new do
            result = Payment.with(valid_condition) { sleep 1 }
            expect(result[:result]).to eq(true)
          end

          sleep 0.3
          result = Payment.with(valid_condition) do |payment|
            payment.update remark: 'main thread remark'
          end
          expect(result[:result]).to eq(true)

          t.join
          expect(Payment.first.remark).to eq('main thread remark')
        end

        it "main thread can not update payment if sub thread updated payment" do
          FactoryGirl.create(:payment, valid_condition)

          t = Thread.new do
            result = Payment.with(valid_condition) do |payment|
              payment.update remark: 'sub thread remark'
              sleep 1
            end
            expect(result[:result]).to eq(true)
          end

          sleep 0.3
          result = Payment.with(valid_condition) do |payment|
            payment.update remark: 'main thread remark'
          end
          expect(result[:result]).to eq(false)
          expect(result[:error_type]).to eq(ActiveRecord::StaleObjectError)

          t.join
          expect(Payment.first.remark).to eq('sub thread remark')
        end
      end
    end
  end
end