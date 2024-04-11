class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  version "0.8.1"
  on_macos do
    on_arm do
      url "https://github.com/cncf/landscape2/releases/download/v0.8.1/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "d4735998ef7be858645b826eb715680e6e82b5822cc8e88000e8d585a7e48c29"
    end
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.8.1/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "a8b8a880c233a5c9ef3049937409a17682374207e803fbce901c1c35a68a26ae"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.8.1/landscape2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "749719a39d4bd9ab6a6782713c685b9264b42ee79726d8bda1b9783023e09344"
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
