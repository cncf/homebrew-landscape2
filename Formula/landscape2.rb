class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  homepage "https://github.com/cncf/landscape2"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cncf/landscape2/releases/download/v0.13.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "df3821ce0b319103d5ec63b3f8d12e7030aa520a1ee8d4d1b99fbdac71a4282a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cncf/landscape2/releases/download/v0.13.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "410445da09d6500aa48777d3ddba1de1ff48dcf8094c2f1904aa0f35693ec736"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cncf/landscape2/releases/download/v0.13.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ff02fd24a1644b96a361bf2e90ecf8264fc2a5af90483686284ea3a9d73bc00a"
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
