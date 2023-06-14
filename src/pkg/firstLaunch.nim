import
  nigui

type
  FirstLaunchWindow* = ref object
    window: Window
    ui: LayoutContainer

    headerUi: LayoutContainer
    welcomeLabel: Label
    changeLangLabel: Label
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
  self.ui = newLayoutContainer(Layout_Vertical)
  self.headerUi = newLayoutContainer(Layout_Vertical)
  self.welcomeLabel = newLabel("Thank you for installing")
  self.changeLangLabel = newLabel("Change the language")
  self.referOsuDirLabel = newLabel("Refer the osu! folder")
  self.completionLabel = newLabel("All process has finished successfully!")
  
  self.bodyUi = newLayoutContainer(Layout_Vertical)
  self.selectLangComboBox = newComboBox()
  self.referOsuDirUi = newLayoutContainer(Layout_Horizontal)
  self.pathTextBox = newTextBox()
  self.referOsuDirButton = newButton("reference")

  let
    next: string = "next"
    previous: string = "previous"
  self.footerUi = newLayoutContainer(Layout_Horizontal)
  self.welcomeNextButton = newButton(next)
  self.exitButton = newButton("exit")
  self.selectLangPreviousButton = newButton(previous)
  self.selectLangNextButton = newButton(next)
  self.referOsuDirPreviousButton = newButton(previous)
  self.referOsuDirNextButton = newButton(next)
  self.completionPreviousButton = newButton(previous)
  self.completionButton = newButton("finish")

  self.window.add(self.bodyUi)
  self.ui.add(self.headerUi)
  self.headerUi.add(self.welcomeLabel)
  self.ui.add(self.bodyUi)
  self.ui.add(self.footerUi)
  self.footerUi.add(self.exitButton)
  self.footerUi.add(self.welcomeNextButton)

proc setEvents(self:FirstLaunchWindow): void =
  discard

proc newApp*(self:FirstLaunchWindow): void =
  let
    height: int = 300
    width: int = 400
  self.window = newWindow("Set up")
  self.window.height = height
  self.window.width = width

  self.setControls()
  self.setEvents()

  self.window.show()