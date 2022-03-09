import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";

actor {
  
  // Challenge 1
  private func swap (arr : [var Nat], j : Nat, i: Nat) : [var Nat] {
    var swappedArr = arr;
    var tmp = swappedArr[j];
    swappedArr[j] := swappedArr[i];
    swappedArr[i] := tmp;
    return swappedArr;
  };

  // Challenge 2
  public func init_count(size : Nat) : async [Nat] {
    if (size == 0) {
      return [];
    };
    var arr : [var Nat] = Array.init<Nat>(size, 0);
    for(i in Iter.range(0, size - 1)) {
      arr[i] := i;
    };
    return Array.freeze(arr);
  };

  // Challenge 3
  public func seven(array : [Nat]) : async Text {
    for(value in array.vals()){
      if(value == 7) return ("Seven is found");
    };
    return ("Seven not found");
  };

  // Challenge 4
  public func nat_opt_to_nat(n : ?Nat, m : Nat): async ?Nat{
    if (n == null) { return ?m; };
    return n;
  };

  // Challenge 5
  public func day_of_the_week(n : Nat) : async ?Text {
    switch (n) {
      case 1 ?"Monday";
      case 2 ?"Tuesday";
      case 3 ?"Wednesday";
      case 4 ?"Thursday";
      case 5 ?"Friday";
      case 6 ?"Saturday";
      case 7 ?"Sunday";
      case default null;
    };
  };

  // Challenge 6
  public func populate_array(array : [?Nat]) : async [Nat]{
    return Array.map(array, func(i : ?Nat) : Nat{
      switch(i){
        case(null) 0;
        case(?i) i;
      };
    });
  };

  // Challenge 7
  public func sum_of_array(arr : [Nat]) : async Nat {
    return Array.foldRight(arr, 0, func(x: Nat, y: Nat) : Nat {
      x + y;
    });
  };

  // Challenge 8
  public func squared_array(arr : [Nat]) : async [Nat] {
    return Array.map(arr, func(x : Nat) : Nat {
      x ** 2;
    });
  };

  // Challenge 9
  public func increate_by_index(arr : [Nat]) : async [Nat] {
    return Array.mapEntries(arr, func(x : Nat, index: Nat) : Nat{
      x + index;
    });
  };

  // Challenge 10
  private func contains<A>(arr : [A], a : A, f : (A , A) -> Bool) : Bool{
    let newArr : [A] = Array.filter(arr, func(i: A) : Bool{
      f(a, i);
    });
    return (newArr.size() > 0);
  };
}