class Sklonjator
  def self.sklonenie(number, one, few, many, with_number = false)
    number = 0 if number.nil? || !number.is_a?(Numeric)
    prefix = with_number ? "#{number} " : ''
    return prefix + many if (number % 100).between?(11, 14)
    word = case number % 10
    when 1 then one
    when 2..4 then few
    else
      many
    end

    prefix + word
  end
end
