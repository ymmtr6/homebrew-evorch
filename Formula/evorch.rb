class Evorch < Formula
  desc "Event-driven orchestration CLI: Schedule → Judge → Act"
  homepage "https://github.com/ymmtr6/Evorch"
  url "https://github.com/ymmtr6/Evorch/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "006c67afc6ea24758fcb38f6b9a3d01694dd2e5d6440796eb6ffe42b42c2bbf0"
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
