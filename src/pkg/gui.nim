import
  nigui,
  nigui/msgbox,
  std/os,
  ./info,
  ./utils

##################################
# Definition #####################
##################################
type
  Skin = ref object
    ui: LayoutContainer
    checkBox: Checkbox
    skinNameLabel: Label

type
  Application = ref object of RootObj
    window: Window
    ui: LayoutContainer

  ContainsSkinfile = ref object of Application
    skinfileUi: LayoutContainer # 画面左側UI
    skinfiles: seq[Skin]

  ToolWindow = ref object of ContainsSkinfile
    changeButton: Button
    cancelButton: Button

  SettingWindow = ref object of Application
    changePathUi: LayoutContainer # パス変更UI
    pathTextBox: TextBox
    buttonUi: LayoutContainer
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

    changeCursor: ToolWindow
    changeHitSound: ToolWindow
    addCursor: ToolWindow
    addHitSound: ToolWindow
    setting: SettingWindow

proc newApp(self: MainWindow): void

##################################
# Implementation #################
##################################
var
  application: MainWindow = MainWindow()

proc main(): void =
  app.init()
  application.newApp()
  app.run()

proc newApp(self: MainWindow): void =
  discard

when isMainModule:
  main()