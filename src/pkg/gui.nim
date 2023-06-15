import
  nigui,
  nigui/msgBox,
  ./info,
  ./utils,
  ./firstLaunch

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
    buttonUi: LayoutContainer
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
    savePathUi: LayoutContainer
    savePathButton: Button

    changeLangUi: LayoutContainer # 言語変更UI
    comboBox: ComboBox
    saveLangUi: LayoutContainer
    saveLangButton: Button

  MainWindow = ref object of ContainsSkinfile
    menuUi: LayoutContainer # 画面右側UI
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
method setEvents(self:Application): void {.base.} =
  self.window.onCloseClick = proc(event: CloseClickEvent) = discard

##################################
# Implementation #################
##################################
var
  application: MainWindow = MainWindow()

proc main(): void =
  app.init()
  application.newApp()
  application.showWindow()
  # application.changeCursor.showWindow()
  # application.setting.showWindow()
  # 初回起動の時の処理
  if loadIsFirstLaunch() == 0:
    var firstLaunch: FirstLaunchWindow = FirstLaunchWindow()
    firstLaunch.newApp()
    firstLaunch.window.showModal(application.window)
    # updateIsFirstLaunch(1)
  app.run()

# アプリケーション作成
proc newApp(self:MainWindow): void =
  self.createWindow("OsuCursorChanger GUI - "&VERSION, 500, 600)
  let
    height: int = 500
    width: int = 500
  self.changeCursor = ChangeCursorWindow()
  self.changeCursor.createWindow("Change Cursor", height, width)
  self.changeHitSound = ChangeHitSoundWindow()
  self.changeHitSound.createWindow("Change HitSound", height, width)
  self.addCursor = AddCursorWindow()
  self.addCursor.createWindow("Add Cursor", height, width)
  self.addHitSound = AddHitSoundWindow()
  self.addHitSound.createWindow("Add HitSound", height, width)
  self.setting = SettingWindow()
  self.setting.createWindow("Settings", 230, 400)

  self.setControls()
  self.changeCursor.setControls()
  self.changeHitSound.setControls()
  self.addCursor.setControls()
  self.addHitSound.setControls()
  self.setting.setControls()

  self.setEvents()

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

##################################
# Implementation - Controls ######
##################################
method setControls(self:MainWindow): void =
  const buttonHeight: int = 35

  self.ui = newLayoutContainer(Layout_Horizontal)

  self.skinfileUi = newLayoutContainer(Layout_Vertical)
  self.skinfileUi.widthMode = WidthMode_Expand
  self.skinfileUi.heightMode = HeightMode_Expand
  self.skinfileUi.frame = newFrame()

  self.menuUi = newLayoutContainer(Layout_Vertical)
  self.menuUi.heightMode = HeightMode_Expand
  self.menuUi.width = 150
  self.menuUi.xAlign = XAlign_Center

  self.topUi = newLayoutContainer(Layout_Vertical)
  self.topUi.widthMode = WidthMode_Expand
  self.topUi.frame = newFrame()

  self.changeCursorButton = newButton("Change Cursor")
  self.changeCursorButton.widthMode = WidthMode_Expand
  self.changeCursorButton.height = buttonHeight

  self.changeHitSoundButton = newButton("Change HitSound")
  self.changeHitSoundButton.widthMode = WidthMode_Expand
  self.changeHitSoundButton.height = buttonHeight

  self.bottomUi = newLayoutContainer(Layout_Vertical)
  self.bottomUi.heightMode = HeightMode_Expand
  self.bottomUi.widthMode = WidthMode_Expand
  self.bottomUi.frame = newFrame("Tools")

  self.addCursorButton = newButton("Add Cursor")
  self.addCursorButton.widthMode = WidthMode_Expand
  self.addCursorButton.height = buttonHeight

  self.addHitSoundButton = newButton("Add HitSound")
  self.addHitSoundButton.widthMode = WidthMode_Expand
  self.addHitSoundButton.height = buttonHeight

  self.settingButton = newButton("Settings")
  self.settingButton.widthMode = WidthMode_Expand
  self.settingButton.height = buttonHeight

  self.window.add(self.ui)
  self.ui.add(self.skinfileUi)
  self.ui.add(self.menuUi)
  self.menuUi.add(self.topUi)
  self.topUi.add(self.changeCursorButton)
  self.topUi.add(self.changeHitSoundButton)
  self.menuUi.add(self.bottomUi)
  self.bottomUi.add(self.addCursorButton)
  self.bottomUi.add(self.addHitSoundButton)
  self.bottomUi.add(self.settingButton)
  
  self.isShowed = false
  self.skinfiles = @[]
  self.isSelectedSeq = @[]

  self.window.minHeight = 300
  self.window.minWidth = 600

