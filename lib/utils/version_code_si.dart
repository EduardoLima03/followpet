class VersionCodeSi {
  String _versionCode = "1.0.0";

  static VersionCodeSi _instance = VersionCodeSi._internalBuilder();

  factory VersionCodeSi()=>_instance;

  VersionCodeSi._internalBuilder();

  void set Version(String value){
    if(value.contains('.'))
      this._versionCode = value;

    /// A logica é para que possa salvar a string tem que conte
    /// . de semparação do condigo de versao. se nao tiver não sela salvo
  }

  String get Version => _versionCode;
}