{
  lib,
  # build deps
  buildPythonPackage,
  fetchFromGitHub,
  # Py build
  setuptools,
  setuptools-scm,
  pytest,
  trio,
  sphinx,
  # main deps
  cffi,
  cmake,
  sniffio,
}:
let
    nng = fetchFromGitHub {
    owner = "nanomsg";
    repo = "nng";
    rev = "v1.6.0";
    sha256 = "sha256-Kq8QxPU6SiTk0Ev2IJoktSPjVOlAS4/e1PQvw2+e8UA=";
  };
  mbedtls = fetchFromGitHub {
    owner = "ARMmbed";
    repo = "mbedtls";
    rev = "v3.5.1";
    sha256 = "sha256-HxsHcGbSExp1aG5yMR/J3kPL4zqnmNoN5T5wfV3APaw=";
  };
in
buildPythonPackage {
  preBuild = ''
  cp -r ${nng} nng
  cp -r ${mbedtls} mbedtls
  chmod -R +w nng
  chmod -R +w mbedtls
  pwd
  ls -l
  '';
  # buildPhase = "runHook preBuild" ++ old.buildPhase;
  pname = "pyngg";
  version = "0.8.1";
  src = ./..; # For local testing, add flag --impure when running
  # src = fetchFromGitHub {
  #   owner = "afermg";
  #   repo = "baby";
  #   rev = "39eec0d4c3b8fad9b0a8683cbedf9b4558e07222";
  #   sha256 = "sha256-ptLXindgixDa4AV3x+sQ9I4W0PScIQMkyMNMo0WFa0M=";
  # };
  nativeBuildInputs = [
    cmake
  ];
  build-system = [
    setuptools
    setuptools-scm
  ];
  buildInputs = [
    setuptools
    setuptools-scm
    cffi
    sniffio
  ];
  propagatedBuildInputs = [
  ];
  dependencies = [
  ];
  pythonImportsCheck = [
  ];
  # dontUseCmakeBuildDir = true;
  pyproject = true;
  dontUseCmakeConfigure = true;
  meta = {
    description = "pyngg";
    homepage = "https://github.com/afermg/pynng";
    license = lib.licenses.mit;
  };
}
