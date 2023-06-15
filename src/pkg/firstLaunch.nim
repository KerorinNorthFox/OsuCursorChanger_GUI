import
  nigui

type
  FirstLaunchWindow* = ref object
    window: Window
    ui: LayoutContainer

    headerUi: LayoutContainer
    welcomeLabel: Label
    selectLangLabel: Label
    referOsuDirLabel: Label
    completionLabel: Label

    bodyUi: LayoutContainer
    selectLangComboBox: ComboBox
    referOsuDirUi: LayoutContainer
    pathTextBox: TextBox
    referOsuDirButton: Button

    footerUi: LayoutContainer
    welcomeNextButton: Button
    exitButton: Button
    selectLangPreviousButton: Button
    selectLangNextButton: Button
    referOsuDirPreviousButton: Button
    referOsuDirNextButton: Button
    completionPreviousButton: Button
    completionButton: Button

proc setControls(self:FirstLaunchWindow): void =
  const
    uiHeight: int = 50
    buttonWidth: int = 100
    labelFontSize: float = 15.0

  self.ui = newLayoutContainer(Layout_Vertical)

  self.headerUi = newLayoutContainer(Layout_Vertical)
  self.headerUi.height = uiHeight
  self.headerUi.widthMode = WidthMode_Expand
  self.headerUi.padding = 20

  self.welcomeLabel = newLabel("Thank you for installing")
  self.welcomeLabel.widthMode = WidthMode_Expand
  self.welcomeLabel.fontSize = labelFontSize

  self.selectLangLabel = newLabel("Change the language")
  self.selectLangLabel.widthMode = WidthMode_Expand
  self.selectLangLabel.fontSize = labelFontSize

  self.referOsuDirLabel = newLabel("Refer the osu! folder")
  self.referOsuDirLabel.widthMode = WidthMode_Expand
  self.referOsuDirLabel.fontSize = labelFontSize

  self.completionLabel = newLabel("All process has finished successfully!")
  self.completionLabel.widthMode  =WidthMode_Expand
  self.completionLabel.fontSize = labelFontSize
  
  self.bodyUi = newLayoutContainer(Layout_Vertical)
  self.bodyUi.heightMode = HeightMode_Expand
  self.bodyUi.widthMode = WidthMode_Expand
  self.bodyUi.xAlign = XAlign_Center

  self.selectLangComboBox = newComboBox()

  self.referOsuDirUi = newLayoutContainer(Layout_Horizontal)
  self.referOsuDirUi.widthMode = WidthMode_Expand

  self.pathTextBox = newTextBox()
  self.pathTextBox.widthMode = WidthMode_Expand
  self.referOsuDirButton = newButton("reference")

  const
    next: string = "next"
    previous: string = "previous"

  self.footerUi = newLayoutContainer(Layout_Horizontal)
  self.footerUi.height = uiHeight
  self.footerUi.widthMode = WidthMode_Expand
  self.footerUi.xAlign = XAlign_Right
  self.footerUi.padding = 10

  self.welcomeNextButton = newButton(next)
  self.welcomeNextButton.heightMode = HeightMode_Expand
  self.welcomeNextButton.width = buttonWidth
  
  self.exitButton = newButton("exit")
  self.exitButton.heightMode = HeightMode_Expand
  self.exitButton.width = buttonWidth

  self.selectLangPreviousButton = newButton(previous)
  self.selectLangPreviousButton.heightMode = HeightMode_Expand
  self.selectLangPreviousButton.width = buttonWidth

  self.selectLangNextButton = newButton(next)
  self.selectLangNextButton.heightMode = HeightMode_Expand
  self.selectLangNextButton.width = buttonWidth

  self.referOsuDirPreviousButton = newButton(previous)
  self.referOsuDirPreviousButton.heightMode = HeightMode_Expand
  self.referOsuDirPreviousButton.width = buttonWidth

  self.referOsuDirNextButton = newButton(next)
  self.referOsuDirNextButton.heightMode = HeightMode_Expand
  self.referOsuDirNextButton.width = buttonWidth

  self.completionPreviousButton = newButton(previous)
  self.completionPreviousButton.heightMode = HeightMode_Expand
  self.completionPreviousButton.width = buttonWidth

  self.completionButton = newButton("finish")
  self.completionButton.heightMode = HeightMode_Expand
  self.completionButton.width = buttonWidth

  self.window.add(self.ui)
  self.ui.add(self.headerUi)
  self.headerUi.add(self.welcomeLabel)
  self.ui.add(self.bodyUi)
  self.referOsuDirUi.add(self.pathTextBox)
  self.referOsuDirUi.add(self.referOsuDirButton)
  self.ui.add(self.footerUi)
  self.footerUi.add(self.exitButton)
  self.footerUi.add(self.welcomeNextButton)

