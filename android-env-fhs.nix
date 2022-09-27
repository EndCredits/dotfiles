{ pkgs ? import <nixpkgs> {} }:

with import <nixpkgs> {};
 
let fhs = pkgs.buildFHSUserEnv {
  name = "android-env";
  targetPkgs = pkgs: with pkgs;
    [ git
      gitRepo
      bc
      gnupg
      python2
      curl
      procps
      openssl
      gnumake
      nettools
      androidenv.androidPkgs_9_0.platform-tools
      jdk
      schedtool
      utillinux
      m4
      gperf
      perl
      libxml2
      zip
      unzip
      bison
      flex
      lzop
      python3
      android-tools
      openssl_3
    ];
  multiPkgs = pkgs: with pkgs;
    [ zlib
      ncurses5
      openssl_3
    ];
  runScript = "bash";
  profile = ''
    export ALLOW_NINJA_ENV=true
    export USE_CCACHE=1
    export ANDROID_JAVA_HOME=${pkgs.jdk.home}
    export LD_LIBRARY_PATH=/usr/lib:/usr/lib32
    export PATH=/home/crepuscular/Working/home/crepuscular/toolchains/clang-crepuscular/bin:$PATH
  '';
};
in pkgs.stdenv.mkDerivation {
  name = "android-env-shell";
  nativeBuildInputs = [ fhs ];
  buildInputs = [ pkg-config openssl ];
  shellHook = "exec android-env";

}
