{
	description = "nix build environment";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
	};

	outputs = { self, nixpkgs, fenix }:
		let
			universal = function:
				nixpkgs.lib.genAttrs [
					"x86_64-linux"
					"aarch64-linux"
				] (system: function nixpkgs.legacyPackages.${system});

			overrides = (builtins.fromTOML (builtins.readFile ./rust-toolchain.toml));
		in {
			devShell = universal (pkgs: 
				(pkgs.mkShell rec {
					name = "rust";

					nativeBuildInputs = with pkgs; [
						rustup

						pkg-config
					];

					buildInputs = with pkgs; [
						stdenv.cc.cc.lib
					];

					RUSTC_VERSION = overrides.toolchain.channel;
					LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
					
					shellHook = ''
						export PATH="''${CARGO_HOME:-~/.cargo}/bin":"$PATH"
						export PATH="''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-${pkgs.stdenv.hostPlatform.rust.rustcTarget}/bin":"$PATH"
					'';
				}));
		};
}
