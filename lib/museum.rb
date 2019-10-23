class Museum
  attr_accessor :name, :exhibits, :patrons, :exhibits_instances

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @exhibits_instances = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    patron.interests & @exhibits
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    hash = {}
    @exhibits.each do |exhibit|
      hash[exhibit] = []
    end
    @patrons.each do |patron|
      if patron.interests.include?(@dead_sea_scrolls)
        hash[@dead_sea_scrolls] = patrons
      elsif patron.interests.include?(@gems_and_minerals)
        hash[@gems_and_minerals] = patrons
      else patron.interests.include?(@imax)
        hash[@imax] = patrons
      end
    end
    hash
  end

end
