{ stdenv, fetchzip, pkgconfig, ffmpeg, gtk2-x11, libjpeg }:

stdenv.mkDerivation rec {
  pname = "droidcam";
  version = "0";

  src = fetchzip {
    url = "https://github.com/aramg/droidcam/archive/b49842a02611f8ddc6b9342ef74e299abd1c4090.zip";
    sha256 = "05kd5ihwb3fldmalv67jgpw4x0z0q39lfis69r7yh03qiqlviymk";
  };

  sourceRoot = "source/linux";

  buildInputs = [ pkgconfig ];
  nativeBuildInputs = [ ffmpeg gtk2-x11 libjpeg ];

  postPatch = ''
    sed -i -e 's:/opt/libjpeg-turbo/include:${libjpeg.out}/include:' Makefile
    sed -i -e 's:/opt/libjpeg-turbo/lib`getconf LONG_BIT`/libturbojpeg.a:${libjpeg.out}/lib/libturbojpeg.so:' Makefile
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp droidcam droidcam-cli $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "DroidCam Linux client";
    homepage = https://github.com/aramg/droidcam;
  };
}
