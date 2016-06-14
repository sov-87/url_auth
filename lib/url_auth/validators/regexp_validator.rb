class RegexpValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      Regexp.new(value)
    rescue RegexpError
      record.errors[attribute] << (options[:message] || "Неверное регулярное выражение")
    end
  end
end
