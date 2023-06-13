import
  nigui,
  ./info

##################################
# Definition #####################
##################################
type
  Skin = ref object
    name: string
    ext: string
    path: string
    ui: LayoutContainer
    checkBox: Checkbox
    skinNameLabel: Label

type
  Application = ref object of RootObj
    window: Window
    ui: LayoutContainer
    isShowed: bool # ウィンドウが既に一回表示されたか

  ContainsSkinfile = ref object of Application
    skinfileUi: LayoutContainer # 画面左側UI
    skinfiles: seq[Skin]
    isSelectedSeq: seq[Skin] # スキンファイルのうち選択されたものを一つ追加

  ToolWindow = ref object of ContainsSkinfile
    changeButton: Button # 変更ボタン
    cancelButton: Button # キャンセルボタン

  ChangeCursorWindow = ref object of ToolWindow

  ChangeHitSoundWindow = ref object of ToolWindow

  AddCursorWindow = ref object of ToolWindow

  AddHitSoundWindow = ref object of ToolWindow

  SettingWindow = ref object of Application
    changePathUi: LayoutContainer # パス変更UI
    referDirUi: LayoutContainer
    pathTextBox: TextBox
    referDirButton: Button
    savePathButton: Button

    changeLangUi: LayoutContainer # 言語変更UI
    comboBox: ComboBox
    saveLangButton: Button

  MainWindow = ref object of ContainsSkinfile
    rightUi: LayoutContainer # 画面右側UI
    topUi: LayoutContainer # 上側UI
    changeCursorButton: Button
    changeHitSoundButton: Button
    bottomUi: LayoutContainer # 下側UI
    addCursorButton: Button
    addHitSoundButton: Button
    settingButton: Button

    changeCursor: ChangeCursorWindow
    changeHitSound: ChangeHitSoundWindow
    addCursor: AddCursorWindow
    addHitSound: AddHitSoundWindow
    setting: SettingWindow

proc newApp(self:MainWindow): void
method createWindow(self:Application, title:string="", height:int=100, width:int=100): void {.base.}
method showWindow(self:Application): void {.base.}
method setControls(self:Application): void {.base.} =
  self.ui = newLayoutContainer(Layout_Horizontal)
  self.window.add(self.ui)

##################################
# Implementation #################
##################################
var
  application: MainWindow = MainWindow(isShowed:false)

proc main(): void =
  app.init()
  application.newApp()
  app.run()

# アプリケーション作成
proc newApp(self:MainWindow): void =
  self.createWindow("OsuCursorChanger GUI"&VERSION, 500, 800)
  let height: int = 500
  let width: int = 800
  self.changeCursor = ChangeCursorWindow(isShowed:false)
  self.changeCursor.createWindow("Change Cursor", height, width)
  self.changeHitSound = ChangeHitSoundWindow(isShowed:false)
  self.changeHitSound.createWindow("Change HitSound", height, width)
  self.addCursor = AddCursorWindow(isShowed:false)
  self.addCursor.createWindow("Add Cursor", height, width)
  self.addHitSound = AddHitSoundWindow(isShowed:false)
  self.addHitSound.createWindow("Add HitSound", height, width)
  self.setting = SettingWindow(isShowed:false)
  self.setting.createWindow("Settings", 300, 400)

# ウィンドウ作成
method createWindow(self:Application, title:string="", height:int=100, width:int=100): void =
  self.window = newWindow(title)
  self.window.height = height
  self.window.width = width

# ウィンドウを表示する
method showWindow(self:Application): void =
  if not self.isShowed:
    self.window.show()
    self.isShowed = true
    return
  self.window.visible = true



when isMainModule:
  main()