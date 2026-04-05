class Evorch < Formula
  desc "Event-driven orchestration CLI: Schedule → Judge → Act"
  homepage "https://github.com/ymmtr6/Evorch"
  version "0.1.0"
  license "MIT"

  depends_on "node"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ymmtr6/Evorch/releases/download/v#{version}/evorch-#{version}-darwin-arm64.tar.gz"
      sha256 "PLACEHOLDER_ARM64_SHA256"
    else
      url "https://github.com/ymmtr6/Evorch/releases/download/v#{version}/evorch-#{version}-darwin-x86_64.tar.gz"
      sha256 "PLACEHOLDER_X86_64_SHA256"
    end
  end

  def install
    libexec.install Dir["*"]
    (bin/"evorch").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/index.js" "$@"
    EOS
    chmod 0755, bin/"evorch"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/evorch --version")
  end
end
