{
  stdenv,
  aeroshell-kwin-repo,
  kdePackages,
  cmake,
  lib
}:
stdenv.mkDerivation {
  name = "aeroshell-default-rules";
  version = "2026-02-22";
  src = aeroshell-kwin-repo;

  postPatch = ''
    substituteInPlace CMakeLists.txt --replace-fail \
      "add_subdirectory(effects_cpp)" "add_subdirectory(rules)"
    substituteInPlace CMakeLists.txt --replace-fail \
      "find_package(KDecoration3 REQUIRED)" ""
    sed -i \
      -e '/^if(KWIN_BUILD_WAYLAND)/,/^endif()/d' \
      -e '/find_package(KWinX11/d' \
      -e '/find_package(KWinDBusInterface/d' \
      -e '/find_package(epoxy/d' \
      -e '/find_package(Vulkan/d' \
      -e '/find_package(WaylandProtocols/,/^)/d' \
      CMakeLists.txt
  '';

  buildInputs = with kdePackages; [
    extra-cmake-modules qtdeclarative
    qttools kconfig ki18n
    kconfigwidgets kcoreaddons kcrash kio
    kservice knotifications kwidgetsaddons
    kwindowsystem kguiaddons kcmutils ksvg
  ];
  nativeBuildInputs = [ cmake kdePackages.wrapQtAppsHook ];
  cmakeFlags = [ "-DKWIN_INSTALL_MISC=false" ];
}
