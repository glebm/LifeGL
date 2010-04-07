unit xdfUtils;

interface

Uses SysUtils;

//
// (C) Clinton R. Johnson January 27, 1999.
//
// see accompanying readme.txt for terms and conditions of use.
//
// You may freely re-use and re-distribute this source code.
//

Type
  TCharSet = Set Of Char;

//*****************************************************************************
// Converts a boolean to a T or an F.
Function BoolToStr(Condition : Boolean) : String;
//*****************************************************************************
// Creates a set of char from a set specifier.
//
//    Set Specifier :  'ab-c'  - A set is built from a source string.  It may contain
//                               a series or characters, or ranges.
//                               Series of characters are listed without break.
//                               Ranges can be indicated with a hyphen.  Ranges MUST be
//                               presented in accending order (a-z is valid, z-a is NOT).
//                               You must use the '\' to indicate litteral characters,
//                               This allows you to include the hypen character anywhere
//                               without indiciating a range.
//
//                               '\\' -> '\'
//                               '\-' -> '-'
//
//                               Dashes which are the first or last character of
//                               the set are interpreted litterally as a member of the set.
//
//                               If the first character of the set is a ^, then the set is
//                               inverted and members are EXCLUDED from the set.
//
//                               ie :
//                                   ''     DEFAULT SET- Accepts anything except whitespace.
//                                   'abc'  accepts a, b or c.
//                                   '^abc' accepts anything EXCEPT a,b or c.
//                                   '^'    accepts anything.  ** NOTE, this differs from C,C++.
//                                   'a-cA-C'  Accepts a,b,c,A,B, or C
//                                   'abc\-\\0-9' Accepts a,b,c,-,\,0,1,2,3,4,5,6,7,8,9
//
//                               WARNING : SETS ARE CASE SENSITIVE.
//
Procedure CreateSet(Source : String; Var ResultSet : TCharSet);

//*****************************************************************************
// These overloaded functions are meant to simulate the ? : operators of C.
//
Function ifOp(Condition : Boolean; IfTrue : Integer; IfFalse : Integer) : Integer; Overload;
Function ifOp(Condition : Boolean; IfTrue : Int64; IfFalse : Int64) : Int64; Overload;
Function ifOp(Condition : Boolean; IfTrue : Boolean; IfFalse : Boolean) : Boolean; Overload;
Function ifOp(Condition : Boolean; IfTrue : String; IfFalse : String) : String; Overload;
Function ifOp(Condition : Boolean; IfTrue : Extended; IfFalse : Extended) : Extended; Overload;
Function ifOp(Condition : Boolean; IfTrue : TObject; IfFalse : TObject) : TObject; Overload;
//*****************************************************************************
// Used to determine if S in in a list of strings.  The comparison is Case sensitive
// by default.
Function InStringList(Const S : String; Const Args : Array Of String; CaseInsensitive : Boolean =False) : Boolean;
//*****************************************************************************
// Converts a string (T,True,Y,Yes,1 or F,False,N,No,0) to a boolean value.
// if the string contains an invalid value, an exception is raised.
Function StrToBool(Const S : String) : Boolean;
//*****************************************************************************
// Converts a string (T,True,Y,Yes,1 or F,False,N,No,0) to a boolean value.
// if the string contains an invalid value, the result is assigned to default,
// and no exception is raised.
Function StrToBoolDef(Const S : String; Default : Boolean) : Boolean;

implementation

