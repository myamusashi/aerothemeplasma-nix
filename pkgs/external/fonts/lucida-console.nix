{
  stdenvNoCC,
  fetchurl
}:
stdenvNoCC.mkDerivation {
  pname = "lucida-console";
  version = "5";

  src = fetchurl {
    url = "https://raw.githubusercontent.com/FSKiller/Microsoft-Fonts/main/lucon.ttf";
    hash = "sha256-LKLP3iY/pCDo05Qg8HXumsgLwHlCcsU6xFcaiPigdaY=";
  };

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    ln -st $out/share/fonts/truetype $src
    runHook postInstall
  '';
}