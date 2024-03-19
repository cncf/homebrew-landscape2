class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  version "0.7.0"
  on_macos do
    on_arm do
      url "https://github.com/cncf/landscape2/releases/download/v0.7.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "1336cc6fb4213f631cbec863b43f0b1b33ed95eafa8d6373624164c531a49713"
    end
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.7.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "fb14bf838efed605c5d0c027e32df422dba6877bf9a1481363e371d1fd763393"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.7.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "733470856f1488ca512a41d9a1bb0cea7062284d4ed545ac75018fd7c6b4e769"
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
