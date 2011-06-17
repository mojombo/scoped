README for scoped
=================





SINGLE

Service.new('abc', '123')

person = Person.find('Mike')
#=> Mike Davis

address = person.address
#=> 55 Main St






MULTIPLE

alpha = Service.new('abc', '123')
beta = Service.new('xxx', '999')

alpha.account do
  person = Person.find('Mike')
  #=> Mike Davis

  address = person.address
  #=> 55 Main St
end

beta.account do
  person = Person.find('Mike')
  #=> Mike Johnson

  address = person.address
  #=> 22 Awesome Ave
end