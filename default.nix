let
  sources = import ./nix/sources.nix;
  pinned = import sources."nixpkgs" { config = {}; overlays = []; };
in

{ pkgs ? pinned }:

let
  inherit (pkgs) callPackage;

  mavenix = import sources."mavenix" { inherit pkgs; };

  ttuegel =
    let
      src = builtins.fetchGit {
        url = "https://github.com/ttuegel/nix-lib";
        rev = "66bb0ab890ff4d828a2dcfc7d5968465d0c7084f";
      };
    in import src { inherit pkgs; };

  k = callPackage ./nix/k.nix {
    inherit mavenix;
  };

  llvm-backend-project = import ./llvm-backend/src/main/native/llvm-backend { inherit pkgs; };
  inherit (llvm-backend-project) clang llvm-backend;

  haskell-backend-project = import ./haskell-backend/src/main/native/haskell-backend {
    src = ttuegel.cleanGitSubtree {
      src = ./.;
      subDir = "haskell-backend/src/main/native/haskell-backend";
    };
  };
  haskell-backend = haskell-backend-project.kore;

  self = {
    inherit k clang llvm-backend haskell-backend;
    inherit mavenix;
    inherit (pkgs) mkShell;
  };

in self

