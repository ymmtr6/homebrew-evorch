class Evorch < Formula
  desc "Event-driven orchestration CLI: Schedule → Judge → Act"
  homepage "https://github.com/ymmtr6/Evorch"
  url "https://github.com/ymmtr6/Evorch/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "f4646ab53abf6b7d39dbc4188c046bc8fa0d7ca19ea6e1afe252803c590e7ee6"
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
