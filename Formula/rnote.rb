# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rnote < Formula
  desc "Sketch and take handwritten notes."
  homepage "https://github.com/flxzt/rnote"
  url "https://github.com/flxzt/rnote/releases/download/v0.5.4/rnote-0.5.4.tar.xz"
  sha256 "f8dc13dd81a3bec17b61954398ada07fd4cec417b3729222064aa3c2d23f9b69"
  license "GPL-3.0"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "rust" => :build
  depends_on "pkg-config" => :build
  depends_on "xz" => :build
  depends_on "libadwaita"
  depends_on "poppler"
  depends_on "desktop-file-utils"
  depends_on "appstream-glib"

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
    # software. Run the test with `brew test rnote`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
