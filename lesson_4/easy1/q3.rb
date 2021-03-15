=begin

When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

The String passed to `puts` statement on `line 3` contains the string interpolation of `self.class`. `self.class` returns the name of the class it is called on, so when `small_car.go_fast` is called, .class is called on `small_car`, which is of the Car class. Therefore "Car" is printed.

LS answer:
We use self.class in the method and this works the following way:

- self refers to the object itself, in this case either a Car or Truck object.
- We ask self to tell us its class with .class. It tells us.
- We don't need to use to_s here because it is inside of a string and is interpolated which means it will take care of the to_s for us.

=end