unit uDLGPreferences;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, sTreeView, StdCtrls, sGroupBox, sPageControl, sSkinProvider,
  Buttons, sBitBtn, sSpeedButton, sCheckBox, sRadioButton, sButton, sComboBox,
  sLabel, sEdit, sSpinEdit, sColorSelect, Mask, sMaskEdit, sCustomComboEdit,
  sTooledit;

type
  TDLGPreferences = class(TForm)
    sSkinProvider1: TsSkinProvider;
    pages: TsPageControl;
    sGroupBox1: TsGroupBox;
    categoriesTreeView: TsTreeView;
    TSVideo: TsTabSheet;
    sBitBtn1: TsBitBtn;
    sTabSheet1: TsTabSheet;
    sGroupBox2: TsGroupBox;
    RBCaptureScreen: TsRadioButton;
    RBCaptureFullState: TsRadioButton;
    GBRecordFromScreen: TsGroupBox;
    GBRecordFullState: TsGroupBox;
    EDFPS: TsSpinEdit;
    EDFrameSkip: TsSpinEdit;
    sLabel1: TsLabel;
    CBFullStateRenderer: TsComboBox;
    BTNApply: TsButton;
    sButton2: TsButton;
    sButton1: TsButton;
    sSpinEdit3: TsSpinEdit;
    EDDeadCellColor: TsColorSelect;
    EDAliveCellColor: TsColorSelect;
    EDFileName: TsFilenameEdit;
    sLabel2: TsLabel;
    CBCompressor: TsComboBox;
    EDFourCC: TsMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure categoriesTreeViewClick(Sender: TObject);
    procedure RBCaptureFullStateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BTNApplyClick(Sender: TObject);
    procedure CBFullStateRendererChange(Sender: TObject);
    procedure CBCompressorChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DLGPreferences: TDLGPreferences;

implementation
uses uMainForm;

{$R *.dfm}

procedure TDLGPreferences.categoriesTreeViewClick(Sender: TObject);
var i: integer;
begin
  TsTabSheet(categoriesTreeView.Selected.Data).PageControl.ActivePage :=
    categoriesTreeView.Selected.Data;
  Caption := 'Life - Preferences - ' + pages.ActivePage.Caption;
end;

procedure TDLGPreferences.CBCompressorChange(Sender: TObject);
begin
  EDFourCC.Enabled := (CBCompressor.ItemIndex = 3);
end;

procedure TDLGPreferences.CBFullStateRendererChange(Sender: TObject);
begin
  BTNApply.Enabled := true;
end;

procedure TDLGPreferences.RBCaptureFullStateClick(Sender: TObject);
var i: integer;
    b: boolean;
begin
  BTNApply.Enabled := true;
  b := RBCaptureFullState.Checked;
  for i := 0 to GBRecordFullState.ControlCount - 1 do
    GBRecordFullState.Controls[i].Enabled := b;
  GBRecordFullState.Enabled := b;
  b := not b;
  for i := 0 to GBRecordFromScreen.ControlCount - 1 do
    GBRecordFromScreen.Controls[i].Enabled := b;
  GBRecordFromScreen.Enabled := b;
end;

procedure TDLGPreferences.FormCreate(Sender: TObject);
var i: integer;
begin
  for i := 0 to pages.PageCount - 1 do
    categoriesTreeView.Items.AddChildObjectFirst(nil, pages.Pages[i].Caption,
    pages.Pages[i]);
end;

procedure TDLGPreferences.FormShow(Sender: TObject);
begin
  Caption := 'Life - Preferences - ' + pages.ActivePage.Caption;
  RBCaptureScreen.Checked := settings.recorder.captureType = ctScreen;
  RBCaptureFullState.Checked := settings.recorder.captureType = ctState;
  CBFullStateRenderer.ItemIndex := ord(settings.recorder.renderer);
  EDFPS.Value := settings.recorder.FPS;
  EDFrameSkip.Value := settings.recorder.frameSkip;
  EDDeadCellColor.ColorValue := settings.recorder.lValueColor;
  EDAliveCellColor.ColorValue := settings.recorder.rValueColor;
  EDFileName.Text := settings.recorder.filename;
  CBCompressor.ItemIndex := ord(settings.recorder.compressorType);
  EDFourCC.Enabled := (settings.recorder.compressorType = ctFourCC);
  EDFourCC.Text := settings.recorder.FourCC;
  BTNApply.Enabled := false;
end;

procedure TDLGPreferences.BTNApplyClick(Sender: TObject);
begin
  settings.recorder.captureType := TAVIRecorderSettingsCaptureType(
    RBCaptureFullState.Checked);
  settings.recorder.renderer := TAVIRecorderSettingsRenderer(
    CBFullStateRenderer.ItemIndex);
  settings.recorder.FPS := EDFPS.Value;
  settings.recorder.frameSkip := EDFrameSkip.Value;
  settings.recorder.lValueColor := EDDeadCellColor.ColorValue;
  settings.recorder.rValueColor := EDAliveCellColor.ColorValue;
  BTNApply.Enabled := false;
end;

end.
