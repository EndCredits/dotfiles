let
  pkgs = import <nixpkgs> { };
in
(pkgs.buildFHSUserEnv {
  name = "kernel-build-env";
  targetPkgs = pkgs: (with pkgs;
    [
      pkgconfig
      ncurses
      pkgsCross.aarch64-multiplatform.stdenv.cc
    ]
    ++ pkgs.linux.nativeBuildInputs);
  runScript = pkgs.writeScript "init.sh" ''
    export ARCH=arm64
    export CROSS_COMPILE=aarch64-unknown-linux-gnu-
    exec bash
  '';
}).env