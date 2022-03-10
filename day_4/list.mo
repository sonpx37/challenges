import List "mo:base/List";

module {
  public type List<T> = ?(T, List<T>);
  
  // Challenge 7
  public func is_null<T>(l : List<T>) : Bool {
    switch l {
      case null { true };
      case _ { false };
    }
  };

  // Challenge 8
  public func last<T>(l : List<T>) : ?T {
    switch l {
      case null { null };
      case (?(x, null)) { ?x };
      case (?(_, t)) { last<T>(t) };
    };
  };

  //Challenge 9 : 
  public func size<T>(l : List<T>) : Nat {
    func recursion(l : List<T>, n : Nat) : Nat {
      switch l {
        case null { n; }
        case (?(_, t)) { recursion(t, n + 1); }
      };
    };
    recursion(l,0);
  };

   // Challenge 10
  public func get<T>(l : List<T>, n : Nat) : ?T{
    switch(n, l){
      case (_, null) { null };
      case (0, (?(h, t))) { ?h };
      case (_, (?(_, t))) { get<T>(t, n-1) };
    };
  };

  //Challenge 11 :
  public func reverse<T>(l : List<T>) : List<T> {
    func recursion(l : List<T>, r : List<T>) : List<T> {
      switch l {
        case null { r };
        case (?(h, t)) { recursion(t, ?(h, r)) };
      }
    };
    recursion(l, null)
  };

}