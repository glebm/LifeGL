unit CFunctions;

interface

uses
  SysUtils,xdfUtils;

// Decimal Separator update by Glex, 2008
// (C) Clinton R. Johnson January 27, 1999.
//
// see accompanying readme.txt for terms and conditions of use.
//
// You may freely re-use and re-distribute this source code.
//

//*****************************************************************************
// Returns true if ch is either a letter of the english  alphabet or a digit.
Function isalnum(ch : Char) : Boolean;
//*****************************************************************************
// Returns true if ch is a letter of the english alphabet.
Function isalpha(ch : Char) : Boolean;
//*****************************************************************************
// Retunrs true if ch if between #0 and #$1f, or is #$7f
Function iscntrl(ch : Char) : Boolean;
//*****************************************************************************
// Returns true if ch is a digit (0 through 9)
Function isdigit(ch : Char) : Boolean;
//*****************************************************************************
// Returns true if ch any printable character other than a space.
Function isgraph(ch : Char) : Boolean;
//*****************************************************************************
// Returns true if ch is a lower case letter of the english alphabet.
Function islower(ch : Char) : Boolean;
//*****************************************************************************
// Returns true if ch a printable character, including a space (generally, #$20
// to #$7E, see isspace for exceptions)
Function isprint(ch : Char) : Boolean;
//*****************************************************************************
// Returns true if ch is a punctuation character, excluding the space.
// PUNCTUATION is defined by this function as all printable characters which are
// not alphanumeric or a space.
Function ispunct(ch : Char) : Boolean;
//*****************************************************************************
// Returns true if ch is a space, tab or newline character (#$20,#$9,#$A,#$D)
Function isspace(ch : Char) : Boolean;
//*****************************************************************************
// Returns true if ch is an upper case letter of the english alphabet.
Function isupper(ch : Char) : Boolean;
//*****************************************************************************
// Returns true if ch is a hexideciman digit. (A-F,a-f,0-9)
Function isxdigit(ch : Char) : Boolean;

//*****************************************************************************
// Warning : My document writing skills are a little rusty.  Any C or C++
// reference provides excellent documentation for the scanf function.  There
// are only a few differences between the C and C++ implementation, and this
// implementation for Delphi.
//
// sscanf is a data parsing procedure.  It reads data from DATA, and places the
// values into arguments passed in ARGS.  Format is a series of format specifiers
// that indicate how to parse data from DATA.
//
//
// Format :
//          Format Specifiers
//          White space characters
//          Non White Space characters.
//
// Format Specifiers :
//
// Format specifiers start with a %, contain an optional storage specifier, an
// optional width specifier, and a field type specifier.  Strings and characters
// also have a additional SET specifer.  Text in the format string, which is not a
// format specifier, is LITTERAL text.  It must match exactly, AND IS CASE SENSITIVE.
//
// The only exception for format specifiers is %%, which matches a litteral % instead of
// indicating a format specifier.
//
//    Storage specifier :   *  - If * is included in the  format specifier, the
//                               field is parsed, checked for type but is not
//                               stored.
//    Width Specifier :     123 - If a numeric value is included between the
//                                % and the type specifier, the value indicates
//                                the maximum length of the data read from the
//                                string.  For character types, it is expected
//                                that the pointer passed points at an array
//                                large enough to hold the data.
//
//    Set Specifier :  [ab-c]  - A set of characters which are acceptable in
//                               the string or char.  This overrides the normal white
//                               space detection used to indicate the end of a string or
//                               array of chars.
//                               Set members are listed without break.
//                               Ranges can be indicated with a hyphen.  Ranges MUST be
//                               presented in accending order (a-z is valid, z-a is NOT).

