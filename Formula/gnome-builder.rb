# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class GnomeBuilder < Formula
  desc "An IDE for writing GNOME-based software."
  homepage "https://gitlab.gnome.org/GNOME/gnome-builder"
  url "https://download.gnome.org/sources/gnome-builder/43/gnome-builder-43.0.tar.xz"
  sha256 "61585119d80fb70da3b8170249d3223839f3051a6ca8d9cefa198f00b474a58f"
  license "GPL-3.0-or-later"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "glib" => :build
  depends_on "libadwaita"
  depends_on "libpanel"
  depends_on "gtksourceview5"
  depends_on "jsonrpc-glib"
  depends_on "libpeas"
  depends_on "template-glib"
  depends_on "vte"
  depends_on "cmark"
  depends_on "pcre2"
  depends_on "desktop-file-utils"

  # Plugins
  depends_on "llvm"
  depends_on "editorconfig"
  depends_on "libgit2-glib-dev"
  depends_on "enchant"

  def install
    args = std_meson_args + %w[
      -Dwebkit=disabled
      -Dplugin_dspy=false
      -Dplugin_flatpak=false
      -Dplugin_html_preview=false
      -Dplugin_markdown_preview=false
      -Dplugin_sphinx_preview=false
      -Dplugin_sysprof=false
    ]

    # stop meson_post_install.py from doing what needs to be done in the post_install step
    ENV["DESTDIR"] = ""
    mkdir "build" do
      system "meson", *args, ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  stable do
    patch :DATA
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas",
           "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
    system "#{Formula["gtk4"].opt_bin}/gtk4-update-icon-cache", "-q", "-t", "-f",
           "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test gnome-builder-43.alpha`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end