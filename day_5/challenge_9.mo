import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";

actor {
  // Challenge 9
  stable var entries : [(Principal, Nat)] = [];

  // Challenge 2
  let favorite_number = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

  // Challenge 3
  // public shared({caller}) func add_favorite_number(n :Nat): async ()) {
  //   favorite_number.put(caller, n);
  // };

  public shared({caller}) func show_favorite_number () : async ?Nat {
    return favorite_number.get(caller);
  };

  // Challenge 4
  public shared({caller}) func add_favorite_number(n: Nat) : async Text {
    let existing_n : ?Nat = favorite_number.get(caller);
    switch(existing_n){
        case(null){
          favorite_number.put(caller, n);
          return ("You've successfully registered your number");
        };
        case(_) {
          return ("You've already registered your number");
        };
    };
  };

  // Challenge 5
  public shared({ caller }) func update_favorite_number(n : Nat) : () {
    favorite_number.put(caller, n);
  };

  system func preupgrade() {
    entries := Iter.toArray(favorite_number.entries());
  };

  system func postupgrade() {
    entries := [];
  };

}