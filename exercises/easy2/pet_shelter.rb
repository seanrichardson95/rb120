# Write the classes and methods that will be necessary to make this code run, and print the following output:

=begin
3 classes:
-Shelter
  -Methods
    -adopt(owner, pet), saves this information somewhere, maybe in a hash?
      -@adopted_pets is a Hash, key is owner, value is an array of pets
    -print_adoptions
      -loop through @adopted_pets
        -print "owner has adopted the following pets:"
        -print a #{pet.species} named #{pet.name}

-Pet
  -@species ('cat', 'dog', 'bird', etc)
  -@name ("Butterscotch", "Pudding", etc)
  
-Owner
  -Instance Variables
    -@name
    -@@number_of_pets


P Hanson has adopted the following pets: => from shelter.print_adoption
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
=end

class Shelter
  attr_accessor :owners, :unadopted
  
  def initialize
    @owners = []
    @unadopted = {}
  end
  
  def adopt(owner, pet)
    self.owners << owner if !self.owners.include?(owner)
    owner.add_pet(pet)
    self.unadopted.delete(pet)
  end
  
  def take_in(pet)
    self.unadopted[pet] = pet.to_s
  end
  
  def print_unadopted
    puts "The Animal Shelter has the following unadopted pets:"
    self.unadopted.each_key {|pet| puts pet}
    puts ""
  end
  
  def print_adoptions
    self.owners.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.pets.each { |pet| puts pet }
      puts ""
    end
  end
end

class Pet
  attr_reader :name, :species
  
  def initialize(species, name)
    @species = species
    @name = name
  end
  
  def to_s
    "a #{species} named #{name}"
  end
end

class Owner
  attr_accessor :pets, :number_of_pets
  attr_reader :name
  
  def initialize(name)
    @name = name
    @pets = []
    @number_of_pets = 0
  end
  
  def add_pet(pet)
    self.pets << pet
    self.number_of_pets += 1
  end
end


butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.take_in(butterscotch)
shelter.take_in(pudding)
shelter.take_in(darwin)
shelter.take_in(kennedy)
shelter.take_in(sweetie)
shelter.take_in(molly)
shelter.take_in(chester)

shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
# shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
# shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_unadopted
shelter.print_adoptions
p shelter.unadopted
# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."