ResourceString
  sInvalidBoolean = '''%s'' is not a valid boolean value.';

Function BoolToStr(Condition : Boolean) : String;

Begin
  Result := IfOp(Condition,'T','F');
End;

Procedure CreateSet(Source : String; Var ResultSet : TCharSet);

Var
  At                    : Integer;

function GetToken(IsLitteral : Boolean=false) : Char;

Begin
  If (At<=Length(Source)) Then
  Begin
    Result := Source[At];
    Inc(at);
    If (Not IsLitteral) Then
    Begin
      If (Result='\') Then  // Litteral character.
      Begin
        Result := GetToken(True);
      End;
// Provides support for embeded control characters with the standard Pascal ^a format.
// Removed because ^ has a special meaning for scanf sets.  Kept for future reference.
(*      Else If (Result='^') Then
      Begin
        Result := UpCase(GetToken(True));
        If Not (Result in [#64..#95]) Then
        Begin
          Raise Exception.Create('BAD SET : '+Source);
        End;
        Result := Char(Byte(Result)-64);
      End; *)
    End;
  End
  Else
  Begin
    Raise Exception.Create('BAD SET : '+Source);
  End;
End;

Var
  Token                 : Char;
  EndToken              : Char;
  LoopToken             : Char;
  Negate                : Boolean;

Begin
  ResultSet := [];
  At := 1;
  Negate := (Copy(Source,1,1)='^');
  If Negate Then
  Begin
    Delete(Source,1,1);
    ResultSet := [#0..#255];
  End;
  While (At<=Length(Source)) Do
  Begin
    Token := GetToken;
    EndToken := Token;

    If (Copy(Source,At,1)='-') And (At<>Length(Source)) Then  // This is a range.
    Begin
      Inc(At,1);  // Go past dash.

      If At>Length(Source) Then
      Begin
        Raise Exception.Create('BAD SET : '+Source);
      End;
      EndToken := GetToken;
    End;

    If (EndToken<Token) Then  // Z-A is probably the result of a missing letter.
    Begin
      Raise Exception.Create('BAD SET : '+Source);
    End;

    For LoopToken := Token To EndToken Do
    Begin
      Case Negate of
        False : Include(ResultSet,LoopToken);
        True  : Exclude(ResultSet,LoopToken);
      End;
    End;
  End;
End;

Function ifop(Condition : Boolean; IfTrue : Integer; IfFalse : Integer) : Integer; Overload;

Begin
  If Condition Then Result := iftrue Else Result := ifFalse;
End;

Function ifop(Condition : Boolean; IfTrue : Int64; IfFalse : Int64) : Int64; Overload;

Begin
  If Condition Then Result := iftrue Else Result := ifFalse;
End;

Function ifOp(Condition : Boolean; IfTrue : Boolean; IfFalse : Boolean) : Boolean; Overload;

Begin
  If Condition Then Result := iftrue Else Result := ifFalse;
End;

Function ifOp(Condition : Boolean; IfTrue : String; IfFalse : String) : String ; Overload;

Begin
  If Condition Then Result := iftrue Else Result := ifFalse;
End;

Function IfOp(Condition : Boolean; IfTrue : Extended; IfFalse : Extended) : Extended; Overload;

Begin
  If Condition Then Result := iftrue Else Result := ifFalse;
End;

Function IfOp(Condition : Boolean; IfTrue : TObject; IfFalse : TObject) : TObject; Overload;

Begin
  If Condition Then Result := iftrue Else Result := ifFalse;
End;

Function InStringList(Const S : String; Const Args : Array Of String; CaseInsensitive : Boolean=False) : Boolean;

Var
  Loop                  : Integer;

Begin
  Result := False;
  For loop := Low(args) To High(Args) Do
  Begin
    If (CaseInsensitive And (AnsiCompareText(S,Args[Loop])=0)) Or (S=Args[Loop]) Then
    Begin
      Result := True;
      Break;
    End;
  End;
End;

Function StrToBool(Const S : String) : Boolean;

Begin
  If (InStringList(AnsiUpperCase(S),['1','True','T','Y','Yes'])) Then
  Begin
    Result := True;
  End Else If (InStringList(AnsiUpperCase(S),['0','False','F','N','No'])) Then
  Begin
    Result := False;
  End Else
  Begin
    Raise EConvertError.Createfmt(sInvalidBoolean,[S]);
  End;
End;

Function StrToBoolDef(Const S : String; Default : Boolean) : Boolean;

Begin
  Try
    Result := StrToBool(S);
  Except
    Result := Default;
  End;
End;

end.
