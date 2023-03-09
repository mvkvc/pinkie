{
  description = "pinkie";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs//a1291d0d020a200c7ce3c48e96090bfa4890a475";
      flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            elixir
            gcc
            gnumake
            inotify-tools
            nodejs-18_x
            kubo
            nixpacks
            # docker
          ];
          shellHook = ''
            export MIX_ENV=dev
            export MIX_HOME=$PWD/.nix_mix
            export HEX_HOME=$PWD/.nix_hex
            export PATH=$MIX_HOME/bin:$PATH
            export PATH=$HEX_HOME/bin:$PATH
            export PATH=$MIX_HOME/escripts:$PATH
            export LIVEBOOK_HOME=$PWD/notebooks
            export LIVEBOOK_SHUTDOWN_ENABLED=true
            export LOCALE_ARCHIVE=${pkgs.glibcLocales}/lib/locale/locale-archive
            export DOCKER_BUILDKIT=1
            export IS_NIX=true
          '';
        };
      }
    );
}
