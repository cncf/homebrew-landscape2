class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  version "0.6.1"
  on_macos do
    on_arm do
      url "https://github.com/cncf/landscape2/releases/download/v0.6.1/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "c29a4bc63865c6aec21d37bf139bbc87f68228c0a479f96bc97eb3a0190a852a"
    end
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.6.1/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "9743280126a73f88c1fb9de3fffe177f7f5abe8f6d45e17f8930ac1b6b631bb4"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.6.1/landscape2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "66470d7b337764c084ce63ba16bc92f1997c11adcb350c668fa313825222bdce"
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
