class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  homepage "https://github.com/cncf/landscape2"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cncf/landscape2/releases/download/v1.0.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "9a54422e5de8905292043174e9adc5f91d3d0f54484625ebf4b1b5de005b239b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cncf/landscape2/releases/download/v1.0.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "dcd4d6e34a223b37f2393e17852fc677bfea0fcff9ab33dc8b3300ab8c3a1a9c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cncf/landscape2/releases/download/v1.0.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a909695a56cbb550ab233248a59fae184cf5d77deb553684affdd48fdf1e7040"
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "landscape2" if OS.mac? && Hardware::CPU.arm?
    bin.install "landscape2" if OS.mac? && Hardware::CPU.intel?
    bin.install "landscape2" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
