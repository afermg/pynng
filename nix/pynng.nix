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
  src = fetchFromGitHub {
    owner = "codypiersall";
    repo = "pynng" ;
    rev = "2179328f8a858bbb3e177f66ac132bde4a5aa859";
    sha256 = "sha256-TxIVcqc+4bro+krc1AWgLdZKGGuQ2D6kybHnv5z1oHg=";
  };
  preBuild = ''
  ls -lh
  pwd
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
    homepage = "https://github.com/codypiersall/pynng";
    license = lib.licenses.mit;
  };
}
