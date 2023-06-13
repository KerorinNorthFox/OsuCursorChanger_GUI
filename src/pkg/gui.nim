import
  nigui,
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

##################################
# Implementation #################
##################################
var
  application: MainWindow = MainWindow()

proc main(): void =
  app.init()
  application.newApp()
  application.showWindow()
  # 初回起動の時の処理
  if loadIsFirstLaunch() == 0:
    var firstLaunch: FirstLaunchWindow = FirstLaunchWindow()
    firstLaunch.newApp()
    updateIsFirstLaunch(1)
  app.run()

# アプリケーション作成
proc newApp(self:MainWindow): void =
  self.createWindow("OsuCursorChanger GUI - "&VERSION, 500, 800)
  let height: int = 500
  let width: int = 800
  self.changeCursor = ChangeCursorWindow()
  self.changeCursor.createWindow("Change Cursor", height, width)
  self.changeHitSound = ChangeHitSoundWindow()
  self.changeHitSound.createWindow("Change HitSound", height, width)
  self.addCursor = AddCursorWindow()
  self.addCursor.createWindow("Add Cursor", height, width)
  self.addHitSound = AddHitSoundWindow()
  self.addHitSound.createWindow("Add HitSound", height, width)
  self.setting = SettingWindow()
  self.setting.createWindow("Settings", 300, 400)

  self.setControls()
  self.changeCursor.setControls()
  self.changeHitSound.setControls()
  self.addCursor.setControls()
  self.addHitSound.setControls()
  self.setting.setControls()

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
  self.ui = newLayoutContainer(Layout_Horizontal)

  self.skinfileUi = newLayoutContainer(Layout_Vertical)
  self.rightUi = newLayoutContainer(Layout_Vertical)
  self.topUi = newLayoutContainer(Layout_Vertical)
  self.changeCursorButton = newButton("Change Cursor")
  self.changeHitSoundButton = newButton("Change HitSound")
  self.bottomUi = newLayoutContainer(Layout_Vertical)
  self.addCursorButton = newButton("Add Cursor")
  self.addHitSoundButton = newButton("Add HitSound")
  self.settingButton = newButton("Settings")

  self.window.add(self.ui)
  self.ui.add(self.skinfileUi)
  self.ui.add(self.rightUi)
  self.rightUi.add(self.topUi)
  self.topUi.add(self.changeCursorButton)
  self.topUi.add(self.changeHitSoundButton)
  self.rightUi.add(self.bottomUi)
  self.bottomUi.add(self.addCursorButton)
  self.bottomUi.add(self.addHitSoundButton)
  self.bottomUi.add(self.settingButton)
  
  self.isShowed = false
  self.skinfiles = @[]
  self.isSelectedSeq = @[]

method setControls(self:ToolWindow): void =
  self.ui = newLayoutContainer(Layout_Vertical)

  self.skinfileUi = newLayoutContainer(Layout_Vertical)
  self.buttonUi = newLayoutContainer(Layout_Horizontal)
  self.changeButton = newButton("change")
  self.cancelButton = newButton("cancel")

  self.window.add(self.ui)
  self.ui.add(self.skinfileUi)
  self.ui.add(self.buttonUi)
  self.buttonUi.add(self.changeButton)
  self.buttonUi.add(self.cancelButton)

  self.isShowed = false
  self.skinfiles = @[]
  self.isSelectedSeq = @[]

method setControls(self:SettingWindow): void =
  self.ui = newLayoutContainer(Layout_Vertical)
  
  self.changePathUi = newLayoutContainer(Layout_Vertical)
  self.referDirUi = newLayoutContainer(Layout_Horizontal)
  self.pathTextBox = newTextBox()
  self.referDirButton = newButton("reference")
  self.savePathButton = newButton("save")

  self.changeLangUi = newLayoutContainer(Layout_Vertical)
  self.comboBox = newComboBox()
  self.saveLangButton = newButton("save")

  self.window.add(self.ui)
  self.ui.add(self.changePathUi)
  self.changePathUi.add(self.referDirUi)
  self.referDirUi.add(self.pathTextBox)
  self.referDirUi.add(self.referDirButton)
  self.changePathUi.add(self.savePathButton)
  self.ui.add(self.changeLangUi)
  self.changeLangUi.add(self.comboBox)
  self.changeLangUi.add(self.saveLangButton)

when isMainModule:
  main()