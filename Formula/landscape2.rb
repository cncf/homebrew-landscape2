class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  version "0.8.0"
  on_macos do
    on_arm do
      url "https://github.com/cncf/landscape2/releases/download/v0.8.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "36fc087cb5bdddb200c748ba3315b001b8c198ca82d26bf0e3492fdc8b41feac"
    end
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.8.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "8cb502ba96059693a9386c5c099cce296209a0506b68bd302637481247d25bc6"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.8.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3cfb0f463c4da0877e6bb9b5f8ef7fb7f03154cb27abfdd217a99e80114e312c"
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
