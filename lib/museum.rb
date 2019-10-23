class Museum
  attr_accessor :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit.name
  end

  def recommend_exhibits(patron)
    patron.interests & @exhibits
  end

  def admit(patron)
    @patrons << patron
  end

end
