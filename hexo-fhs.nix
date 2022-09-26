{ pkgs ? import <nixpkgs> {} }:
 
let fhs = pkgs.buildFHSUserEnv {
  name = "hexo-env";
  targetPkgs = pkgs: with pkgs;
    [ git
      python2
      python3
      curl
      nodejs
    ];
  runScript = "bash && mkdir -p $HOME/.node-pack && bash";
  profile = ''
    export NPM_CONFIG_PREFIX=~/.node-pack
  '';
};
in pkgs.stdenv.mkDerivation {
  name = "hexo-shell";
  nativeBuildInputs = [ fhs ];
  shellHook = "exec hexo-env";

}
