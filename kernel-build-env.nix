let
  pkgs = import <nixpkgs> { };
in
(pkgs.buildFHSUserEnv {
  name = "kernel-build-env";
  targetPkgs = pkgs: (with pkgs;
    [
      pkgconfig
      ncurses
      qt5.qtbase
      pkgsCross.aarch64-multiplatform.stdenv.cc
    ]
    ++ pkgs.linux.nativeBuildInputs);
  runScript = pkgs.writeScript "init.sh" ''
    export ARCH=arm64
    export CROSS_COMPILE=aarch64-unknown-linux-gnu-
    export PKG_CONFIG_PATH="${pkgs.ncurses.dev}/lib/pkgconfig:${pkgs.qt5.qtbase.dev}/lib/pkgconfig"
    export QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins"
    export QT_QPA_PLATFORMTHEME=qt5ct
    exec bash
  '';
}).env