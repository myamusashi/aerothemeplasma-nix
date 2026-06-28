{
  stdenv,
  aeroshell-kwin-repo,
  kdePackages,
  cmake
}:
stdenv.mkDerivation {
  name = "aeroshell-i18n-kwin";
  version = "2026-04-03";
  src = aeroshell-kwin-repo;
  
  postPatch = ''
    sed -i "24,53d;58,69d" CMakeLists.txt
    substituteInPlace CMakeLists.txt \
      --replace-fail "install()" "ki18n_install(po)" \
      --replace-fail "find_package(KWinDBusInterface CONFIG REQUIRED)" "find_package(KF6 ''${KF_MIN_VERSION} REQUIRED COMPONENTS I18n)"
  '';
  
  buildInputs = with kdePackages; [ qtbase ki18n ];
  nativeBuildInputs = [ cmake kdePackages.wrapQtAppsHook ];
  cmakeFlags = [ "-DKWIN_INSTALL_MISC=false" ];
}