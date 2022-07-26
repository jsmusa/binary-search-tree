class  Node
  include Comparable

  attr_accessor :data, :left, :right

  def <=>(other)
    if other.is_a?(Node)
      data <=> other.data
    else
      data <=> other
    end
  end

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end