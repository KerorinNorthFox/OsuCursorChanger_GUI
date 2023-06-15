import
  std/os,
  std/parsecfg,
  std/httpclient,
  std/json,
  std/strutils

const
  CONFIGPATH*: string = "config.ini"

# githubからlatest releaseのタグを取得する
proc getLatestVersion*(url:string): string =
  var clt = newHttpClient()
  var res: string
  try:
    res = clt.getContent(url)
  except OSError:
    return ""
  let j = res.parseJson()
  return j["name"].getStr()

proc makeConfig*(path:string=""): void =
  var dict: Config = newConfig()
  dict.setSectionKey("DEFAULT", "isFirstLaunch", "0")
  dict.setSectionKey("LANGUAGE", "mode", "0")
  dict.setSectionKey("PATH", "path", path)
  dict.writeConfig(CONFIGPATH)

if not CONFIGPATH.fileExists:
  makeConfig()

# config.iniの[DEFAULT]のisFirstLaunchの取得
proc loadIsFirstLaunch*(): int =
  var dict: Config = loadConfig(CONFIGPATH)
  let isFirstLaunch: string = dict.getSectionValue("DEFAULT", "isFirstLaunch")
  return isFirstLaunch.parseInt

# config.iniの[DEFAULT]のisFirstBootのupdate
proc updateIsFirstLaunch*(isFirstLaunch:int): void =
  var dict: Config = loadConfig(CONFIGPATH)
  dict.setSectionKey("DEFAULT", "isFirstLaunch", $isFirstLaunch)
  dict.writeConfig(CONFIGPATH)

# config.iniの[LANGUAGE]のmodeの取得
proc loadLangMode(): int =
  var dict: Config = loadConfig(CONFIGPATH)
  let mode: string = dict.getSectionValue("LANGUAGE", "mode")
  return mode.parseInt

let LANGMODE*: int = loadLangMode()

# config.iniの[LANGUAGE]のmodeのupdate
proc updateLangMode*(mode:int): void =
  let mode: int = mode
  var dict: Config = loadConfig(CONFIGPATH)
  dict.setSectionKey("LANGUAGE", "mode", $mode)
  dict.writeConfig(CONFIGPATH)

# config.iniの[PATH]のpathの取得
proc loadPath*(): string =
  var dict: Config = loadConfig(CONFIGPATH)
  let path = dict.getSectionValue("PATH", "path")
  return path

# config.iniの[PATH]のpathのupdate
proc updatePath*(path:string): void =
  let path: string = path
  var dict: Config = loadConfig(CONFIGPATH)
  dict.setSectionKey("PATH", "path", path)
  dict.writeConfig(CONFIGPATH)