class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  homepage "https://github.com/cncf/landscape2"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cncf/landscape2/releases/download/v0.10.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "cf734d73a9e9baba75c46584f0bc40ff3bd606cb420ac5eb20d6561dfd3e5e48"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cncf/landscape2/releases/download/v0.10.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "795e42b0b6b70298c89ec8e0506cd86efedb64568a0001386b43f3a23a6ee5ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/cncf/landscape2/releases/download/v0.10.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d4ff509031472c9f27f64b39ed2b65b627b918ced9b73caf474f1677718fb32c"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "landscape2"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "landscape2"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "landscape2"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
