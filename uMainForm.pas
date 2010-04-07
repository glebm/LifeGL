{$A8,B-,C-,D-,E-,F-,G+,H+,I+,J-,K-,L-,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y-,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST ON}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
unit uMainForm;

interface

uses
  uLifeSimulator, uDLGPreferences, VectorGeometry, GLKeyboard,
  uPSCompiler, uResources, OpenGL1x, GLContext,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  AsyncTimer, Menus, AppEvnts, sDialogs, Dialogs,
  sHintManager, ImgList, SynEditExport, SynExportHTML, SynEditMiscClasses,
  SynEditRegexSearch, SynEditHighlighter, SynHighlighterPas, uPSComponent,
  GLAVIRecorder, ExtDlgs, GLBitmapFont, GLWindowsFont, sSkinProvider,
  sSkinManager, GLNavigator, ExtCtrls, GLTexture, GLCadencer, GLScene,
  GLHUDObjects, GLObjects, GLGraph, GLTilePlane, GLMisc, GLSkydome, ComCtrls,
  sStatusBar, SynEdit, SynMemo, sPageControl, StdCtrls, sRadioButton, sButton,
  sSpinEdit, sTabControl, sComboBox, sEdit, sCheckBox, Buttons, sSpeedButton,
  sColorSelect, sTrackBar, sBitBtn, sLabel, GLWin32Viewer, sPanel, sGroupBox,
  sMemo;