//                               *** UNLIKE C, \ is used to indicate a litteral character.
//                               \[ - [
//                               \\ - \
//                               \] - ]
//                               \- - -
//
//                               Dashes which are the first or last character of
//                               the set are interpreted litterally as a member of the set.
//
//                               If the first character of the set is a ^, then the set is
//                               inverted and members are EXCLUDED from the set.
//
//                               ie :
//                                   []     DEFAULT SET- Accepts anything except whitespace.
//                                   [abc]  accepts a, b or c.
//                                   [^abc] accepts anything EXCEPT a,b or c.
//                                   [^]    accepts anything.  ** NOTE, this differs from C,C++.
//                                   [a-cA-C]  Accepts a,b,c,A,B, or C
//
//                               WARNING : SETS ARE CASE SENSITIVE.
//
//                               NOTE : C and C++ use the %[] format without type specifier
//                                      implies a CHAR type.  FOR THIS IMPLEMENTATION,
//                                      NO TYPE SPECIFIER IMPLIES A STRING TYPE.  The only
//                                      other valid specifer is c for char.
//                               ie :
//                                     %[abc]    -> String set
//                                     %[abc]c   -> char set, width of 1.
//                                     %4[abc]c  -> char set, max width of 4.
//                                     %[abc]s   -> String set, followed by a litteral s.
//
//  TYPE SEPECIFIERS

// Type + Data Type     + REQUIRED DATA TYPE
// -----+---------------+-------------------
//   c  | Char          | char
//   d  | INTEGER       | Integer (32 bit, signed)
//   e  | Extended      | Extended
//   f  | Extended      | Extended
//   g  | Extended      | Extended
//   h  | ShortInt      | ShortInt (16 bit, signed)
//   i  | Integer       | Int64 (64 bit, signed)
//   m  | Money         | Currency (may not contain currency symbol, must use standard +- sign indications)
//   n  | Number Read   | Integer -> Returns the # of chars read from DATA so far.
//   p  | Pointer       | Pointer  (32 bit pointer always)
//   s  | String        | Ansistring or shortstring
//   u  | Unsigned      | Cardinal  (32bit)
//   x  | Hex           | Integer or Cardinal (32bit value)
//
//  Integers can be Hex values.  Hex values can start with $ or 0x.  HEx values read with
// the %x format specifier do not need a leading $ or 0x, but it is accepted.
//
// ARGUMENTS
//                               All variables, with the exception of shortstrings are passed
//                               by reference (pointers).  This means that the risk of
//                               data corruption is high.  You must be absolutely sure you are
//                               passing a pointer to the correct data type, otherwise data
//                               corruption is likely.  (ie : passing a pointer to a Integer, when
//                               the return result is an array of 20 characters, or an extended).
//
//                               In order to pass a variable by refrence, preceed the variable
//                               name with an @ sign.
//
//                               ie :
//
//                               Var S1,S2 : String; i1 : Integer;
//
//                                    sscanf('Hello, World! 22','%s%s',[@s1,@s2,@i1])
//
//                               NOTE : It is highly recommended that you always use ANSIStrings
//                                      instead of ShortStrings.
//
//                               NOTE : NEVER pass shortstrings by reference, pass the variable
//                                      without a preceeding @.
//
//                               Var S1 : ShortString; S2 : String;
//
//                                    sscanf('Hello, World!','%s%s',[s1,@s2])
//
// Returns :  The # of results successfully returned.  Unlike C and C++, this implementation
//            never returns EOF (-1).
//
Function sscanf(Data : String; Format : String; Const Args : Array Of Const) : Integer;

//*****************************************************************************
// returns the upper case english alphabet equivalent of ch.
Function toupper(ch : Char) : Char;
//*****************************************************************************
// returns the lower case english alphabet equivalent of ch.
Function tolower(ch : Char) : Char;

implementation

