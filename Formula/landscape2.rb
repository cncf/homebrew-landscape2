class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  version "0.6.0"
  on_macos do
    on_arm do
      url "https://github.com/cncf/landscape2/releases/download/v0.6.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "eb563313dfa89d82704a3f0c195402b19da310848c436a4ce033fbfdec1837da"
    end
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.6.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "c825bfdf98853fc5681a079da7e97a205def08581a4a8351c688ba915cc39c85"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.6.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5f4cae9d8ca9d507c02b0bbb871131ec54d3efc424115693197d98aeeb99217d"
    end
  end
  license "Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "landscape2"
      end
    end
    on_macos do
      on_intel do
        bin.install "landscape2"
      end
    end
    on_linux do
      on_intel do
        bin.install "landscape2"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
