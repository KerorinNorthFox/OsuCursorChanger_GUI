import
  std/os,
  std/parsecfg,
  std/httpclient,
  std/json

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
  # TODO: コンフィグの内容記述
  dict.writeConfig(CONFIGPATH)

if not CONFIGPATH.fileExists:
  makeConfig()

