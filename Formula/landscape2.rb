class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  homepage "https://github.com/cncf/landscape2"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cncf/landscape2/releases/download/v0.12.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "9b899994845308e762069faf9d392dec388e5453f8b97ec929ac30068c3aead1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cncf/landscape2/releases/download/v0.12.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "f1b0d7737f9cf7b046a79113d7e9f7dcb68fc8367bca41731cd8258378a4511f"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/cncf/landscape2/releases/download/v0.12.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "cb3516e3e733623d9a8d5a7accd70a716a15faddf4e0af39cdc7c7305fa91894"
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