Const
  WhiteSpace : Set of Char = [#32,#8,#13,#10];

Type
  TFieldType = (ftChar,ftSmallInt,ftInteger,ftInt64,ftFloating,ftCurrency,ftString,ftHex,ftPointer,ftCount,ftUnsigned,
                ftLitteral,ftWhiteSpace);


Function isalnum(ch : Char) : Boolean;

Begin
  Result := isalpha(ch) or isdigit(ch);
End;

Function isalpha(ch : Char) : Boolean;

Begin
  Result := islower(ch) or isupper(ch);
End;

Function iscntrl(ch : Char) : Boolean;

Begin
  Result := ch in [#$00..#$1f,#$7f];
End;

Function isdigit(ch : Char) : Boolean;

Begin
  Result := ch in ['0'..'9'];
End;

Function isgraph(ch : Char) : Boolean;

Begin
  Result := ch in [#$21..#$7e];
End;

Function islower(ch : Char) : Boolean;

Begin
  Result := ch in ['a'..'z'];
End;

Function isprint(ch : Char) : Boolean;

Begin
  Result := ch in [#$20..#$7e];
End;

Function ispunct(ch : Char) : Boolean;

Begin
  Result := isprint(ch) And (not (isspace(ch) or isalnum(ch)));
End;

Function isspace(ch : Char) : Boolean;

Begin
  Result := ch in whitespace;
End;

Function isupper(ch : Char) : Boolean;

Begin
  Result := ch in ['A'..'Z'];
End;

Function isxdigit(ch : Char) : Boolean;

Begin
  Result := ch in ['0'..'9','a'..'f','A'..'F'];
End;

Function toupper(ch : Char) : Char;

Begin
  Result := upcase(ch);
End;

Function tolower(ch : Char) : Char;

Begin
  Result := ch;
  If isAlpha(ch) Then
  Begin
    Result := Char(Byte(Upcase(ch))+(Byte('a')-Byte('A')));
  End;
End;

Function GetToken(Str : String; Var At : Integer) : Char;

Begin
  If At<=Length(Str) Then
  Begin
    Result := Str[At];
    Inc(At);
  End
  Else
  Begin
    At := Length(Str)+1;
    Raise Exception.Create('Bad format string');
  End;
End;

Function PeekToken(Str : String; Var At : Integer) : Char;

Begin
  If (At<=Length(Str)) Then
  Begin
    Result := Str[At];
  End
  Else
  Begin
    Result := #0;
  End;
End;

Function GetScanfToken(Format : String; Var At : Integer) : String;

Var
  Token                 : Char;
  TokenDone             : Boolean;
  BuildingSet           : Boolean;

Begin
  Token := GetToken(Format,At);
  If (Token='%') Then
  Begin
    Result := Token;
    BuildingSet := False;
    TokenDone := False;
    Repeat
      Token := GetToken(Format,At);
      Result := Result+Token;
      If (Token='\') And (BuildingSet) Then
      Begin
        Token := GetToken(Format,At);
        Result := Result+Token;
      End Else If (Token='[') Then
      Begin
        BuildingSet := True;
      End Else If (Token=']') Then
      Begin
        BuildingSet := False;
        Token := PeekToken(Format,At);
        If Token In ['C','c'] Then
        Begin
          Token := GetToken(Format,At);
          Result := Result+Token;
        End;
        TokenDone := True;
      End Else If (Token In ['*','0'..'9']) Or BuildingSet Then
      Begin
        // Data is accepted and added to the tag.
      End Else
      Begin
        TokenDone := True;
      End;
    Until TokenDone;
  End
  Else
  Begin
    Result := Token;
    While (Token In WhiteSpace) Do
    Begin
      Token := PeekToken(Format,At);
      If (Token In WhiteSpace) Then
      Begin
        Token := GetToken(Format,At);
      End;
    End;
  End;
End;

Procedure InterpretScanToken(ScanToken : String;
                             Var FieldType : TFieldType;
                             Var FieldWidth : Integer;
                             Var CharSet : TCharSet;
                             Var Stored : Boolean);

Var
  TokenChar             : Char;
  At                    : Integer;
  EndAt                 : Integer;
  Frag                  : String;
  Token                 : Char;

Begin
  CharSet := [];
  If (Copy(ScanToken,1,1)='%') Then
  Begin
    Delete(ScanToken,1,1);
    TokenChar := ScanToken[Length(ScanToken)];
    If (TokenChar<>']') Then
    Begin
      Delete(ScanToken,Length(ScanToken),1);
    End
    Else
    Begin
      TokenChar := 's';
    End;
    At := Pos('[',ScanToken);
    If (At<>0) Then
    Begin
      EndAt := At;
      Token := GetToken(ScanToken,EndAt);
      While (Token<>']') Do
      Begin
        Token := GetToken(ScanToken,EndAt);
        If (Token='\') Then
        Begin
          Token := GetToken(ScanToken,EndAt);
          if (Token=']') Then Token := #0; // Skip Litteral ]'s.
        End;
      End;
      Dec(EndAt);
      Frag := Copy(ScanToken,At+1,EndAt-At-1);
      Delete(ScanToken,At,EndAt-At+1);
      CreateSet(Frag,CharSet);
    End
    Else
    Begin
      CharSet := [];
    End;
    At := Pos('*',ScanToken);
    Stored := (At=0);
    If Not Stored Then
    Begin
      Delete(ScanToken,At,1);
    End;
    If (ScanToken<>'') Then
    Begin
      Try
        FieldWidth := StrToInt(ScanToken);
      Except
        Raise Exception.Create('Bad format string');
      End;
    End
    Else
    Begin
      FieldWidth := -1;
    End;
    Case TokenChar Of
      'c'               : Begin
                            FieldType := ftChar;
                            If (FieldWidth=-1) Then
                            Begin
                              FieldWidth := 1;
                            End;
                          End;
      'd'               : Begin
                            FieldType := ftInteger;
                            CharSet := ['0'..'9','-'];
                          End;
      'e','f','g'       : Begin
                            FieldType := ftFloating;
                            CharSet := ['0'..'9','.','+','-','E','e', DecimalSeparator];
                          End;
      'i'               : Begin
                            FieldType := ftInt64;
                            CharSet := ['0'..'9','-'];
                          End;
      'h'               : Begin
                            FieldType := ftSmallInt;
                            CharSet := ['0'..'9','-'];
                          End;
      'm'               : Begin
                            FieldType := ftCurrency;
                            CharSet := ['0'..'9','-'];
                          End;
      's'               : Begin
                            FieldType := ftString;
                          End;
      'x'               : Begin
                            FieldType := ftHex;
                            CharSet := ['0'..'9','$','x','X','-'];
                          End;
      'p'               : Begin
                            FieldType := ftPointer; // All pointers are 32 bit.
                            CharSet := ['0'..'9','$','x','X','-'];
                          End;
      'u'               : Begin
                            FieldType := ftUnsigned;
                            CharSet := ['0'..'9'];
                          End;
      '%'               : Begin
                            FieldType := ftLitteral;
                            If (FieldWidth<>-1) Or (Not Stored) or (CharSet<>[]) Then
                            Begin
                              Raise Exception.Create('Bad format string');
                            End;
                            Stored := False;
                          End;
    Else
      Raise Exception.Create('Bad format string');
    End;
  End
  Else
  Begin
    If (ScanToken[1] In WhiteSpace) Then
    Begin
      FieldType := ftWhiteSpace;
      FieldWidth := -1;
      Stored := False;
      CharSet := [];
    End
    Else
    Begin
      FieldType := ftLitteral;
      FieldWidth := Length(ScanToken);
      Stored := False;
      CharSet := [];
    End;
  End;
End;

Function GetDataToken(Data : String; Var DataAt : Integer; Var OutOfData : Boolean;
                      FieldType : TFieldType; FieldWidth : Integer;
                      CharSet : TCharSet) : String;

Var
  Token                 : Char;

Begin
  OutOfData := False;
  Result := '';
  If (FieldType=ftChar) Then
  Begin
    Try
      GetToken(Data,DataAt);
    Except
      OutOfData := True;
      Exit; // Hit End of string.
    End;
  End
  Else
  Begin
    Token := #32;
    While (Token In WhiteSpace) Do
    Begin
      Try
        Token := GetToken(Data,DataAt);
      Except
        OutOfData := True;
        Exit; // Hit End of string.
      End;
    End;
    If (FieldType=ftWhiteSpace) Then
    Begin
      Dec(DataAt);  // Unget the last token.
      Exit;
    End;
  End;

  If (CharSet=[]) Then
  Begin
    CharSet := [#0..#255];
    If (FieldType<>ftChar) Then
    Begin
      CharSet := CharSet-WhiteSpace;
    End;
  End;

  Dec(DataAt);  // Unget the last token.
  While ((FieldWidth=-1) Or (Length(Result)<FieldWidth)) Do // Check Length
  Begin
    Token := PeekToken(Data,DataAt);
    If (Token In CharSet) Then
    Begin
      Try
        Token := GetToken(Data,DataAt);
        Result := Result+Token;
      Except
        Break;
      End;
    End
    Else
    Begin
      Break;
    End;
  End;
End;

Function CheckFieldData(Data : String; FieldType : TFieldType) : Boolean;

Begin
  Try
    Case FieldType Of
//      ftChar            : Begin End;
      ftSmallInt        : StrToInt(Data);
      ftInteger         : StrToInt(Data);
      ftInt64           : StrToInt64(Data);
      ftFloating        : StrToFloat(Data);
      ftCurrency        : StrToFloat(Data);
//      ftString          : Begin End;
      ftHex             : Begin
                            If (AnsiUpperCase(Copy(Data,1,2))='0X') Then Delete(Data,1,2);
                            If (Copy(Data,1,1)<>'$') Then Data := '$'+Data;
                            StrToInt(Data)
                          End;
      ftPointer         : StrToInt(Data);
//      ftCount           : Begin End;
      ftUnsigned        : StrToInt64(Data);
    End;
    Result := True;
  Except
    Result := False;
  End;
End;

Function StoreData(Data : String; FieldType : TFieldType; FieldWidth : Integer;
                   DataAt : Integer; P : Pointer; VType : Integer) : Boolean;

Begin
  Try
    Case FieldType Of
      ftChar            : Begin
                            Move(Data[1],P^,FieldWidth);
                          End;
      ftSmallInt        : SmallInt(P^) := StrToInt(Data);
      ftInteger         : Integer(P^) := StrToInt(Data);
      ftInt64           : Int64(P^) := StrToInt64(Data);
      ftFloating        : Extended(P^) := StrToFloat(Data);
      ftCurrency        : Currency(P^) := StrToFloat(Data);
      ftString          : Begin
                            If (VType=vtString) Then
                            Begin
                              ShortString(P^) := Data;
                            End
                            Else
                            Begin
                              String(P^) := Data;
                            End;
                          End;
      ftHex             : Begin
                            If (AnsiUpperCase(Copy(Data,1,2))='0X') Then Delete(Data,1,2);
                            If (Copy(Data,1,1)<>'$') Then Data := '$'+Data;
                            Integer(P^) := StrToInt(Data)
                          End;
      ftPointer         : Integer(P^) := StrToInt(Data);
      ftCount           : Begin
                          End;
      ftUnsigned        : Cardinal(P^) := (StrToInt64(Data) And $ffffffff);
    End;
    Result := True;
  Except
    Result := False;
  End;
End;

Function sscanf(Data : String; Format : String; Const Args : Array Of Const) : Integer;

Var
  At                    : Integer;
  DataAt                : Integer;
  Results               : Integer;
  ScanToken             : String;
  StringToken           : String;
  FieldType             : TFieldType;
  FieldWidth            : Integer;
  CharSet               : TCharSet;
  Stored                : Boolean;
  OutOfData             : Boolean;

  P                     : Pointer;

Begin
  At := 1;
  DataAt := 1;
  Results := 0;

  While At<=Length(format) Do
  Begin
    Try
      ScanToken := GetScanfToken(Format,At);
      InterpretScanToken(ScanToken,FieldType,FieldWidth,CharSet,Stored);
    Except
      Break;
    End;
    if (FieldType<>ftCount) Then
    Begin
      StringToken := GetDataToken(Data,DataAt,OutOfData,FieldType,FieldWidth,CharSet);
    End;

    If (FieldType=ftLitteral) Then
    Begin
      If (StringToken<>ScanToken) Then
      Begin
        Break;
      End;
    End;

    If (Not OutOfData) Then
    Begin
      If Not CheckFieldData(StringToken,FieldType) Then Break;
      If Stored Then
      Begin
        If (Results+Low(Args))>High(Args) Then
        Begin
          Raise Exception.Create('Insufficent pointers for format specifiers!');
        End;
        P := Args[Results+Low(Args)].VPointer;
        StoreData(StringToken,FieldType,FieldWidth,DataAt,P,Args[Results+Low(Args)].VType);
        Inc(Results);
      End;
    End;
  End;
  Result := Results;
End;


end.
