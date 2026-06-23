class Lterminal < Formula
  desc "Tile Terminal.app windows on the current macOS Space into an equal grid"
  homepage "https://github.com/lexbryan/homebrew-lterminal"
  # For a tagged release, fill in the checksum:
  #   curl -L https://github.com/lexbryan/homebrew-lterminal/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
  url "https://github.com/lexbryan/homebrew-lterminal/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_WITH_TARBALL_SHA256"
  license "MIT"

  # Install straight from main, no release required:
  #   brew install --HEAD lexbryan/lterminal/lterminal
  head "https://github.com/lexbryan/homebrew-lterminal.git", branch: "main"

  depends_on :macos

  def install
    # Keep bin/ + lib/ together so the dispatcher resolves ../lib/snap.jxa,
    # then expose only the executable on the PATH.
    libexec.install "bin", "lib"
    bin.install_symlink libexec/"bin/lterminal"
  end

  test do
    assert_match "lterminal", shell_output("#{bin}/lterminal --version")
  end
end
