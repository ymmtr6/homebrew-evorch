class Evorch < Formula
  desc "Event-driven orchestration CLI: Schedule → Judge → Act"
  homepage "https://github.com/ymmtr6/Evorch"
  url "https://github.com/ymmtr6/Evorch/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "6942ca3b4a9f7467573982549e1060ae7d571cd897fb3368819f8504c43c87ce"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: false)
    system "npm", "run", "build"

    libexec.install "dist", "node_modules", "package.json"

    (bin/"evorch").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/index.js" "$@"
    SH
  end

  test do
    assert_match "evorch", shell_output("#{bin}/evorch --help")
  end
end
