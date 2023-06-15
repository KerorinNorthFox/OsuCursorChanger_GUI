type Language = object
  language*: string

let
  english: Language = Language(
    language:"English"
  )
  japanese: Language = Language(
    language:"Japanese"
  )

  LANG*: array[2,Language] = [english, japanese]