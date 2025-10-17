class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  homepage "https://github.com/cncf/landscape2"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cncf/landscape2/releases/download/v1.1.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "316964ef0fb6bce0a6a539326eea6bc75bd9078807896820a7f6969257c5bf8d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cncf/landscape2/releases/download/v1.1.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "c58fd4b015355db0896b66e1c6baa1d65f5b0b30b9e1fadab4d257ab4b760f92"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cncf/landscape2/releases/download/v1.1.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "526f1d88b12edfd4c68d2347d9f835f053137c454e3f6e8620a5fe3d490329e9"
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
