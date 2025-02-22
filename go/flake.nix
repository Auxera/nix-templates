{
  description = "Go 1.24";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        overlays.default = final: prev: {
          go = final."go_1_24";
        };

        devShells.default = pkgs.mkShell rec {
          packages = with pkgs; [
            go
            gotools
            golangci-lint
          ];
        };
      }
    );
}
