# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Vte < Formula
  desc "Virtual Terminal library"
  homepage "https://gitlab.gnome.org/GNOME/vte"
  url "https://download.gnome.org/sources/vte/0.70/vte-0.70.0.tar.xz"
  sha256 "93e0dd4a1bc2a7a1a62da64160a274cce456976ea1567d98591da96e2d265ae6"
  license "LGPL-3.0-or-later"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "gtk4"
  depends_on "pcre2"
  depends_on "gnutls"
  depends_on "glib" => :build
  depends_on "gobject-introspection" => :build
  depends_on "vala" => :build

  def install
    args = std_meson_args + %w[
      -Dgtk3=false
      -Dgtk4=true
      -D_b_symbolic_functions=false
    ]

    mkdir "build" do
      system "meson", *args, ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  stable do
    patch :DATA
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test vte`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
__END__
diff --git a/meson.build b/meson.build
index 1900504..2c8f3e9 100644
--- a/meson.build
+++ b/meson.build
@@ -222,7 +222,7 @@ libc_feature_defines = [
 
 system = host_machine.system()
 
-if system == 'freebsd'
+if system == 'freebsd' or host_machine.system() == 'darwin'
   # Defining _POSIX_C_SOURCE above makes freebsd not expose some functionality
   # that's hidden behind __BSD_VISIBLE.  Not defininy any of the above however
   # makes it expose verything.
