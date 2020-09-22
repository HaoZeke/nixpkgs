{ stdenv, fetchgit, cmake, lib, expat, ragelDev, which, lua5 }:

stdenv.mkDerivation rec {
  name = "doxyrest";
  # Somehow fetchFromGithub was ignoring submodules
  src = fetchgit {
    url = "https://github.com/vovkos/doxyrest_b";
    rev = "3500bc0101c5ebe4921d8cca49b42e209e761971";
    sha256 = "1h1r0g9yklgf2f8qv4dw0lnsldpcr5rch14q934fvxqbpjh9b7fn";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ expat lua5 ragelDev which cmake ];

  # otherwise "cc1: error: -Wformat-security ignored without -Wformat [-Werror=format-security]"
  hardeningDisable = [ "format" ];

  meta = with stdenv.lib; {
    description = "A compiler from Doxygen XML to reStructuredText";
    longDescription =
      "A compiler from Doxygen XML to reStructuredText -- hence, the name. It parses XML databases generated by Doxygen and produces reStructuredText for the Python documentation generator Sphinx.";
    homepage = "https://github.com/vovkos/doxyrest";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = [ maintainers.HaoZeke ];
  };
}
