class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  homepage "https://github.com/cncf/landscape2"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cncf/landscape2/releases/download/v0.9.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "5700fa078abe551812970f2cb0a4a010cc4513562aa937a5c422e521e2764be0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cncf/landscape2/releases/download/v0.9.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "3382158737dfe069fc3d6bd0069c2b6cd1a19ba4c2a83064d822f0f2b1826db4"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/cncf/landscape2/releases/download/v0.9.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b77e3b2eed3d9e732d8033fb757d585357799c9c04c0bd434d3d1a1e2a71bff9"
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
