unit uLifeSimulator;

interface

const
  ACCURACY = 100000000000;

type
  TDoubleMatrix = array of array of double;
  TBoundsType = (btDead = 0, btAlive = 1, btLinked = 2);
  TNeighbourhoodType = (ntMoore, ntVonNeumann);
  TLifeSimulator = class
    private
      FBoundsType: TBoundsType;
      fw, fh: integer;
      flvalue, frvalue: double;
      ff, buff: TdoubleMatrix;
      FGetCellState: function (x, y: integer): double of object;
      procedure SetCellState(x, y: integer; Value: double);
      procedure SetBoundsType(const Value: TBoundsType);
      procedure SetWidth(const Value: integer);
      procedure SetHeight(const Value: integer);
      procedure SetLValue(const Value: double);
      procedure SetRValue(const Value: double);
      function GetCellState(x, y: integer): double;
      function GetCellState_BT_0_1(x, y: integer): double;
      function GetCellState_BT_2(x, y: integer): double;
    public
      property f[x, y: integer]: double
        read GetCellState write SetCellState; default;
      property w: integer read fw write SetWidth;
      property h: integer read fh write SetHeight;
      property lvalue: double read flvalue write SetLValue;
      property rvalue: double read frvalue write SetRValue;
      property boundsType: TBoundsType read FBoundsType write SetBoundsType;
      function neighbours(const x, y, r: integer;
        neighbourhood: TNeighbourhoodType): double; overload;
      procedure SwapBuffers();
      procedure SetCellDirect(x, y: integer; state: double);
      constructor Create(const w, h: integer); overload;
      constructor Create(const w, h: Integer;
        const lvalue, rvalue: double); overload;
  end;

implementation


procedure TLifeSimulator.SetLValue(const Value: double);
begin
  flvalue := Value;
end;

procedure TLifeSimulator.SetRValue(const Value: double);
begin
  frvalue := Value;
end;

procedure TLifeSimulator.SetCellDirect(x, y: integer; state: double);
begin
  ff[x, y] := state;
end;

procedure TLifeSimulator.SwapBuffers();
var t: TdoubleMatrix;
begin
  t := ff;
  ff := buff;
  buff := t;
end;

procedure TLifeSimulator.SetHeight(const Value: Integer);
begin
//  if (Value > 0) and (Value = fh) then exit;
  if Value < 1 then begin
    setlength(ff, fw + 2, 2);
    setlength(buff, fw + 2, 2);
    fh := 0
  end
  else begin
    setlength(ff, fw + 2, Value + 2);
    setlength(buff, fw + 2, Value + 2);
    fh := Value;
  end;
  SetBoundsType(FBoundsType);
end;

procedure TLifeSimulator.SetWidth(const Value: Integer);
begin
//  if (Value > 0) and (Value = fw) then exit;
  if Value < 1 then begin
    setlength(ff, 2, fh + 2);
    setlength(buff, 2, fh + 2);
    fw := 0;
  end
  else begin
    setlength(ff, Value + 2, fh + 2);
    setlength(buff, Value + 2, fh + 2);   
    fw := Value;
  end;
  SetBoundsType(FBoundsType);
end;

procedure TLifeSimulator.SetCellState(x: Integer; y: Integer; Value: double);
begin
//
  if Value < lvalue then Value := lvalue;
  if Value > rvalue then Value := rvalue;
  if boundsType = btLinked then begin
    buff[1 + ((((x - 1) mod fw) + fw) mod fw)]
        [1 + ((((y - 1) mod fh) + fh) mod fh)] :=
          round((value * ACCURACY)) / ACCURACY;
    end
  else begin
    if (y > fh) or (x > fw) or (y < 1) or (x < 1)
    then
      exit
    else
      buff[x][y] := round((value * ACCURACY)) / ACCURACY;
    end;
end;

function TLifeSimulator.GetCellState(x: Integer; y: Integer): double;
begin
  result := FGetCellState(x, y);
end;

constructor TLifeSimulator.Create(const w: Integer; const h: Integer);
begin
  Self.w := w;
  Self.h := h;
  lvalue := 0;
  rvalue := 1;
  SetBoundsType(btDead);
end;

constructor TLifeSimulator.Create(const w, h: Integer;
  const lvalue, rvalue: double);
begin
  Self.w := w;
  Self.h := h;
  Self.lvalue := lvalue;
  Self.rvalue := rvalue;
  SetBoundsType(btDead);
end;

procedure TLifeSimulator.SetBoundsType(const Value: TBoundsType);
var i: integer;
begin
//  if FBoundsType = Value then exit;
  FBoundsType := Value;
  if FBoundsType in [btDead, btAlive] then begin
    for i := 0 to fw + 1 do begin
      if ff[i] = nil then exit;
      ff[i][0] := ord(FBoundsType <> btDead);
      ff[i][fh + 1] := ord(FBoundsType <> btDead);
      buff[i][0] := ord(FBoundsType <> btDead);
      buff[i][fh + 1] := ord(FBoundsType <> btDead);
    end;
    for i := 0 to fh + 1 do begin
      ff[0][i] := ord(FBoundsType <> btDead);
      ff[fw + 1][i] := ord(FBoundsType <> btDead);
      buff[0][i] := ord(FBoundsType <> btDead);
      buff[fw + 1][i] := ord(FBoundsType <> btDead);
    end;
    FGetCellState := GetCellState_BT_0_1;
  end
  else begin
    FGetCellState := GetCellState_BT_2;
  end;
end;


function TLifeSimulator.GetCellState_BT_0_1(x, y: integer): double;
begin

  if (y > fh) or (x > fw) or (y < 1) or (x < 1)
  then begin
    if boundsType = btAlive then begin
      result := rvalue
    end
    else begin
      result := lvalue;
    end;
  end
  else
    result := ff[x][y];
end;

function TLifeSimulator.GetCellState_BT_2(x, y: integer): double;
begin
  result := ff[1 + ((((x - 1) mod fw) + fw) mod fw)]
              [1 + ((((y - 1) mod fh) + fh) mod fh)];
end;

function TLifeSimulator.neighbours(const x, y, r: integer;
  neighbourhood: TNeighbourhoodType): double;
var i, j: integer;
	st: double;
begin
  result := 0;
  case neighbourhood of
    ntMoore:
      begin
        for i := x - r to x + r do begin
          for j := y - r to y + r do begin
            st := FGetCellState(i, j);
            result := result + st;
            end;
          end;
        result := result - FGetCellState(x, y);
      end;
    ntVonNeumann:
      begin
        for i := x - r to x + r do begin
          st := FGetCellState(i, y);
          result := result + st;
          end;
        for j := y - r to y + r do begin
          st := FGetCellState(x, j);
          result := result + st;
          end;
          result := result - 2 * FGetCellState(x, y);
      end;
  end;

  result := round((result * ACCURACY)) / ACCURACY;
//  if (st >= lowBound) and (st <= highBound) then dec(result);
end;


end.
