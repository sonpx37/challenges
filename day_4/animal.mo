import Nat "mo:base/Nat";
import Text "mo:base/Text";

module {
  public type Animal = {
    speice : Text;
    energy : Nat;
  };

  // Challenge 3
  public func animal_sleep(a: Animal) : Animal {
    let newAnimal : Animal = {
      speice = a.speice;
      energy = a.energy + 10;
    };
    return newAnimal;
  };
}