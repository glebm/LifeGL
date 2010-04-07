unit uHistoryDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, sBitBtn, ExtCtrls, sPanel, sSkinProvider,
  sGroupBox, Mask, sMaskEdit, sCustomComboEdit, sTooledit, Grids, ValEdit;

type
  TDLGHistory = class(TForm)
    sGroupBox1: TsGroupBox;
    sSkinProvider1: TsSkinProvider;
    sPanel5: TsPanel;
    BTNExportLog: TsBitBtn;
    BTNSaveLog: TsBitBtn;
    sFilenameEdit1: TsFilenameEdit;
    CheckBox1: TCheckBox;
    EDLog: TValueListEditor;
    BTNClearHistory: TsBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BTNClearHistoryClick(Sender: TObject);
  private

  public

  end;

  procedure updateHistory();
    
var
  DLGHistory: TDLGHistory;
  History: ^TStrings;
  
implementation

{$R *.dfm}

procedure updateHistory();
begin
  if Assigned(DLGHistory) then DLGHistory.EDlog.Strings := History^;  
end;

procedure TDLGHistory.BTNClearHistoryClick(Sender: TObject);
begin
  History^.Clear;
  EDLog.Strings := History^;
end;

procedure TDLGHistory.FormShow(Sender: TObject);
begin
  EDLog.Strings := History^;
end;

end.
