require "spec_helper"

describe Luhn do

  describe "valid_number?" do
    it "is true for 79927398713" do
      expect(Luhn.valid_number?(79927398713)).to eq(true)
    end

    it "is false" do
      expect(Luhn.valid_number?(79927398710)).to eq(false)
      expect(Luhn.valid_number?(79927398711)).to eq(false)
      expect(Luhn.valid_number?(79927398712)).to eq(false)
      expect(Luhn.valid_number?(79927398714)).to eq(false)
      expect(Luhn.valid_number?(79927398715)).to eq(false)
      expect(Luhn.valid_number?(79927398716)).to eq(false)
      expect(Luhn.valid_number?(79927398717)).to eq(false)
      expect(Luhn.valid_number?(79927398718)).to eq(false)
      expect(Luhn.valid_number?(79927398719)).to eq(false)
    end
  end

  describe "number_with_check_digit" do
    it "check digit for 7992739871 is 3" do
      expect(Luhn.number_with_check_digit(7992739871)).to eq(79927398713)
    end

    it "check digit for 1 is 8" do
      expect(Luhn.number_with_check_digit(1)).to eq(18)
    end

    it "check digit for 22 is 4" do
      expect(Luhn.number_with_check_digit(22)).to eq(224)
    end

    it "check digit for 111 is 5" do
      expect(Luhn.number_with_check_digit(111)).to eq(1115)
    end
  end
end