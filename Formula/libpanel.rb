# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Libpanel < Formula
  desc ""
  homepage ""
  url "https://download.gnome.org/sources/libpanel/1.0/libpanel-1.0.alpha.tar.xz"
  sha256 "370b39bf544c65ff732927817ede337cb8a15aa36d7081cdb91b593c040d3195"
  license ""

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "gobject-introspection" => :build
  depends_on "pkg-config" => :build
  depends_on "vala" => :build
  depends_on "libadwaita"
  depends_on "glib-utils" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test libpanel`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
