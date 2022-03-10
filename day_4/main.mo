import Debug "mo:base/Debug";
import List "mo:base/List";

import Animal "animal";
import Custom "custom";

actor {

  // Challenge 1
  public type Student = Custom.Student;
  public func fun() : async Student {
    let stu : Student = {
      name = "Aric";
      age = 23;
      dob = "1999/02/03";
    };
    return stu;
  };

  // Challenge 2
  public type Animal = Animal.Animal;
  var animal : Animal = {
    speice = "testing"; 
    energy = 1;
  }; 
  Debug.print(animal.speice);

  // Challenge 4
  public func create_animal_then_takes_a_break(specie: Text, energy: Nat) : async Animal {
    var animal : Animal = {
      speice = specie; 
      energy = energy;
    };
    return Animal.animal_sleep(animal);
  };

  // Challenge 5
  public type List<Animal> = ?(Animal, List<Animal>);
  var animals_list = List.nil<Animal>();

  // Challenge 6
  public func push_animal(animal: Animal) : async () {
    animals_list := List.push(animal, animals_list);
  };

  public func get_animal(): async [Animal]{
    return List.toArray(animals_list);
  };
}