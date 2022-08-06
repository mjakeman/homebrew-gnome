# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class VteDev < Formula
  desc ""
  homepage ""
  url "https://gitlab.gnome.org/GNOME/vte/-/archive/vte-0-70/vte-vte-0-70.tar.bz2"
  sha256 "6dbe4a47dccefa8733fe454ce724f6b181fd98dd3088a471a29d4a6ccde0a23b"
  license ""

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "gtk4-dev"
  depends_on "pcre2"
  depends_on "gnutls"
  depends_on "glib-utils" => :build
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
