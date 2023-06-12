import
  nigui

type
  FirstBootWindow = ref object
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



