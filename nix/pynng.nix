{
  lib,
  # build deps
  cmake,
  buildPythonPackage,
  fetchFromGitHub,
  # Py build
  setuptools,
  setuptools-scm,
  cffi,
  sniffio,
  # test/docs deps
  pytest,
  trio,
  sphinx,
  # Optional
  ninja,
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
  cp -r ${mbedtls} mbedtls
  chmod -R +w mbedtls
  cp -r ${nng} nng
  chmod -R +w nng
  '';
  pname = "pynng";
  version = "0.8.1";
  src = ./..; # For local testing, add flag --impure when running
  # src = fetchFromGitHub {
  #   owner = "afermg";
  #   repo = "pynng";
  #   rev = "c90c1bbc9ecdfda931f9963d1c1e7734da33c58b";
  #   sha256 = "";
  # };
  nativeBuildInputs = [
    cmake
    ninja
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
  pythonImportsCheck = [
    "pynng"
  ];
  dontUseCmakeConfigure = true;
  meta = {
    description = "pynng";
    homepage = "https://github.com/afermg/pynng";
    license = lib.licenses.mit;
  };
}
