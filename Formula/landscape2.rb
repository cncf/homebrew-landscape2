class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  homepage "https://github.com/cncf/landscape2"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cncf/landscape2/releases/download/v0.11.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "d5a95276afe35c9a1a0ca495db5862b31be5645546658755c44e2d7503f0cc8e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cncf/landscape2/releases/download/v0.11.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "03e4d134895533e1721ab240ed6d34bf0921704590c7dd6b2c26d03d023ab720"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/cncf/landscape2/releases/download/v0.11.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8d7527e500b1af5defd56c285c229e25d488466e2cc023290800c2928d980e30"
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
