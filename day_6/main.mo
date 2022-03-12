import Array "mo:base/Array";
import Error "mo:base/Error";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";

import HTTP "http";
actor {
  // Challenge 1
  public type TokenIndex = Nat;
  public type Error = {
    #ok  : Text;
    #err : Text;
  };

  // Challenge 2
  let registry : HashMap.HashMap<TokenIndex, Principal> = HashMap.HashMap<TokenIndex, Principal>(0, Nat.equal, Hash.hash);
  stable var entries : [(TokenIndex, Principal)] = [];

  // Challenge 3
  stable var nextTokenIndex : Nat = 0;
  public shared({caller}) func mint() : async Result.Result<Text, Text>{
    switch(Principal.toText(caller) == "2vxsx-fae"){
      case true { 
        return #err("Error: because of anonymous principal");
      };
      case false { 
        registry.put(nextTokenIndex, caller);
        nextTokenIndex += 1;
        return #ok("Mint success !!")
      };
    };
  };

   // Challenge 4
  public func transfer(to: Principal, tokenIndex: Nat): async Result.Result<Text, Text>{
    let principal_ : ?Principal = registry.get(tokenIndex);
    switch(principal_){
      case (?_) {
        let before_princpal : ?Principal = registry.remove(tokenIndex);
        registry.put(tokenIndex, to);
        #ok("Transfer Success");
      };
      case (null) {
        #err("Transfer Error");
      };
    };
  };

  // Challenge 5
  public type List<TokenIndex> = ?(TokenIndex, List<TokenIndex>);

  public shared ({caller}) func balance() : async List<TokenIndex> {
    var tokens = List.nil<TokenIndex>();
    for ((token_idx, principal) in registry.entries()) {
      if (Principal.equal(caller, principal)) {
        tokens := List.push<TokenIndex>(token_idx, tokens);
      };
    };
    return tokens;
  };

  // Challenge 6
  public query func http_request(request : HTTP.Request) : async HTTP.Response {
    let lastToken = registry.size(); // Nat
    let lastPrID = registry.get(lastToken - 1); // Principal
    let lastPrID1 = Option.get(lastPrID, Principal.fromText("2vxsx-fae"));

    let response = {
      body = Text.encodeUtf8("Token: " # Nat.toText(lastToken - 1) # ", Principal: " # Principal.toText(lastPrID1)) ;
      headers = [("Content-Type", "text/html; charset=UTF-8")];
      status_code = 200 : Nat16;
      streaming_strategy = null
    };
    return(response);
  };

  // Challenge 7
  system func preupgrade() {
    entries := Iter.toArray(registry.entries());
  };
  system func postupgrade() {
    entries := [];
  };
}