{
  description = "QCalEval — Vision-language model evaluation on quantum calibration plots";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pyproject-nix.url = "github:pyproject-nix/pyproject.nix";
  };

  outputs = { self, nixpkgs, flake-utils, pyproject-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python312;

        # Load/parse requirements.txt as the single source of truth for pins.
        project = pyproject-nix.lib.project.loadRequirementsTxt { projectRoot = ./.; };

        pythonEnv =
          # Assert that nixpkgs versions match what's pinned in requirements.txt.
          assert project.validators.validateVersionConstraints { inherit python; } == { };
          python.withPackages (project.renderers.withPackages { inherit python; });

        mkBenchmark = name: scriptPath:
          pkgs.writeShellApplication {
            inherit name;
            runtimeInputs = [ pythonEnv ];
            text = ''
              exec python ${scriptPath} "$@"
            '';
          };

        zeroshot = mkBenchmark "qcaleval-zeroshot" ./benchmark_zeroshot.py;
        icl = mkBenchmark "qcaleval-icl" ./benchmark_icl.py;
        judge = mkBenchmark "qcaleval-judge" ./benchmark_judge.py;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [ pythonEnv ];
          shellHook = ''
            echo "QCalEval dev shell — Python ${python.version}"
            echo "Scripts: benchmark_zeroshot.py, benchmark_icl.py, benchmark_judge.py"
          '';
        };

        packages = {
          inherit zeroshot icl judge;
          default = zeroshot;
        };

        apps = {
          zeroshot = {
            type = "app";
            program = "${zeroshot}/bin/qcaleval-zeroshot";
          };
          icl = {
            type = "app";
            program = "${icl}/bin/qcaleval-icl";
          };
          judge = {
            type = "app";
            program = "${judge}/bin/qcaleval-judge";
          };
          default = {
            type = "app";
            program = "${zeroshot}/bin/qcaleval-zeroshot";
          };
        };
      });
}
