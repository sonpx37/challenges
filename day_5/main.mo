import Cycles "mo:base/ExperimentalCycles";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";

actor {
  // Challenge 1
  public shared({caller}) func is_anonymous() : async Bool {
    // return Principal.isAnonymous(caller);
    caller == Principal.fromText("2vxsx-fae");
  };

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

  public shared({ caller }) func delete_favorite_number() : () {
    favorite_number.delete(caller);
  };

  // Challenge 6
  public func deposit_cycles() : async Nat {
    let deposit_amount : Nat = 200;
    if(Cycles.available() < deposit_amount){
      return (0);
    };
    return (Cycles.accept(deposit_amount));
  };

  // Challenge 7 
  // public shared({ caller }) func withdraw_cycles(n : Nat) : async Nat  {
    
  // };

  // Challenge 8
  private stable var counter : Nat = 0;
  private stable var version_number : Nat = 0;

  public func increment_counter(n : Nat) : async Nat {
    counter += n;
    return counter;
  };

  public func clear_counter() : async Nat {
    counter := 0;
    return counter;
  };

  system func postupgrade() {
    version_number += 1;
  };

  public func version() : async Nat {
    return (version_number);
  };
}