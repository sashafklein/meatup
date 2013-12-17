class Array
  def sum(attribute)
    raise "No such attribute: #{attribute}" unless first.attribute
    raise "Attribute is not number: #{attribute}" unless first.attribute.is_a?(Fixnum)
    map(&:attribute).sum
  end
end