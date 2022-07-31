# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class GnomeBuilderNightly < Formula
  desc "An IDE for writing GNOME-based software."
  homepage "https://gitlab.gnome.org/GNOME/gnome-builder"
  head "https://gitlab.gnome.org/GNOME/gnome-builder.git", branch: "main"
  version "43"
  license "GPL-3.0-or-later"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "glib-utils" => :build
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
  depends_on "libgit2-glib"
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

    mkdir "build" do
      system "meson", *args, ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  head do
    patch :DATA
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test gnome-builder`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
__END__
diff --git a/src/libide/terminal/ide-terminal.c b/src/libide/terminal/ide-terminal.c
index 86a787638..c2b618b31 100644
--- a/src/libide/terminal/ide-terminal.c
+++ b/src/libide/terminal/ide-terminal.c
@@ -511,7 +511,7 @@ copy_clipboard_action (GtkWidget  *widget,
                        GVariant   *param)
 {
   GdkClipboard *clipboard = gtk_widget_get_clipboard (widget);
-  g_autofree char *text = vte_terminal_get_text_selected (VTE_TERMINAL (widget), VTE_FORMAT_TEXT);
+  g_autofree char *text = vte_terminal_get_text_selected (VTE_TERMINAL (widget));
   gdk_clipboard_set_text (clipboard, text);
 }
 
