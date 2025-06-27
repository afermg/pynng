{
  lib,
  # build deps
  cmake,
  buildPythonPackage,
  fetchPypi,
  # Py build
  setuptools,
  setuptools-scm,
  cffi,
  sniffio,
  # test/docs deps
  pytest,
  trio,
  # Optional
  ninja,
}:
buildPythonPackage rec {
  pname = "pynng";
  version = "0.8.1";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-YBZfNL31AYheCszq7tebw1pX88o8kTyzjBSRm5vTZW8=" ;
  }; # For local testing, add flag --impure when running
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
  propagatedBuildInputs = [
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
