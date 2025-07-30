class Player
  attr_reader :name, :symbol

  def initialize(name:, token:, color:)
    @name = name
    @token = token
    @color = color
  end
end
