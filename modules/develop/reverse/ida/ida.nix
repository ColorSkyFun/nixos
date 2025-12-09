{
  pkgs,
  lib,
  ...
}:
let
  pythonForIDA = pkgs.python313.withPackages (
    ps: with ps; [
      six
      rpyc
      keystone-engine
    ]
  );

  reg_script = ./reg.py;

  hrtng = pkgs.fetchurl {
    url = "https://github.com/KasperskyLab/hrtng/releases/download/v3.7.74/hrtng-ida9.2.zip";
    sha256 = "e8ea4ebccb887d70c0785eaf7aaa57e5542a6573cbf2f636ceebae6f4d136a69";
  };

  key_patch = fetchGit {
    url = "https://github.com/keystone-engine/keypatch";
    rev = "e7ecb93a4d242e83b9356b8258108773464646d4";
  };
  catppuccin = fetchGit {
    url = "https://github.com/catppuccin/ida-debugger";
    rev = "22f43b265c03f4b77fe6bcd9b09dcc3705e3092d";
  };
in
pkgs.stdenv.mkDerivation rec {
  pname = "ida-pro";
  version = "9.2.0.250908";

  src = pkgs.fetchurl {
    url = "https://dl.colorsky.fun/ida-pro_92_x64linux.run";
    sha256 = "aadd0f8ae972b84f94f2a974834abf1619f3bd933b3b4d8275f9c50008d05ae1";
  };

  desktopItem = pkgs.makeDesktopItem {
    name = "ida-pro";
    exec = "ida";
    icon = ./appico.png;
    comment = meta.description;
    desktopName = "IDA Pro";
    genericName = "Interactive Disassembler";
    categories = [ "Development" ];
    startupWMClass = "IDA";
  };
  desktopItems = [ desktopItem ];

  nativeBuildInputs = with pkgs; [
    unzip
    makeWrapper
    copyDesktopItems
    autoPatchelfHook
    qt6.wrapQtAppsHook
  ];

  # We just get a runfile in $src, so no need to unpack it.
  dontUnpack = true;

  # Add everything to the RPATH, in case IDA decides to dlopen things.
  runtimeDependencies = with pkgs; [
    cairo
    dbus
    fontconfig
    freetype
    glib
    gtk3
    libdrm
    libGL
    libkrb5
    libsecret
    qt6.qtbase
    qt6.qtwayland
    libunwind
    libxkbcommon
    libsecret
    openssl.out
    stdenv.cc.cc
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXau
    xorg.libxcb
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    zlib
    curl.out
    pythonForIDA
  ];
  buildInputs = runtimeDependencies;

  dontWrapQtApps = true;

  installPhase = ''
    runHook preInstall

    function print_debug_info() {
      if [ -f installbuilder_installer.log ]; then
        cat installbuilder_installer.log
      else
        echo "No debug information available."
      fi
    }

    trap print_debug_info EXIT

    mkdir -p $out/bin $out/lib $out/opt/.local/share/applications

    # IDA depends on quite some things extracted by the runfile, so first extract everything
    # into $out/opt, then remove the unnecessary files and directories.
    IDADIR="$out/opt"
    # IDA doesn't always honor `--prefix`, so we need to hack and set $HOME here.
    HOME="$out/opt"

    # Invoke the installer with the dynamic loader directly, avoiding the need
    # to copy it to fix permissions and patch the executable.
    $(cat $NIX_CC/nix-support/dynamic-linker) $src \
      --mode unattended --debuglevel 4 --prefix $IDADIR

    # Link the exported libraries to the output.
    for lib in $IDADIR/*.so $IDADIR/*.so.6; do
      ln -s $lib $out/lib/$(basename $lib)
    done

    # Manually patch libraries that dlopen stuff.
    patchelf --add-needed libpython3.13.so $out/lib/libida.so
    patchelf --add-needed libcrypto.so $out/lib/libida.so
    patchelf --add-needed libsecret-1.so.0 $out/lib/libida.so

    # Some libraries come with the installer.
    addAutoPatchelfSearchPath $IDADIR

    # Link the binaries to the output.
    # Also, hack the PATH so that pythonForIDA is used over the system python.
    for bb in ida; do
      wrapProgram $IDADIR/$bb \
        --prefix IDADIR : $IDADIR \
        --prefix QT_PLUGIN_PATH : $IDADIR/plugins/platforms \
        --prefix PYTHONPATH : $out/bin/idalib/python \
        --prefix PATH : ${pythonForIDA}/bin:$IDADIR \
        --prefix LD_LIBRARY_PATH : $out/lib
      ln -s $IDADIR/$bb $out/bin/$bb
    done

    # Register for ida-pro
    cd $IDA
    ${pythonForIDA}/bin/python ${reg_script}

    # Install Key Patch Plugin
    cp -r ${key_patch}/keypatch.py $out/opt/plugins/keypatch.py

    # Install hrtng Plugin
    unzip ${hrtng} -d $out/opt/plugins/hrtng/

    # Install catppuccin
    cp -r ${catppuccin}/catppuccin-mocha $out/opt/themes/catppuccin-mocha

    runHook postInstall
  '';

  meta = with lib; {
    description = "The world's smartest and most feature-full disassembler";
    homepage = "https://hex-rays.com/ida-pro/";
    license = licenses.unfree;
    mainProgram = "ida";
    maintainers = with maintainers; [ msanft ];
    platforms = [ "x86_64-linux" ]; # Right now, the installation script only supports Linux.
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