proc switchUi(self:FirstLaunchWindow, nowUi:int, button:string): void =
  assert(nowUi<=4, "invalid 'ui' argument")
  assert(button=="previous" or button=="next", "invalid 'button' argument")
  if button == "previous":
    if nowUi == 2:
      self.headerUi.remove(self.selectLangLabel)
      self.headerUi.add(self.welcomeLabel)
      self.bodyUi.remove(self.selectLangComboBox)
      self.footerUi.remove(self.selectLangPreviousButton)
      self.footerUi.remove(self.selectLangNextButton)
      self.footerUi.add(self.exitButton)
      self.footerUi.add(self.welcomeNextButton)
    elif nowUi == 3:
      self.headerUi.remove(self.referOsuDirLabel)
      self.headerUi.add(self.selectLangLabel)
      self.bodyUi.remove(self.referOsuDirUi)
      self.bodyUi.add(self.selectLangComboBox)
      self.footerUi.remove(self.referOsuDirPreviousButton)
      self.footerUi.remove(self.referOsuDirNextButton)
      self.footerUi.add(self.selectLangPreviousButton)
      self.footerUi.add(self.selectLangNextButton)
    elif nowUi == 4:
      self.headerUi.remove(self.completionLabel)
      self.headerUi.add(self.referOsuDirLabel)
      self.bodyUi.add(self.referOsuDirUi)
      self.footerUi.remove(self.completionPreviousButton)
      self.footerUi.remove(self.completionButton)
      self.footerUi.add(self.referOsuDirPreviousButton)
      self.footerUi.add(self.referOsuDirNextButton)
  elif button == "next":
    if nowUi == 1:
      self.headerUi.remove(self.welcomeLabel)
      self.headerUi.add(self.selectLangLabel)
      self.bodyUi.add(self.selectLangComboBox)
      self.footerUi.remove(self.exitButton)
      self.footerUi.remove(self.welcomeNextButton)
      self.footerUi.add(self.selectLangPreviousButton)
      self.footerUi.add(self.selectLangNextButton)
    elif nowUi == 2:
      self.headerUi.remove(self.selectLangLabel)
      self.headerUi.add(self.referOsuDirLabel)
      self.bodyUi.remove(self.selectLangComboBox)
      self.bodyUi.add(self.referOsuDirUi)
      self.footerUi.remove(self.selectLangPreviousButton)
      self.footerUi.remove(self.selectLangNextButton)
      self.footerUi.add(self.referOsuDirPreviousButton)
      self.footerUi.add(self.referOsuDirNextButton)
    elif nowUi == 3:
      self.headerUi.remove(self.referOsuDirLabel)
      self.headerUi.remove(self.completionLabel)
      self.bodyUi.remove(self.referOsuDirUi)
      self.footerUi.remove(self.referOsuDirPreviousButton)
      self.footerUi.remove(self.referOsuDirNextButton)
      self.footerUi.add(self.completionPreviousButton)
      self.footerUi.add(self.completionButton)

proc setEvents(self:FirstLaunchWindow): void =
  discard

proc newApp*(self:FirstLaunchWindow): void =
  let
    height: int = 200
    width: int = 350
  self.window = newWindow("Set up")
  self.window.height = height
  self.window.width = width

  self.setControls()
  self.setEvents()

  self.window.show()