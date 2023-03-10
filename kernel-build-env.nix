let
  pkgs = import <nixpkgs> { };
in
(pkgs.buildFHSUserEnv {
  name = "kernel-build-env";
  targetPkgs = pkgs: (with pkgs;
    [
      pkgconfig
      ncurses6
      ncurses5
      pkgsCross.aarch64-multiplatform.stdenv.cc
      pkgsCross.arm-embedded.stdenv.cc
      clang15Stdenv
      pkgsLLVM.crossLibcStdenv
      glibc
      libcxx
      zlib
      ninja
    ]
    ++ pkgs.linux.nativeBuildInputs);
  runScript = pkgs.writeScript "init.sh" ''
    export ARCH=arm64
    export LOCAL_CLANG_PATH=$HOME/Development/clang-google/linux-x86/clang-r487747
    export PATH=$LOCAL_CLANG_PATH/bin:$PATH
    export CLANG_TRIPLE=aarch64-linux-gnu-
    export LD_LIBRARY_PATH=$LOCAL_CLANG_PATH/lib:$LD_LIBRARY_PATH
    exec bash
  '';
}).env