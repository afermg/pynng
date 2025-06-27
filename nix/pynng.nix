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
buildPythonPackage rec {
  pname = "pynng";
  version = "0.8.1";
  format = "setuptools";
  # src = ./..; # For local testing, add flag --impure when running
  # src = fetchFromGitHub {
  #   owner = "codypiersall";
  #   repo = "pynng";
  #   rev = "28bb5c8fd5b145cf255233d8bc071ec25e083e68";
  #   sha256 = "sha256-HxsHcGbSExp1aG5yMR/J3kPL4zqnmNoN5T5wfV3APaw=";
  # };
  src = fetchFromGitHub {
    owner = "afermg";
    repo = "pynng" ;
    rev = "e254adc2bca0c70ca30554cdb1db16ae1e496460";
    sha256 = "sha256-13HloXwjVHm39J9N5GlHJ8T7X7XVcnclMsbhY2o6tac=";
  };
  # sourceRoot = "${src}";
  preBuild = ''
  cp -r ${mbedtls} mbedtls
  chmod -R +w mbedtls
  cp -r ${nng} nng
  chmod -R +w nng
  '';
  nativeBuildInputs = [
    cmake
    ninja
  ];
  build-system = [
    setuptools
    setuptools-scm
  ];
  dependencies = [
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
