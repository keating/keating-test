
class Luhn

  # check if a number is valid
  def self.valid_number? number
    # change the number to an array, and reverse the elements' order
    arr = number.to_s.split("").reverse
    # iterate the array
    0.upto(arr.length - 1).each do |i|
      # change value of the elements that have an odd index, note odd!
      if i % 2 == 1
        # multiply the value by 2 and then build an array from the result
        two_digit_array = (arr[i].to_i * 2).to_s.split("")
        # plus the two elements(maybe one element, nil will be 0 when plus)
        arr[i] = two_digit_array[0].to_i + two_digit_array[1].to_i
      end
    end
    # sum of the array elements
    sum = arr.inject(0) {|sum, x| sum + x.to_i }
    # modulo 10, and compare the result with 0
    sum % 10 == 0
  end

  # get a number with the check digit
  # the parameter number here has less one digit than the valid_number? method
  def self.number_with_check_digit number
    # change the number to an array, and reverse the elements' order
    arr = number.to_s.split("").reverse
    # iterate the array
    0.upto(arr.length - 1).each do |i|
      # change value of the elements that have a even index, note even!
      if i % 2 == 0
        # multiply the value by 2 and then build an array from the result
        two_digit_array = (arr[i].to_i * 2).to_s.split("")
        # plus the two elements(maybe one element, nil will be 0 when plus)
        arr[i] = two_digit_array[0].to_i + two_digit_array[1].to_i
      end
    end
    # sum of the array elements
    sum = arr.inject(0) {|sum, x| sum + x.to_i }
    # get check digit
    check_digit = 10 - sum % 10
    # return the valid number
    "#{number}#{check_digit}".to_i
  end

end