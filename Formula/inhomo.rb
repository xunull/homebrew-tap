# 本文件由 tools/brewgen 依据 Release 的 checksums.txt 生成，请勿手改。
# 更新方式：发布流水线（.github/workflows/release.yml）打 tag 时重新生成并附到 Release。
class Inhomo < Formula
  desc "Audit plaintext HTTP leaks through mihomo egress proxy nodes"
  homepage "https://github.com/xunull/inhomo"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.0/inhomo_v0.1.0_darwin_arm64.tar.gz"
      sha256 "568d8cf2abecc1129d1124fa2eaf2208ccee95e19e9f82204f4036394103f05d"
    end
    on_intel do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.0/inhomo_v0.1.0_darwin_amd64.tar.gz"
      sha256 "aa5f53ac0c20e5836c4cfb769b26e2e065909ed4c890cf1a524c4f0553cb0ac8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.0/inhomo_v0.1.0_linux_arm64.tar.gz"
      sha256 "6fc042ec8e0b3d144d919004bc7d19b40b737b7fd6c7d6b7a167906e31c108ae"
    end
    on_intel do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.0/inhomo_v0.1.0_linux_amd64.tar.gz"
      sha256 "05cc5d3f22f12c76b6220f4c3c79f138963e15a44465e60cb6bbc70a9224846b"
    end
  end

  # Homebrew 用自带 curl 下载，不打 com.apple.quarantine 隔离标记（那是浏览器下载才加的），
  # 故未签名二进制经 brew 安装后可直接运行，无需手动清 xattr。v0 不做 Apple 公证。
  def install
    bin.install "inhomo"
  end

  # brew services start inhomo → 后台常驻 inhomo serve。单个 service 块由 Homebrew
  # 同时映射到 mac launchd / linux systemd（一块两覆）。服务读 ~/.inhomo/config.yaml 拿
  # controller/secret 等，无需编辑 plist；请勿加 sudo（否则 $HOME 变 root，找不到你的配置）。
  service do
    run [opt_bin/"inhomo", "serve"]
    keep_alive true
    log_path var/"log/inhomo.log"
    error_log_path var/"log/inhomo.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/inhomo version")
  end
end