method setControls(self:ToolWindow): void =
  const buttonWidth: int = 100

  self.ui = newLayoutContainer(Layout_Vertical)

  self.skinfileUi = newLayoutContainer(Layout_Vertical)
  self.skinfileUi.heightMode = HeightMode_Expand
  self.skinfileUi.widthMode = WidthMode_Expand
  self.skinfileUi.frame = newFrame()

  self.buttonUi = newLayoutContainer(Layout_Horizontal)
  self.buttonUi.height = 60
  self.buttonUi.widthMode = WidthMode_Expand
  self.buttonUi.xAlign = XAlign_Right
  self.buttonUi.padding = 12

  self.changeButton = newButton("change")
  self.changeButton.heightMode = HeightMode_Expand
  self.changeButton.width = buttonWidth

  self.cancelButton = newButton("cancel")
  self.cancelButton.heightMode = HeightMode_Expand
  self.cancelButton.width = buttonWidth

  self.window.add(self.ui)
  self.ui.add(self.skinfileUi)
  self.ui.add(self.buttonUi)
  self.buttonUi.add(self.changeButton)
  self.buttonUi.add(self.cancelButton)

  self.isShowed = false
  self.skinfiles = @[]
  self.isSelectedSeq = @[]

  self.window.resizable = false

method setControls(self:SettingWindow): void =
  self.ui = newLayoutContainer(Layout_Vertical)
  
  self.changePathUi = newLayoutContainer(Layout_Vertical)
  self.changePathUi.widthMode = WidthMode_Expand
  self.changePathUi.frame = newFrame("change osu! folder path")
  
  self.referDirUi = newLayoutContainer(Layout_Horizontal)
  self.referDirUi.widthMode = WidthMode_Expand
  self.referDirButton = newButton("reference")

  self.pathTextBox = newTextBox()

  self.savePathUi = newLayoutContainer(Layout_Horizontal)
  self.savePathUi.widthMode = WidthMode_Expand
  self.savePathUi.xAlign = XAlign_Right

  self.savePathButton = newButton("save")

  self.changeLangUi = newLayoutContainer(Layout_Vertical)
  self.changeLangUi.widthMode = WidthMode_Expand
  self.changeLangUi.frame = newFrame("change language")

  self.comboBox = newComboBox()
  self.comboBox.widthMode = WidthMode_Expand

  self.saveLangUi = newLayoutContainer(Layout_Horizontal)
  self.saveLangUi.widthMode = WidthMode_Expand
  self.saveLangUi.xAlign = XAlign_Right

  self.saveLangButton = newButton("save")

  self.window.add(self.ui)
  self.ui.add(self.changePathUi)
  self.changePathUi.add(self.referDirUi)
  self.referDirUi.add(self.referDirButton)
  self.referDirUi.add(self.pathTextBox)
  self.changePathUi.add(self.savePathUi)
  self.savePathUi.add(self.savePathButton)
  self.ui.add(self.changeLangUi)
  self.changeLangUi.add(self.comboBox)
  self.changeLangUi.add(self.saveLangUi)
  self.saveLangUi.add(self.saveLangButton)

  self.window.resizable = false

##################################
# Implementation - Event Handler #
##################################
method setEvents(self:MainWindow): void =
  self.window.onCloseClick = proc(event: CloseClickEvent) =
    case self.window.msgBox("Quit?", "Quit the applciation", "Quit", "Cancel")
    of 1: app.quit()
    else: discard

method setEvents(self:ChangeCursorWindow): void =
  discard

method setEvents(self:ChangeHitSoundWindow): void =
  discard

method setEvents(self:AddCursorWindow): void =
  discard

method setEvents(self:AddHitSoundWindow): void =
  discard

method setEvents(self:SettingWindow): void =
  discard

when isMainModule:
  main()