const INIFileName = 'life.ini';
type
  TAVIRecorderSettingsCaptureType = (ctScreen, ctState);
  TAVIRecorderSettingsRenderer = (rOpenGL, rSoftware);
  TAVIRecorderSettingsCompressorType = (ctMSVideo1, ctDivX, ctAsk, ctFourCC);
  TAVIRecorderSettings = record
    filename, FourCC: string;
    compressorType: TAVIRecorderSettingsCompressorType;
    captureType: TAVIRecorderSettingsCaptureType;
    renderer: TAVIRecorderSettingsRenderer;
    FPS, cellSize, frameSkip: integer;
    lValueColor, rValueColor: TColor;
    end;
  TAppearanceSettings = record
    xpThemes, vistaThemes, skins: boolean;
    skinName: string;
    end;
  TSettings = record
    appearance: TAppearanceSettings;
    recorder: TAVIRecorderSettings;
    end;
  TStateFunction = function(x, y: double): double;
  TMainForm = class(TForm)
    scene: TGLScene;
    GLCadencer1: TGLCadencer;
    GBSceneViewerBox: TsGroupBox;
    RighTsPanel: TsGroupBox;
    LeftPanel: TsGroupBox;
    sceneViewer: TGLSceneViewer;
    PNLSceneViewer: TsPanel;
    PNLControlsDesc: TsPanel;
    GLLightSource: TGLLightSource;
    GLTilePlane: TGLTilePlane;
    GLXYZGrid: TGLXYZGrid;
    DCSelection: TGLDummyCube;
    GLLines1: TGLLines;
    mlib: TGLMaterialLibrary;
    CBShowGrid: TsCheckBox;
    GroupBox2: TsGroupBox;
    EDGridColor: TsColorSelect;
    CBGridAA: TsCheckBox;
    GroupBox4: TsGroupBox;
    EDSceneViewerAA: TsComboBox;
    FPSTimer: TTimer;
    GLNavigator: TGLNavigator;
    GLUserInterface: TGLUserInterface;
    Button2: TsButton;
    EDGridLinesWidth: TsDecimalSpinEdit;
    GLCamera: TGLCamera;
    sGroupBox1: TsGroupBox;
    GroupBox1: TsGroupBox;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    GLFPSText: TGLHUDText;
    GLWindowsBitmapFont1: TGLWindowsBitmapFont;
    TBCells: TsTabControl;
    EDCellColorSelect: TsColorSelect;
    PackingTimer: TTimer;
    sGroupBox2: TsGroupBox;
    IMGCellTexture0: TImage;
    sGroupBox3: TsGroupBox;
    EDBackgroundType: TsComboBox;
    EDBackgroundColor: TsColorSelect;
    sGroupBox4: TsGroupBox;
    TreeMateriallib: TGLMaterialLibrary;
    MLBananaTree: TGLMaterialLibrary;
    IMGCellTexture1: TImage;
    CBTextureEnabled: TsCheckBox;
    LBLTextureInfo: TsLabel;
    PNLTextureImagesHolder: TsPanel;
    LBLClickHere: TsLabel;
    DLGLoadTexture: TsOpenPictureDialog;
    EDSunElevation: TsSpinEdit;
    EDTurbidity: TsSpinEdit;
    EDDayNightSpeed: TsSpinEdit;
    AVIRecorder: TAVIRecorder;
    RBScriptedRules: TsRadioButton;
    RBTotalisticRules: TsRadioButton;
    RBClassicRules: TsRadioButton;
    PCRulesSettings: TsPageControl;
    TSClassicRules: TsTabSheet;
    TSContinousCA: TsTabSheet;
    TSScriptedRules: TsTabSheet;
    EDRuleString: TsEdit;
    sPanel1: TsPanel;
    lblBirth: TsLabel;
    sPanel2: TsPanel;
    sLabel2: TsLabel;
    b0: TsSpeedButton;
    b1: TsSpeedButton;
    b2: TsSpeedButton;
    b4: TsSpeedButton;
    b3: TsSpeedButton;
    b5: TsSpeedButton;
    b6: TsSpeedButton;
    b8: TsSpeedButton;
    b7: TsSpeedButton;
    s0: TsSpeedButton;
    s2: TsSpeedButton;
    s1: TsSpeedButton;
    s3: TsSpeedButton;
    s4: TsSpeedButton;
    s6: TsSpeedButton;
    s5: TsSpeedButton;
    s7: TsSpeedButton;
    s8: TsSpeedButton;
    sAll: TsSpeedButton;
    bAll: TsSpeedButton;
    bNone: TsSpeedButton;
    sNone: TsSpeedButton;
    sPanel3: TsPanel;
    RecBtn: TsBitBtn;
    BTNPlay: TsBitBtn;
    sBitBtn3: TsBitBtn;
    sBitBtn4: TsBitBtn;
    LBLNaviControlsDescription: TsLabel;
    LBLRuleStringErrorTimer: TTimer;
    LBLRuleStringError: TsLabel;
    sButton1: TsButton;
    sButton2: TsButton;
    CBStars: TsCheckBox;
    CBTwinkle: TsCheckBox;
    BTNNext: TsBitBtn;
    GameTimer: TAsyncTimer;
    GLEarthSkyDome1: TGLEarthSkyDome;
    sGroupBox5: TsGroupBox;
    sPanel4: TsPanel;
    EDLifeWidth: TsSpinEdit;
    EDLifeHeight: TsSpinEdit;
    CBBoundsType: TsComboBox;
    GBCustomScript: TsGroupBox;
    PSScript: TPSScript;
    SynPasSyn1: TSynPasSyn;
    SynEditRegexSearch1: TSynEditRegexSearch;
    SynExporterHTML1: TSynExporterHTML;
    EDCustomScript: TSynMemo;
    SynEditPopupMenu1: TPopupMenu;
    Load1: TMenuItem;
    Save1: TMenuItem;
    Export1: TMenuItem;
    SaveLoadEtcImageList: TImageList;
    BTNScriptWindow1: TsBitBtn;
    sPanel5: TsPanel;
    BTNScriptRun: TsBitBtn;
    BTNExportScript1: TsBitBtn;
    BTNSaveScript1: TsBitBtn;
    BTNLoadScriptFromFile1: TsBitBtn;
    sHintManager1: TsHintManager;
    DLGSaveScript: TsSaveDialog;
    DLGLoadScript: TsOpenDialog;
    StatusBar: TsStatusBar;
    BTNHistory: TsBitBtn;
    DLGHTMLExport: TsSaveDialog;  
    Executescript1: TMenuItem;
    Switcheditormode1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    BTNOrtho: TsBitBtn;
    BTNCenter: TsBitBtn;
    sPanel6: TsPanel;
    sPanel7: TsPanel;
    Image2: TImage;
    TBZoom: TsTrackBar;
    Image1: TImage;
    rvisualsettingspanel: TsPanel;
    ContinousCARuleScriptGroupBox: TsGroupBox;
    EDContinousCA: TSynMemo;
    sPanel8: TsPanel;
    sBitBtn1: TsBitBtn;
    sBitBtn5: TsBitBtn;
    sBitBtn6: TsBitBtn;
    sBitBtn7: TsBitBtn;
    baseColorSelect: TsColorSelect;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Preferences1: TMenuItem;
    sPanel9: TsPanel;
    lvalueEdit: TsDecimalSpinEdit;
    rValueEdit: TsDecimalSpinEdit;
    DeltaTimeSpinEdit: TsDecimalSpinEdit;
    sBitBtn2: TsBitBtn;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    GLMemoryViewer1: TGLMemoryViewer;
    memcam: TGLCamera;
    sBitBtn8: TsBitBtn;
    procedure GLCadencer1Progress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure FormCreate(Sender: TObject);
    procedure GLDirectOpenGLRender(Sender: TObject;
      var rci: TRenderContextInfo);
    procedure sceneViewerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CBShowGridClick(Sender: TObject);
    procedure EDGridColorChange(Sender: TObject);
    procedure EDGridLinesWidthChange(Sender: TObject);
    procedure CBGridAAClick(Sender: TObject);
    procedure EDSceneViewerAAChange(Sender: TObject);
    procedure FPSTimerTimer(Sender: TObject);
    procedure EDBackgroundTypeChange(Sender: TObject);
    procedure EDBackgroundColorChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PackingTimerTimer(Sender: TObject);
    procedure TBCellsChange(Sender: TObject);
    procedure PNLTextureImagesHolderClick(Sender: TObject);
    procedure CBTextureEnabledClick(Sender: TObject);
    procedure EDCellColorSelectChange(Sender: TObject);
    procedure EDSunElevationChange(Sender: TObject);
    procedure EDTurbidityChange(Sender: TObject);
    procedure EDDayNightSpeedChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bAllClick(Sender: TObject);
    procedure sAllClick(Sender: TObject);
    procedure RBTotalisticRulesClick(Sender: TObject);
    procedure RBScriptedRulesClick(Sender: TObject);
    procedure RBClassicRulesClick(Sender: TObject);
    procedure RecBtnClick(Sender: TObject);
    procedure EDRuleStringChange(Sender: TObject);
    procedure LBLRuleStringErrorTimerTimer(Sender: TObject);
    procedure b1Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure CBTwinkleClick(Sender: TObject);
    procedure CBStarsClick(Sender: TObject);
    procedure EDLifeHeightChange(Sender: TObject);
    procedure BTNNextClick(Sender: TObject);
    procedure GameTimerTimer(Sender: TObject);
    procedure BTNPlayClick(Sender: TObject);
    procedure CBBoundsTypeChange(Sender: TObject);
    procedure BTNSaveScript1Click(Sender: TObject);
    procedure BTNHistoryClick(Sender: TObject);
    procedure BTNExportScript1Click(Sender: TObject);
    procedure BTNLoadScriptFromFile1Click(Sender: TObject);
    procedure BTNScriptRunClick(Sender: TObject);
    procedure PSScriptCompImport(Sender: TObject; x: TPSPascalCompiler);
    procedure PSScriptAfterExecute(Sender: TPSScript);
    procedure BTNScriptWindow1Click(Sender: TObject);
    procedure PNLSceneViewerResize(Sender: TObject);
    procedure EDCustomScriptKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure sceneViewerMouseEnter(Sender: TObject);
    procedure sPanel3Resize(Sender: TObject);
    procedure sceneViewerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BTNOrthoClick(Sender: TObject);
    procedure TBZoomMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TBZoomChange(Sender: TObject);
    procedure BTNCenterClick(Sender: TObject);
    procedure DeltaTimeSpinEditChange(Sender: TObject);
    procedure rValueEditChange(Sender: TObject);
    procedure lvalueEditChange(Sender: TObject);
    procedure sBitBtn7Click(Sender: TObject);
    procedure sBitBtn6Click(Sender: TObject);
    procedure sBitBtn5Click(Sender: TObject);
    procedure ContinousCARuleScriptGroupBoxDblClick(Sender: TObject);
    procedure GBSceneViewerBoxDblClick(Sender: TObject);
    procedure baseColorSelectChange(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Preferences1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    FBaseColor: TColor;
    procedure RecordAVI;
    procedure MLookDeactivate;
    procedure ClassicRulesUpd(const fromEdit: boolean);
    procedure SetState(i, j: integer; value: double);
    function GetState(i, j: integer): double;
    procedure AddToHistory(s: string);
    procedure SetBaseColor(color: TColor);
  protected
      procedure MouseMoved(var message: TMessage); message WM_MOUSEMOVE;
  public
    history: TStrings;
    mx, my : integer;
    tileX, tileY : integer;
    mip, translateOffset: TVector;
    daynightspeed: integer;
    life: TLifeSimulator;
    procedure SetVisualState(i, j: integer; value: double);
    property f[i, j: integer]: double read GetState write SetState;

    // Script Routines
    procedure ScriptCompile(const source: TStrings);
    procedure ScriptExecute();

    procedure NextClassic(n: integer);
    procedure LoadStarsFromString(const s: string);
    procedure nextContinous(n: integer);
    property baseColor: TColor read FBaseColor write SetBaseColor;

    procedure ReadSettings(const fn: string);
    procedure WriteSettings(const fn: string);
  end;

  // Script visible methods
  function density(x, y, r: integer): double;
  function neighbours(i, j, r: integer): double;
  procedure setCell(i, j: integer; value: double);
  function getCell(i, j: integer): double;
  procedure setCellDirect(i, j: integer; value: double);
  function getW(): integer;
  function getH(): integer;
  procedure next(ruleFunctionName: string);
  procedure fill(stateFunctionName: string);
  function exp(x: double): double;


var
  MainForm: TMainForm;
  zoomSpeed: integer = 0;
  deltaTime: double = 0.05;
  strrule: string;
  time: double = 0;
  recording: boolean = false;
  neighboursType: TNeighbourhoodType = ntMoore;
  mlook: boolean = false;
  setb, sets: set of byte;
  fw, fh: integer;
  settings: TSettings;

implementation
uses GLFile3DS, CFunctions, StrUtils, uHistoryDialog, IniFiles, TypInfo;

{$R *.dfm}

function exp(x: double): double;
begin
  result := System.exp(x);
end;


procedure TMainForm.ReadSettings(const fn: string);
var ini: TIniFile;
    rulesType: integer;
begin
  try
    ini := TIniFile.Create(fn);
    // [Life]
    EDLifeHeight.Value := ini.ReadInteger('Life', 'height', 99);
    EDLifeWidth.Value := ini.ReadInteger('Life', 'width', 99);
    rulesType := ini.ReadInteger('Life', 'rules_type', 0);
    DeltaTimeSpinEdit.Value := ini.ReadFloat('Life', 'delta_time',
      DeltaTimeSpinEdit.Value);
    case rulesType of
      0: begin
        RBClassicRules.Checked := true;
        RBClassicRules.OnClick(Self);
      end;
      1: begin
        RBScriptedRules.Checked := true;
        RBScriptedRules.OnClick(Self);
      end;
      2: begin
        RBTotalisticRules.Checked := true;
        RBTotalisticRules.OnClick(Self);
      end;
    end;

    // [Window]
    Left := ini.ReadInteger('Window', 'left', Left);
    Top := ini.ReadInteger('Window', 'top', Top);
    Width := ini.ReadInteger('Window', 'width', Width);
    Height := ini.ReadInteger('Window', 'height', Height);



    // [Settings]
    with settings do begin
      // [Appearance]
      with appearance do begin
        xpThemes := ini.ReadBool('Appearance', 'xpThemes', true);
        vistaThemes := ini.ReadBool('Appearance', 'vistaThemes', true);
        skins := ini.ReadBool('Appearance', 'skins', true);
        skinName := ini.ReadString('Appearance', 'skinName',
          'Office2007 (internal)');
        end;
      // [AVIRecorder]
      with recorder do begin
        filename := ini.ReadString('AVIRecorder', 'filename', '');
        FourCC := ini.ReadString('AVIRecorder', 'fourCC', 'XVID');
        compressorType := TAVIRecorderSettingsCompressorType(
          GetEnumValue(
            TypeInfo(TAVIRecorderSettingsCompressorType),
            ini.ReadString('AVIRecorder', 'compressorType', 'ctMSVideo1')
          )
        );
        captureType := TAVIRecorderSettingsCaptureType(
          GetEnumValue(
            TypeInfo(TAVIRecorderSettingsCaptureType),
            ini.ReadString('AVIRecorder', 'captureType', 'ctState')
          )
        );
        renderer := TAVIRecorderSettingsRenderer(
          GetEnumValue(
            TypeInfo(TAVIRecorderSettingsRenderer),
            ini.ReadString('AVIRecorder', 'renderer', 'rOpenGL')
          )
        );
        FPS := ini.ReadInteger('AVIRecorder', 'FPS', 15);
        frameSkip := ini.ReadInteger('AVIRecorder', 'frameskip', 4);
        lValueColor := StringToColor(ini.ReadString(
            'AVIRecorder', 'low_value_color', 'clWhite'));
        rValueColor := StringToColor(ini.ReadString(
            'AVIRecorder', 'high_value_color', '$000080FF'));
      end;
    end;
  finally
    ini.Free;
  end;
end;

procedure TMainForm.WriteSettings(const fn: string);
var ini: TIniFile;
    rulesType: integer;
begin
  try
    ini := TIniFile.Create(fn);
    if RBClassicRules.Checked then rulesType := 0
    else if RBScriptedRules.Checked then rulesType := 1
    else if RBTotalisticRules.Checked then rulesType := 2;

    // [Life]
    ini.WriteInteger('Life', 'height', EDLifeHeight.Value);
    ini.WriteInteger('Life', 'width', EDLifeWidth.Value);
    ini.WriteInteger('Life', 'rules_type', rulesType);
    ini.WriteFloat('Life', 'delta_time', DeltaTimeSpinEdit.Value);
    
    // [Window]
    ini.WriteInteger('Window', 'left', Left);
    ini.WriteInteger('Window', 'top', Top);
    ini.WriteInteger('Window', 'width', Width);
    ini.WriteInteger('Window', 'height', Height);

    // [Settings]
    with settings do begin
      // [Appearance]
      with appearance do begin
        ini.WriteBool('Appearance', 'xpThemes', xpThemes);
        ini.WriteBool('Appearance', 'vistaThemes', vistaThemes);
        ini.WriteBool('Appearance', 'skins', skins);
        ini.WriteString('Appearance', 'skinName', skinName);
        end;
      // [AVIRecorder]
      with recorder do begin
        ini.WriteString('AVIRecorder', 'filename', filename);
        ini.WriteString('AVIRecorder', 'fourCC', FourCC);
        ini.WriteString('AVIRecorder', 'compressorType',
            GetEnumName(
              TypeInfo(TAVIRecorderSettingsCompressorType),
              ord(compressorType)
            )
        );
        ini.WriteString('AVIRecorder', 'captureType',
            GetEnumName(
              TypeInfo(TAVIRecorderSettingsCaptureType),
              ord(captureType)
            )
        );
        ini.WriteString('AVIRecorder', 'renderer',
            GetEnumName(
              TypeInfo(TAVIRecorderSettingsRenderer),
              ord(renderer)
            )
        );
        ini.WriteInteger('AVIRecorder', 'FPS', FPS);
        ini.WriteInteger('AVIRecorder', 'frameskip', frameSkip);
        ini.WriteString('AVIRecorder',
            'low_value_color',
            ColorToString(lValueColor)
        );
        ini.WriteString('AVIRecorder',
            'high_value_color',
            ColorToString(rValueColor)
        );
      end;
    end;  finally
    ini.Free;
  end;
end;

procedure TMainForm.nextContinous(n: integer);
const fname = 'ds_over_dt';
var i, j, k: integer;
    x, t1: double;
    txt: textfile;
begin
  // memo.Clear;
  for k := 1 to n do begin
    for i := 1 to life.w do begin
      for j := 1 to life.h do begin
          x := MainForm.PSScript.ExecuteFunction([i, j], fname);
          //x := sin(10 * density(i, j, 1) - 1);
{          if ((i = 25) and (j = 26)) or ((i = 24) and (j = 25))
            then begin memo.Lines.Add(Format('f[%d, %d] = %.18f', [i, j, f[i, j]]));
              if ((i = 24) and (j = 25)) then t1 := f[i, j]
              else if (f[i, j] <> t1) then begin
                memo.lines.add(Format('%.18f != %.18f', [t1, f[i, j]]));
                BTNPlay.Click;
              end;
            end;
}
          f[i, j] := f[i, j] +  deltaTime * x;
        end;
      end;
    life.SwapBuffers();
    end;
  GLTilePlane.StructureChanged;
end;

procedure TMainForm.NextClassic(n: integer);
var i, j, k: integer;
    count: integer;
    b: boolean;
begin
  for k := 1 to n do begin
    for i := 1 to life.w do begin
      for j := 1 to life.h do begin
        count := round(life.neighbours(i, j, 1, neighboursType));
        b := ((f[i, j] = life.rvalue) and (count in setS))
          or (not (f[i, j] = life.rvalue) and (count in setB));
        if b then f[i, j] := life.rvalue else f[i, j] := life.lvalue;
        end;
      end;
    life.SwapBuffers();
    end;
  GLTilePlane.StructureChanged;
end;


procedure TMainForm.MouseMoved(var message: TMessage);
begin
   GLUserInterface.MouseLook;
   GLUserInterface.MouseUpdate;
end;

function density(x, y, r: integer): double;
var n: integer;
begin
  case neighboursType of
    ntMoore: n := (4 * r * r + 4 * r);
    ntVonNeumann: n := 4 * r;  
  end;
  result := MainForm.life.neighbours(x, y, r, neighboursType) / n;
end;

procedure next(ruleFunctionName: string);
var i, j, w, h: integer;
  state: double;
begin
  w := getW();
  h := getH();
  for i := 1 to w do begin
    for j := 1 to h do begin
      state := MainForm.PSScript.ExecuteFunction([i / w, j / h, getCell(i, j)],
        ruleFunctionName);
      SetCell(i, j, state);
    end;
  end;
end;

procedure fill(stateFunctionName: string);
var i, j, w, h: integer;
  state: double;
begin
  w := getW() - 1;
  h := getH() - 1;
  for i := 0 to w do begin
    for j := 0 to h do begin
      state := MainForm.PSScript.ExecuteFunction([i / w, j / h],
        stateFunctionName);
      SetCell(i + 1, j + 1, state);
    end;
  end;
end;

function max(a, b: integer): integer;
begin
  if a > b then
    result := a
  else
    result := b;
end;

procedure setCell(i, j: integer; value: double);
begin
  if Value < MainForm.Life.lvalue then Value := MainForm.life.lvalue;
  if Value > MainForm.life.rvalue then Value := MainForm.life.rvalue;
  MainForm.life[i, j] := value;
  MainForm.GLTilePlane.Tiles[i - fw - 1, j - fh - 1] :=
    round((MainForm.life.rvalue - value) / (MainForm.life.rvalue - MainForm.life.lvalue) * 255);
end;

function getW(): integer;
begin
  result := MainForm.life.w;
end;

function getH(): integer;
begin
  result := MainForm.life.h;
end;

function getCell(i, j: integer): double;
begin
  result := MainForm.life[i, j];
end;

procedure setCellDirect(i, j: integer; value: double);
begin
  if Value < MainForm.life.lvalue then Value := MainForm.life.lvalue;
  if Value > MainForm.life.rvalue then Value := MainForm.life.rvalue;
  MainForm.life.SetCellDirect(i, j, value);
  MainForm.GLTilePlane.Tiles[i - fw - 1, j - fh - 1] :=
  round((MainForm.life.rvalue - value) / (MainForm.life.rvalue - MainForm.life.lvalue) * 255);
end;

procedure TMainForm.ScriptExecute();
begin
  try
    AddToHistory('Executing custom script...');
    if not PSScript.Execute then raise Exception.Create('Runtime error..:(');
    AddToHistory('Custom script executed!');
  except
    on e: Exception do
      AddToHistory('Script failed! ' + e.Message);
  end;
end;

procedure TMainForm.DeltaTimeSpinEditChange(Sender: TObject);
begin
  DeltaTime := (Sender as TsDecimalSpinEdit).Value;
end;

procedure TMainForm.ScriptCompile(const source: TStrings);
var s: string;
  i: integer;
begin
  PSScript.Script := source;
  try
    AddToHistory('Compiling custom script...');
    if not PSScript.Compile then begin
      s := '';
      for i := 0 to PSScript.CompilerMessageCount - 1 do begin
        s := s + #10 + PSScript.CompilerMessages[i].MessageToString;
        end;
      raise Exception.Create(s);
    end;
  except
    on e: Exception do
      AddToHistory('Compilation failed! Compiler log: ' + e.Message);
  end;
end;


function neighbours(i, j, r: integer): double;
begin
  result := MainForm.life.neighbours(i, j, r, neighboursType);
end;

procedure TMainForm.SetVisualState(i, j: integer; value: double);
begin
  if Value < MainForm.Life.lvalue then Value := MainForm.life.lvalue;
  if Value > MainForm.life.rvalue then Value := MainForm.life.rvalue;
  GLTilePlane.Tiles[i - fw - 1, j - fh - 1] :=
    round((MainForm.life.rvalue - value) / (MainForm.life.rvalue - MainForm.life.lvalue) * 255);
end;

procedure TMainForm.sPanel3Resize(Sender: TObject);
var i, w: integer;
begin
  w := (Sender as TWinControl).Width;
  for i  := 0 to (Sender as TWinControl).ControlCount - 1 do begin
    with (Sender as TWinControl) do begin
      Controls[i].Width := round(w / ControlCount - 3);
      (Controls[i] as TsBitBtn).ShowCaption := Controls[i].Width > 55;      
    end;
  end;
   
end;

procedure TMainForm.SetState(i: Integer; j: Integer; value: double);
begin
  if Value < MainForm.Life.lvalue then Value := MainForm.life.lvalue;
  if Value > MainForm.life.rvalue then Value := MainForm.life.rvalue;
  life[i, j] := value;
  GLTilePlane.Tiles[i - fw - 1, j - fh - 1] :=
    round((MainForm.life.rvalue - value) / (MainForm.life.rvalue - MainForm.life.lvalue) * 255);  //.color etc
end;

function TMainForm.GetState(i: Integer; j: Integer): double;
begin
  result := life[i, j];
end;


procedure TMainForm.LoadStarsFromString(const s: string);
var len, p: integer;
  
  function nextLine(): string;
  var t: integer;
  begin
    t := p;
    while (s[p] <> #10) and (p <= len) do inc(p);
    if (p = len) then
      result := ''
    else begin
      inc(p);
      result := MidStr(s, t, p - t - 1);
    end;
  end;
  
var r: string;
    Dec, Magnitude, RA: double;
    t: integer;
    a0, b0, a1, b1: double;
    a2, b2: double;
    star: TSkyDomeStar;
begin
  p := 1;
  len := length(s);

  while true do begin
    r := ReplaceStr(nextLine(), '.', DecimalSeparator);

    if r = '' then break;
    sscanf(r, '%d%f%f%f%f%f%f', [@t, @a0, @a1, @a2, @b0, @b1, @b2, @Magnitude]);  
    Magnitude := StrToFloat(RightStr(r, 4));     
    RA := 15.041 * (a0 + a1 / 60 + a2 / 3600);
    Dec := (abs(b0) + b1 / 60 + b2 / 3600);
    if b0 < 0 then Dec := -Dec;
	// These stars are too small:
    if Magnitude > 3.5 then continue;
	star := GLEarthSkyDome1.Stars.Add;
    star.Magnitude := Magnitude;
    star.Dec := Dec;
    star.RA := RA;
    star.Color := clYellow;//$FFFF00;
  end;
  GLEarthSkyDome1.StructureChanged;
end;

procedure TMainForm.lvalueEditChange(Sender: TObject);
begin
  life.lvalue := lvalueEdit.Value;
end;

procedure TMainForm.ClassicRulesUpd(const fromEdit: boolean);
var s: string;
    i: integer;
    ba, sa: array[0..8] of boolean;
begin
  if fromEdit then begin
    s := EDRuleString.Text;
    i := 2;
    while s[i] <> '/' do begin
      ba[strtoint(s[i])] := true;
      inc(i);
      end;
    inc(i, 2);
    while i <= length(s) do begin
      sa[strtoint(s[i])] := true;
      inc(i);
      end;
    for i := 0 to 8 do begin
      TSpeedButton(FindComponent('b' + inttostr(i))).Down := ba[i];
      TSpeedButton(FindComponent('s' + inttostr(i))).Down := sa[i];
      end;
    end
  else begin
    s := 'b';
    for i := 1 to 8 do
      if TSpeedButton(FindComponent('b' + inttostr(i))).Down then
        s := s + inttostr(i);
    s := s + '/s';
    for i := 0 to 8 do
      if TSpeedButton(FindComponent('s' + inttostr(i))).Down then
        s := s + inttostr(i);
    EDRuleString.Tag := -1;
    EDRuleString.Text := s;
    EDRuleString.SelStart := length(s);
    EDRuleString.Tag := 0;
  end;
  setS := [];
  setb := [];

  for i := 0 to 8 do begin
    if TSpeedButton(FindComponent('b' + inttostr(i))).Down then
      setb := setb + [i];
    if TSpeedButton(FindComponent('s' + inttostr(i))).Down then
      setS := setS + [i];
    end;
end;

procedure TMainForm.ContinousCARuleScriptGroupBoxDblClick(Sender: TObject);
begin
  sBitBtn1.Click;
end;

procedure TMainForm.ApplicationEvents1Deactivate(Sender: TObject);
begin
  MLookDeactivate;
end;

procedure TMainForm.b1Click(Sender: TObject);
begin
    ClassicRulesUpd(false);
end;

procedure TMainForm.bAllClick(Sender: TObject);
var i: integer;
begin
  for i := 1 to 8 do
    TSpeedButton(MainForm.FindComponent('b' + inttostr(i))).Down :=
      TSpeedButton(Sender).Name = 'bAll';
  ClassicRulesUpd(false);
end;

procedure TMainForm.baseColorSelectChange(Sender: TObject);
begin
  baseColor := baseColorSelect.ColorValue;
end;

procedure TMainForm.BTNCenterClick(Sender: TObject);
begin
  GLCamera.Position.SetPoint(0, 0, GLCamera.Position.Z);
end;

procedure TMainForm.BTNExportScript1Click(Sender: TObject);
var fn: string;
begin
  if DLGHTMLExport.Execute then begin
      try
        fn := DLGHTMLExport.FileName;
        AddToHistory('Exporting custom script (HTML) to "' + fn +'"...');
        SynExporterHTML1.ExportAsText := true;
        SynExporterHTML1.ExportAll(EDCustomScript.Lines);
        SynExporterHTML1.SaveToFile(fn);
        AddToHistory('Custom script exported (HTML) to "' + fn + '"')
      except
        on e: Exception do AddToHistory(
          'Custom script export (HTML) failed! ' + e.Message);
      end;
    end;
end;

procedure TMainForm.BTNHistoryClick(Sender: TObject);
begin
  DLGHistory.Show;
end;

procedure TMainForm.BTNLoadScriptFromFile1Click(Sender: TObject);
var fn: string;
begin
  if DLGLoadScript.Execute then begin
    try
      fn := DLGLoadScript.FileName;
      AddToHistory('Loading custom script from "' + fn +'"...');
      EDCustomScript.Lines.LoadFromFile(fn);
      AddToHistory('Custom script loaded from "' + fn + '"')
    except
      on e: Exception do AddToHistory('Custom script loading failed! Error: '
        + e.Message);
    end;
  end;
end;



procedure TMainForm.BTNNextClick(Sender: TObject);
begin
  if RBTotalisticRules.Checked or RBScriptedRules.Checked then begin
    strrule := EDContinousCA.Text;
    ScriptCompile(EDContinousCA.Lines);
    nextContinous(1);
  end else
    nextClassic(1);
end;


procedure TMainForm.BTNOrthoClick(Sender: TObject);
begin
  with GLCamera do begin
    Direction.SetVector(0, 0, -1);
    Up.SetVector(0, 1, 0);
  end;
end;

procedure TMainForm.CBShowGridClick(Sender: TObject);
begin
  GLXYZGrid.Visible := CBShowGrid.Checked;
end;

procedure TMainForm.CBStarsClick(Sender: TObject);
begin
  if CBStars.Checked then
    LoadStarsFromString(stars_resource_text)
  else begin
    GLEarthSkyDome1.Stars.Clear;
  //  GLEarthSkyDome1.SunElevation := GLEarthSkyDome1.SunElevation + 1;
  //  GLEarthSkyDome1.SunElevation := GLEarthSkyDome1.SunElevation - 1;
  end;
  GLEarthSkyDome1.StructureChanged;
end;

procedure TMainForm.CBTextureEnabledClick(Sender: TObject);
begin
  mlib.Materials[1 - TBCells.TabIndex].Material.Texture.Enabled :=
    CBTextureEnabled.Checked;
  GLTilePlane.StructureChanged;
end;

procedure TMainForm.CBTwinkleClick(Sender: TObject);
begin
  if CBTwinkle.Checked then GLEarthSkyDome1.Options := [sdoTwinkle]
  else GLEarthSkyDome1.Options := [];
  GLEarthSkyDome1.StructureChanged;
end;

procedure TMainForm.CBBoundsTypeChange(Sender: TObject);
begin
  life.boundsType := TBoundsType(CBBoundsType.ItemIndex);
end;

procedure TMainForm.CBGridAAClick(Sender: TObject);
begin
  GLXYZGrid.AntiAliased := CBGridAA.Checked;
end;

procedure TMainForm.EDBackgroundColorChange(Sender: TObject);
begin
  sceneViewer.Buffer.BackgroundColor := EDBackgroundColor.ColorValue;
end;

procedure TMainForm.EDBackgroundTypeChange(Sender: TObject);
var i: integer;
begin
  GLEarthSkyDome1.Visible := (EDBackgroundType.ItemIndex = 1);
  EDBackgroundColor.Enabled := (EDBackgroundType.ItemIndex = 0);
  sGroupBox4.Enabled := (EDBackgroundType.ItemIndex = 1);
  for i := 0 to sGroupBox4.ControlCount - 1 do begin
    sGroupBox4.Controls[i].Enabled := (EDBackgroundType.ItemIndex = 1);
    end;

end;

procedure TMainForm.EDCellColorSelectChange(Sender: TObject);
begin
  with mlib.Materials[1 - TBCells.TabIndex].Material.FrontProperties do begin
    Ambient.AsWinColor := EDCellColorSelect.ColorValue;
    Diffuse.AsWinColor := EDCellColorSelect.ColorValue;
    end;
  GLTilePlane.StructureChanged;
end;

procedure TMainForm.EDCustomScriptKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var x: smallint;
begin
  if (Shift = []) and (Key = VK_F9) then begin
    BTNScriptRun.Click;
    exit;
  end;
  x := smallint(key);
  if Shift = [ssCtrl] then begin
    if x = VKkeyscan('S') then BTNSaveScript1.Click
    else if x = VKkeyscan('L') then BTNLoadScriptFromFile1.Click
    else if x = VKkeyscan('E') then BTNExportScript1.Click
    else if x = VKkeyscan('M') then BTNScriptWindow1.Click;
   end;
end;

procedure TMainForm.EDDayNightSpeedChange(Sender: TObject);
begin
  daynightspeed := EDDayNightSpeed.Value;
end;

procedure TMainForm.EDGridColorChange(Sender: TObject);
begin
  GLXYZGrid.LineColor.AsWinColor := EDGridColor.ColorValue;
end;

procedure TMainForm.EDGridLinesWidthChange(Sender: TObject);
begin
  GLXYZGrid.LineWidth := EDGridLinesWidth.Value;
end;

procedure TMainForm.EDLifeHeightChange(Sender: TObject);
var i, w, h, oldw, oldh: integer;
  j: Integer;
begin
  oldw := life.w;
  oldh := life.h;
  w := EDLifeWidth.Value;
  h := EDLifeHeight.Value;

  life.w := w;
  life.h := h;
  fw := life.w div 2;
  fh := life.h div 2;

  with GLXYZGrid do begin
    XSamplingScale.Min := -fw;
    XSamplingScale.Max := fw + 1;
    YSamplingScale.Min := -fh;
    YSamplingScale.Max := fh + 1;
    StructureChanged;
    end;

  for i := 1 to max(oldw, w) do
    for j := 1 to max(oldh, h) do begin
      if (i <= w) and (j <= h) then
        SetVisualState(i, j, f[i, j])
      else
        SetVisualState(i, j, life.lvalue);
    end;
  GLTilePlane.Tiles.Pack;
  GLTilePlane.StructureChanged;
end;

procedure TMainForm.EDRuleStringChange(Sender: TObject);
  function isCorrect(const s: string): boolean;
  var i: integer;
  begin
    result := false;
    i := 2;
    if (length(s) < 3) or (not (s[1] in ['b', 'B'])) then exit;
    while (s[i] <> '/') and (i <= length(s)) do
      if (not (s[i] in ['1'..'8'])) then exit
      else inc(i);
    if (i >= length(s)) then exit;
    inc(i);
    if not (s[i] in ['s', 'S']) then exit;
    inc(i);
    while (i <= length(s)) do
      if not (s[i] in ['0'..'8']) then exit
      else inc(i);
    result := true;
  end;
begin
  if EDRuleString.Tag = -1 then exit;  
  if isCorrect(EDRuleString.Text) then ClassicRulesUpd(true)
  else begin
    LBLRuleStringError.Visible := true;
    LBLRuleStringErrorTimer.Enabled := true;
    ClassicRulesUpd(false);
  end;
end;

procedure TMainForm.EDSceneViewerAAChange(Sender: TObject);
begin
  sceneViewer.Buffer.AntiAliasing :=
    GLContext.TGLAntiAliasing(EDSceneViewerAA.ItemIndex);
end;

procedure TMainForm.EDSunElevationChange(Sender: TObject);
var t: integer;
begin
  try
    t := EDSunElevation.Value;
    GLEarthSkyDome1.SunElevation := t;
    GLEarthSkyDome1.StructureChanged;
  except on E: Exception do
    //
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GLCadencer1.Enabled := false;
  FPSTimer.Enabled := false;
  FreeAndNil(sceneViewer);
  AddToHistory('Life v3.0 closed. Saving log to file...');
  try
  //+ '[' + ReplaceStr(DateTimeToStr(SysUtils.Now), ':', '_') + ']
    history.SaveToFile('life.log');
  except
    on e: Exception do
      ShowMessage('Unable to save log file. ' + e.Message);
  end;
  WriteSettings(GetCurrentDir + '\' + INIFileName);
  history.Free;
end;


procedure TMainForm.AddToHistory(s: string);
var x: string;
begin
  x := '[' + DateTimeToStr(SysUtils.Now) + ']=' + s;
  history.Add(x);
  x[pos('=', x)] := ' ';
  StatusBar.Panels[2].Text := x;
  uHistoryDialog.updateHistory();
  Application.ProcessMessages;
end;

procedure TMainForm.SetBaseColor(color: TColor);
const freq = 255;
var i: integer;
    m: TGLLibMaterial;
    k: double;
    r, g, b: double;
begin
  fbaseColor := color;
  r := GetRValue(color); g := GetGValue(color); b := GetBValue(color);
  r := (freq - r) / freq;  g := (freq - g) / freq; b := (freq - b) / freq;
  mlib.Materials.Clear;
  for i := 0 to freq do begin
    m := TGLLibMaterial(mlib.Materials.Insert(0));
    with m.Material.FrontProperties do begin
      k := i / freq;
      Specular.SetColor(1 - k * r, 1 - k * g, 1 - k * b);
      Diffuse.SetColor(1 - k * r, 1 - k * g, 1 - k * b);
      Shininess := 128;
    end;
  end;
  GlTilePlane.StructureChanged;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var i, j: integer;
begin
  basecolor := RGB(255, 123, 0);
  baseColorSelect.ColorValue := baseColor;
  setlength(SysUtils.TrueBoolStrs, 1);
  setlength(SysUtils.FalseBoolStrs, 1);
  SysUtils.TrueBoolStrs[0] := 'on';
  SysUtils.FalseBoolStrs[0] := 'off';
  RBClassicRules.WordWrap := true;
  life := TLifeSimulator.Create(0, 0, 0, 1);
  Randomize;
  TBCells.OnChange(Self);
  CBBoundsType.OnChange(Self);
  EDBackgroundColor.OnChange(Self);

  ReadSettings(GetCurrentDir + '\' + INIFileName);

  for i := 1 to life.w do begin
    for j := 1 to life.h do begin

      if (Random(2) = 1) then f[i, j] := life.lvalue
      else f[i, j] := life.rvalue;
    //}

  {
    if (i <> (life.w + 1) div 2) or (j <> (life.h + 1) div 2) then
      f[i, j] := life.lvalue
    else f[i, j] := life.rvalue;
    //}
    end;
  end;
  life.SwapBuffers();

  CBStars.OnClick(Self);
  CBTwinkle.OnClick(Self);
  CBShowGrid.OnClick(Self);
  EDSunElevation.OnChange(Self);
  PNLSceneViewer.OnResize(Self);

  history := TStringList.Create;
  AddToHistory('Life v3.0 started');
  uHistoryDialog.History := @history;
  try
    AddToHistory('Scripting engine [Pascal] initialized');
  except on e: Exception do
    AddToHistory('Scripting engine initialization failed.' + e.Message);
  end;
  ClassicRulesUpd(true);
  rvalueEdit.OnChange(Self);
  lvalueEdit.OnChange(Self);

  Application.ProcessMessages;
  GLTilePlane.StructureChanged;
  GLCadencer1.Enabled := true;
end;

procedure TMainForm.MenuItem1Click(Sender: TObject);
begin
  sBitBtn2.Click;
end;

procedure TMainForm.MLookDeactivate();
begin
  mlook := false;
  if not recording then GLLines1.Visible := true;
  if not recording then DCSelection.Visible := true;
  EDCustomScript.PopupMenu := SynEditPopupMenu1;
  GLUserInterface.MouseLookDeactivate;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//var p: TPoint;
const C_letter_code1 = 323;    //323 = C, 67 = c
      C_letter_code2 = 67;
begin
  if (Key in [VK_CONTROL, VK_SHIFT, VK_LSHIFT, VK_RSHIFT]) then begin
    if not sceneViewer.Focused then exit;
    GLUserInterface.MouseLookActiveToggle;
    mlook := not mlook;
    if not recording then GLLines1.Visible := not mlook;
    if not recording then DCSelection.Visible := not mlook;
    if (EDCustomScript.PopupMenu = nil) then
      EDCustomScript.PopupMenu := SynEditPopupMenu1
    else
      EDCustomScript.PopupMenu := nil;
    if mlook then begin
      sceneViewer.SetFocus;
    end;
  end;
  {ok := true;
  if sceneViewer.Focused and (not mlook) and
  (high(integer) <> tileX) then begin
    case key of
      VK_UP: inc(tileY);
      VK_DOWN: dec(tileY);
      VK_RIGHT: inc(tileX);
      VK_LEFT: dec(tileX);
      C_letter_code1, C_letter_code2: begin
        SetCellDirect(tileX, tileY, not f[tileX, tileY]);
        GLTilePlane.StructureChanged;
        end;
      else ok := false;
      end;
    if ok then DCSelection.Position.SetPoint(tileX, tileY, 0);
    end;}
  if (Key = VK_ESCAPE) then begin
    MLookDeactivate;
  end;
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key in ['A'..'z', 'À'..'ÿ']) and GLUserInterface.MouseLookActive
    then key := #0;
end;

procedure TMainForm.FPSTimerTimer(Sender: TObject);
//var i, j:integer;
const n = 50;
begin
  if sceneViewer = nil then exit;

   GLFPSText.Text :=
    Format('Life v3.0 by Glex [%.1f FPS]'
      {$IFDEF DEBUG} + ' [mouse look %s]' {$ENDIF},
      [sceneViewer.FramesPerSecond
      {$IFDEF DEBUG}, BoolToStr(mlook, true) {$ENDIF}]);
   sceneViewer.ResetPerformanceMonitor;
  {   for i := -n to n do
    for j := -n to n do
      GLTilePlane.Tiles[i, j]:= Random(mlib.Materials.Count);
      GLTilePlane.StructureChanged; }
end;

procedure TMainForm.GameTimerTimer(Sender: TObject);
begin
  if RBTotalisticRules.Checked or RBScriptedRules.Checked then begin
    try
    nextContinous(1);
    except on e: Exception do begin
      ShowMessage(e.Message);
      BTNPlay.Click;
      exit;
      end;
    end;
  end
 else
    nextClassic(1);
end;

procedure TMainForm.GBSceneViewerBoxDblClick(Sender: TObject);
begin
  if sBitBtn1.Down then sBitBtn1.Click
  else BTNScriptWindow1.Click;
end;

procedure TMainForm.GLCadencer1Progress(Sender: TObject; const deltaTime,
  newTime: Double);
const
  MovingSpeed = 20;
  RotationSpeed = 150;
var
   ip : TVector;
   mp : TPoint;
   ok: boolean;
begin
//  if not recording then begin

  if isKeyDown('É') or isKeyDown('Q') or (IsKeyDown(VK_RBUTTON) and mlook) then
      GLCamera.Move(-MovingSpeed*DeltaTime);
  if isKeyDown('Ó') or isKeyDown('E') or (IsKeyDown(VK_LBUTTON) and mlook) then
      GLCamera.Move(MovingSpeed*DeltaTime);
  //MakeVector(ip, 0, 0, -1);
  if isKeyDown('Û') or isKeyDown('S') then
    GLNavigator.MoveForward(-MovingSpeed*DeltaTime);
  if isKeyDown('Ö') or isKeyDown('W') then
    GLNavigator.MoveForward(MovingSpeed*DeltaTime);
  if isKeyDown('Ô') or isKeyDown('A') then
    GLNavigator.StrafeHorizontal(-MovingSpeed*DeltaTime);
  if isKeyDown('Â') or isKeyDown('D') then
    GLNavigator.StrafeHorizontal(MovingSpeed*DeltaTime);

  if zoomSpeed <> 0 then
    GLNavigator.FlyForward(zoomSpeed * DeltaTime);

  GetCursorPos(mp);

  mp := sceneViewer.ScreenToClient(mp);

   if PtInRect(sceneViewer.ClientRect, mp) then begin
      sceneViewer.Buffer.
        ScreenVectorIntersectWithPlaneXY(VectorMake(mp.x,
          sceneViewer.Height - mp.y, 0), 0, ip);
      tileX := round(ip[0] - 0.5);
      tileY := round(ip[1] - 0.5);
      ok := (abs(ip[0] - 0.5) <= fw) and (abs(ip[1] - 0.5) <= fh);
      if ok then
        StatusBar.Panels[1].Text :=
          Format('Cell[%d, %d] = %.2f; Density(1) = %.2f', [(tileX + 1 + fw), (tileY + 1 + fh),
            getCell(tileX + 1 + fw, tileY + 1 + fh), density(tileX + 1 + fw, tileY + 1 + fh, 1)])
      else
        StatusBar.Panels[1].Text := 'Cell: n / a';
      if ok then begin
        DCSelection.Position.SetPoint(tileX, tileY, 0);
        tileX := (tileX + 1 + fw);
        tileY := (tileY + 1 + fh);
        if (not mlook) and IsKeyDown(VK_LBUTTON) then begin
          if life[tileX, tileY] <> life.rvalue then begin
            SetCellDirect(tileX, tileY, life.rvalue);
            GLTilePlane.StructureChanged;
            end;
          end;
        if (not mlook) and IsKeyDown(VK_RBUTTON) then begin
          if life[tileX, tileY] <> life.lvalue then begin
            SetCellDirect(tileX, tileY, life.lvalue);
            GLTilePlane.StructureChanged;
            end;
          end;
        end else
          tileX := high(integer);

        mx := mp.x;
        my := mp.y;
    end;
   //!!!
   if mlook then begin
     GLUserInterface.MouseLook;
     GLUserInterface.MouseUpdate;
   end;
//  end;
end;

procedure TMainForm.GLDirectOpenGLRender(Sender: TObject;
  var rci: TRenderContextInfo);
begin
   glClear(GL_DEPTH_BUFFER_BIT);
end;

procedure TMainForm.LBLRuleStringErrorTimerTimer(Sender: TObject);
begin
  LBLRuleStringErrorTimer.Enabled := false;
  LBLRuleStringError.Visible := false;
end;

procedure TMainForm.PackingTimerTimer(Sender: TObject);
begin
  GLTilePlane.Tiles.Pack;
end;

procedure TMainForm.PNLSceneViewerResize(Sender: TObject);
begin
//  sceneViewer.FieldOfView := 90;
end;

procedure TMainForm.sAllClick(Sender: TObject);
var i: integer;
begin
  for i := 0 to 8 do
    TSpeedButton(MainForm.FindComponent('s' + inttostr(i))).Down :=
      TSpeedButton(Sender).Name = 'sAll';
  ClassicRulesUpd(false);
end;

procedure TMainForm.BTNPlayClick(Sender: TObject);
const
  captions: array[false..true] of string = ('Start', 'Pause');
  imgIndexes: array[false..true] of integer = (15, 17);
begin
  if (RBTotalisticRules.Checked or RBScriptedRules.Checked)
    and (not GameTimer.Enabled)then begin
    strrule := EDContinousCA.Text;
    try
    ScriptCompile(EDContinousCA.Lines);
    except on e: Exception do begin
      showmessage(e.Message);
      exit;
    end;
    end;
  end;

  GameTimer.Enabled := not GameTimer.Enabled;
  BTNPlay.Caption := captions[GameTimer.Enabled];
  BTNPlay.ImageIndex := imgIndexes[GameTimer.Enabled];
end;

procedure TMainForm.BTNSaveScript1Click(Sender: TObject);
var fn: string;
begin
  if DLGSaveScript.Execute then begin
    try
      fn := DLGSaveScript.FileName;
      AddToHistory('Saving custom script to "' + fn +'"...');
      EDCustomScript.Lines.SaveToFile(fn);
      AddToHistory('Script custom saved to "' + fn + '"')
    except
      on e: Exception do AddToHistory('Custom script saving failed!'
        + e.Message);
    end;
  end;
end;

procedure TMainForm.BTNScriptRunClick(Sender: TObject);
begin
  ScriptCompile(EDCustomScript.Lines);
  ScriptExecute();
end;

procedure TMainForm.BTNScriptWindow1Click(Sender: TObject);
begin
  if Sender = sBitBtn1 then begin
    if ContinousCARuleScriptGroupBox.Parent = MainForm then begin
      GBCustomScript.Parent := LeftPanel;
      GBSceneViewerBox.Parent := MainForm;
      BTNScriptWindow1.Down := false;
      EDCustomScript.Gutter.Visible := false;
      ContinousCARuleScriptGroupBox.Parent := TSContinousCA;
      sBitBtn1.Down := false;
      EDContinousCA.Gutter.Visible := false;
      PNLControlsDesc.Visible := true;
      PNLSceneViewer.OnResize(Self);
      end
    else begin
      GBCustomScript.Parent := LeftPanel;
      BTNScriptWindow1.Down := false;
      EDCustomScript.Gutter.Visible := false;
      ContinousCARuleScriptGroupBox.Parent := MainForm;
      GBSceneViewerBox.Parent := TSContinousCA;
      sBitBtn1.Down := true;
      PNLControlsDesc.Visible := false;
      PNLSceneViewer.OnResize(Self);
      EDContinousCA.Gutter.Visible := true;
    end;

  end else begin
    if GBCustomScript.Parent = MainForm then begin
      ContinousCARuleScriptGroupBox.Parent := TSContinousCA;
      sBitBtn1.Down := false;
      EDContinousCA.Gutter.Visible := false;
      GBCustomScript.Parent := LeftPanel;
      GBSceneViewerBox.Parent := MainForm;
      BTNScriptWindow1.Down := false;
      EDCustomScript.Gutter.Visible := false;
      PNLControlsDesc.Visible := true;
      PNLSceneViewer.OnResize(Self);
      end
    else begin
      ContinousCARuleScriptGroupBox.Parent := TSContinousCA;
      sBitBtn1.Down := false;
      EDContinousCA.Gutter.Visible := false;
      GBCustomScript.Parent := MainForm;
      GBSceneViewerBox.Parent := LeftPanel;
      PNLControlsDesc.Visible := false;
      BTNScriptWindow1.Down := true;
      EDCustomScript.Gutter.Visible := true;
      PNLSceneViewer.OnResize(Self);
    end;
  end;
end;

procedure TMainForm.sBitBtn5Click(Sender: TObject);
var fn: string;
begin
  if DLGHTMLExport.Execute then begin
      try
        fn := DLGHTMLExport.FileName;
        AddToHistory('Exporting custom script (HTML) to "' + fn +'"...');
        SynExporterHTML1.ExportAsText := true;
        SynExporterHTML1.ExportAll(EDContinousCA.Lines);
        SynExporterHTML1.SaveToFile(fn);
        AddToHistory('Custom script exported (HTML) to "' + fn + '"')
      except
        on e: Exception do AddToHistory(
          'Custom script export (HTML) failed! ' + e.Message);
      end;
    end;
end;

procedure TMainForm.sBitBtn6Click(Sender: TObject);
var fn: string;
begin
  if DLGSaveScript.Execute then begin
    try
      fn := DLGSaveScript.FileName;
      AddToHistory('Saving custom script to "' + fn +'"...');
      EDContinousCA.Lines.SaveToFile(fn);
      AddToHistory('Script custom saved to "' + fn + '"')
    except
      on e: Exception do AddToHistory('Custom script saving failed!'
        + e.Message);
    end;
  end;
end;

procedure TMainForm.sBitBtn7Click(Sender: TObject);
var fn: string;
begin
  if DLGLoadScript.Execute then begin
    try
      fn := DLGLoadScript.FileName;
      AddToHistory('Loading custom script from "' + fn +'"...');
      EDContinousCA.Lines.LoadFromFile(fn);
      AddToHistory('Custom script loaded from "' + fn + '"')
    except
      on e: Exception do AddToHistory('Custom script loading failed! Error: '
        + e.Message);
    end;
  end;
end;

procedure TMainForm.sButton1Click(Sender: TObject);
begin
  sButton1.Visible := not sButton1.Visible;
  RighTsPanel.Visible := not RighTsPanel.Visible;
  sButton1.Visible := not sButton1.Visible;
  if sButton1.Caption = '>' then sButton1.Caption := '<'
  else sButton1.Caption := '>';
end;

procedure TMainForm.sButton2Click(Sender: TObject);
begin
  LeftPanel.Visible := not LeftPanel.Visible;

  if sButton2.Caption = '>' then
    sButton2.Caption := '<'
  else
    sButton2.Caption := '>';
end;

procedure TMainForm.RecordAVI;
const renderInMemory = true;
      renderOnScreen = true;
var //t: TGLCadencerMode;
    te, tb: boolean;
    w, h, i, skiprate: integer;
    bmp: TBitMap;
begin
    try
      tb := GLLines1.Visible;
      GLLines1.Visible := false;
      if (RBTotalisticRules.Checked or RBScriptedRules.Checked) then begin
        strrule := EDContinousCA.Text;
        ScriptCompile(EDContinousCA.Lines);
      end;
      //
      GLFPSText.Visible := false;
      te := GameTimer.Enabled;
      if settings.recorder.captureType = ctState then begin
        w := life.w; h := life.h;
      end else begin
        w := sceneViewer.Height; h := sceneViewer.Width;
      end;
      AVIRecorder.Filename := settings.recorder.filename;
      AVIRecorder.Height := h;
      AVIRecorder.Width := w;
      GameTimer.Enabled := false;
      AVIRecorder.FPS := settings.recorder.FPS;
      skiprate := settings.recorder.frameSkip;
//      RecBtn.Enabled := AVIRecorder.Recording;
      AVIRecorder.CreateAVIFile();
      GLCadencer1.Enabled := false;
      memcam.Position.Z := max(w, h) * 4;
//      memcam.FocalLength := 2*pi;
      //
      bmp := TBitmap.Create; bmp.SetSize(w, h);


      if settings.recorder.captureType = ctState then begin
          AVIRecorder.GLNonVisualViewer := GLMemoryViewer1;
          AVIRecorder.GLSceneViewer := nil;
          AVIRecorder.ImageRetrievalMode := irmRenderToBitmap;
          GLMemoryViewer1.Width := w;
          GLMemoryViewer1.Height := h;
          memcam.SetFieldOfView(90, max(w, h));
          GLMemoryViewer1.Buffer.RenderToBitmap(bmp, 96);
          bmp.SaveToFile(AVIRecorder.Filename + '.bmp');

          if (w mod 2 = 1) then memcam.Position.X := 1;
          if (h mod 2 = 1) then memcam.Position.Y := 1;

          while recording do begin
            sceneViewer.Buffer.Render;
            GLMemoryViewer1.Buffer.RenderToBitmap(bmp);
            for i := 1 to skiprate do begin
              GameTimer.OnTimer(Self);
              Application.ProcessMessages;
              end;
            AVIRecorder.AddAVIFrame(bmp);
            Application.ProcessMessages;
            end;
        end else begin
          AVIRecorder.GLNonVisualViewer := nil;
          AVIRecorder.GLSceneViewer := sceneViewer;
          AVIRecorder.ImageRetrievalMode := irmRenderToBitmap;
          sceneViewer.Buffer.RenderToBitmap(bmp, 96);
          bmp.SaveToFile(AVIRecorder.Filename + '.bmp');
          while recording do begin
            sceneViewer.Buffer.Render;
            for i := 1 to skiprate do begin
              GameTimer.OnTimer(Self);
              Application.ProcessMessages;
              end;
            AVIRecorder.AddAVIFrame();
            Application.ProcessMessages;
            end;
          end;
    finally
      if AVIRecorder.Recording then 
        AVIRecorder.CloseAVIFile();
//      GLCadencer1.Mode := t;
      GLCadencer1.Enabled := true;
      GameTimer.Enabled := te;
      RecBtn.Enabled := true;
//
      GLLines1.Visible := tb;
      GLFPSText.Visible := true;
      bmp.free;
    end;
end;

procedure TMainForm.rValueEditChange(Sender: TObject);
begin
  life.rvalue := rValueEdit.Value; 
end;

procedure TMainForm.RecBtnClick(Sender: TObject);
const captions: array[false..true] of string = ('Record', 'Stop');
begin
  recording := not recording;
  RecBtn.Caption := captions[recording];
  if recording then RecordAVI;
end;


procedure TMainForm.sceneViewerMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   mx := x;
   my := y;
   sceneViewer.SetFocus;
   if GLUserInterface.MouseLookActive then exit;

   if (tileX = high(Integer)) then exit;

   if [ssLeft] = Shift then begin
      setCellDirect(tileX, tileY, life.rvalue);
      GLTilePlane.StructureChanged;
   end else if [ssRight] = Shift then begin
      SetCellDirect(tileX, tileY, life.lvalue);
      GLTilePlane.StructureChanged;
   end;
end;

procedure TMainForm.sceneViewerMouseEnter(Sender: TObject);
begin
  if not sceneViewer.Focused then sceneViewer.SetFocus;
end;

procedure TMainForm.sceneViewerMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
//  GLUserInterface.MouseLook;
//  GLUserInterface.MouseUpdate;
end;

procedure TMainForm.EDTurbidityChange(Sender: TObject);
begin
  GLEarthSkyDome1.Turbidity := EDTurbidity.Value;
  GLEarthSkyDome1.StructureChanged;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close();
end;

procedure TMainForm.PNLTextureImagesHolderClick(Sender: TObject);
var i: integer;
begin
    i := TBCells.TabIndex;

    if DLGLoadTexture.Execute then begin
      mlib.Materials[1 - i].Material.Texture.Image.
        LoadFromFile(DLGLoadTexture.FileName);
    end;
    GLTilePlane.StructureChanged;

    TBCells.OnChange(Self);
end;

procedure TMainForm.Preferences1Click(Sender: TObject);
begin
  DLGPreferences.ShowModal;
end;

procedure TMainForm.PSScriptAfterExecute(Sender: TPSScript);
begin
  life.SwapBuffers();
  GLTilePlane.StructureChanged;
end;

procedure TMainForm.PSScriptCompImport(Sender: TObject; x: TPSPascalCompiler);
begin
  //x.AddTypeS('TStateFunction', 'function(x, y: double): double');
  with Sender as TPSScript do begin
    AddFunction(@density, 'function density(x, y, r: integer): double');
    AddFunction(@neighbours,
      'function neighbours(i, j, r: integer): double');
    AddFunction(@setCell, 'procedure setCell(i, j: integer; value: double)');
    AddFunction(@getCell, 'function getCell(i, j: integer): double');
    AddFunction(@setCellDirect,
      'procedure setCellDirect(i, j: integer; value: double)');
    AddFunction(@getW, 'function getW(): integer');
    AddFunction(@getH, 'function getH(): integer');
    AddFunction(@fill, 'procedure fill(stateFunctionName: string)');
    AddFunction(@exp, 'function exp(x: double): double');
//    AddFunction(@next, 'procedure next(ruleFunctionName: string)');
  end;
end;

procedure TMainForm.RBClassicRulesClick(Sender: TObject);
begin
  PCRulesSettings.ActivePage := TSClassicRules;
  rvisualsettingspanel.Visible := false;
  TBCells.Visible := true;
  neighboursType := ntMoore;
end;

procedure TMainForm.RBScriptedRulesClick(Sender: TObject);
begin
  RBTotalisticRulesClick(Self);
  neighboursType := ntVonNeumann;
end;

procedure TMainForm.RBTotalisticRulesClick(Sender: TObject);
begin
  PCRulesSettings.ActivePage := TSContinousCA;
  TBCells.Visible := false;
  rvisualsettingspanel.Visible := true;
  neighboursType := ntMoore;
end;

procedure TMainForm.TBCellsChange(Sender: TObject);
var i, w, h: integer;
  img: TImage;
begin
    i := TBCells.TabIndex;
    if i = 0 then img := IMGCellTexture0
    else img := IMGCellTexture1;
    IMGCellTexture0.Hide;
    IMGCellTexture1.Hide;
    EDCellColorSelect.ColorValue :=
      mlib.Materials[1 - i].Material.FrontProperties.Ambient.AsWinColor;
    img.Picture.Bitmap.FreeImage;
    img.Picture.Bitmap := mlib.Materials[1 - i].Material.Texture.Image.
      GetBitmap32(GL_TEXTURE_2D).Create32BitsBitmap;
    w := img.Picture.Width;
    h := img.Picture.Height;
    CBTextureEnabled.Checked := mlib.Materials[1 - i].Material.Texture.Enabled;
    if (w = 0) then begin
      LBLTextureInfo.Caption := 'Texture not loaded';
      LBLClickHere.Show;
      end
    else begin
      LBLTextureInfo.Caption := Format('Size: %d x %d', [w, h]);
      LBLClickHere.Hide;
      img.Show;
    end;
end;

procedure TMainForm.TBZoomChange(Sender: TObject);
begin
  zoomSpeed := 2 * (50 - TBZoom.Position);
end;

procedure TMainForm.TBZoomMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TBZoom.Position := 50;
  zoomSpeed := 0;
end;

end.
