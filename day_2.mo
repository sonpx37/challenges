import Array "mo:base/Array";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";

actor {
    // Challenge 1
    public func nat_to_nat8(n : Nat) : async Nat8 {
      if(n > 255) {
        return 255;
      };
      return (Nat8.fromNat(n));
    };

    // Challenge 2
    public func max_number_with_n_bits(n : Nat) : async Nat {
      return (( 2 ** n) - 1);
    };
    
    // Challenge 3
    public func decimal_to_bits(n : Nat) : async Text {
      var binary_representation : Text = "";
      var devider : Nat = n;
      while (devider > 0) {
        binary_representation := Text.concat(Nat.toText(devider % 2), binary_representation );
        devider := devider / 2;
      };
      return binary_representation;
    };

    // Challenge 4
    public func capitalize_character  ( c : Char ) : async Text {
      let upperToLowerAscii : Nat32 = 32;
      let letterInUnicode : Nat32 = Char.toNat32(c);
      var newChar : Char = c;
      
      if (Char.isLowercase(c)) {
        var capLetter : Nat32 = letterInUnicode - upperToLowerAscii;
        newChar := Char.fromNat32(capLetter);
      };
      
      return Char.toText(newChar);
    };

    // Challenge 5
    public func capitalize_text(input : Text) : async Text {
      var upperCaseText = "";
      for (c in input.chars()) {
        if(Char.isLowercase(c)) {
          var upperChar : Text = await capitalize_character(c);
          upperCaseText := upperCaseText # upperChar;
        } else {
          upperCaseText := upperCaseText # Char.toText(c);
        }
      };

      return upperCaseText;
    };

    // Challenge 6
    public func is_inside ( t : Text, c : Char) : async Bool {
      // Different Way : Use contains method of Text 
      for (char in t.chars()) {
        if (Char.equal(char, c)) {
          return true;
        };
      };
      return false;
    };

    // Challenge 7
    public func trim_whitespace(t: Text) : async Text {
      return Text.trim(t, #text " ");
    };

    // Challenge 8
    public func duplicated_character(t: Text) : async Text {
      var arrText : [Char] = Iter.toArray(t.chars());
      var size : Nat = arrText.size();
      for(i in Iter.range(0, size - 1)){
        for(j in Iter.range(i + 1, size - 1)){
          if(arrText[i] == arrText[j]){
            return Char.toText(arrText[j]);
          } 
        };
      };
      return t;
    };

    // Challenge 9 
    public func size_in_bytes ( t : Text) : async Nat {
      return Text.encodeUtf8(t).size();
    };


    // Challenge 10
    public func bubble_sort (arr : [Nat]) : async [Nat]{
      var tmpArr : [var Nat] = Array.thaw(arr);
      var length : Nat = tmpArr.size();

      for (i in Iter.range(0, length - 2)) {
        for(j in Iter.range( 0, length - i - 2)) {
          if(tmpArr[j] > tmpArr[j+1]) {
            // swap
            var temp : Nat = tmpArr[j];
            tmpArr[j] := tmpArr[j+1];
            tmpArr[j+1] := temp;
          };
        };
      };

      return Array.freeze(tmpArr);
    };
}