module QuestionsHelper
  def sklonenie(number, one, few, many, with_number = false)
    number = 0 if number.nil? || !number.is_a?(Numeric)
    prefix = with_number ? "#{number} " : ''
    return prefix + many if (number % 100).between?(11, 14)
    word = case number % 10
    when 1
      one
    when 2..4
      few
    else
      many
    end

    prefix + word
  end
end
