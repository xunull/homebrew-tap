# 本文件由 tools/brewgen 依据 Release 的 checksums.txt 生成，请勿手改。
# 更新方式：发布流水线（.github/workflows/release.yml）打 tag 时重新生成并附到 Release。
class Inhomo < Formula
  desc "Audit plaintext HTTP leaks through mihomo egress proxy nodes"
  homepage "https://github.com/xunull/inhomo"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.3/inhomo_v0.1.3_darwin_arm64.tar.gz"
      sha256 "34bb71a4f234a21fbc596209baf65e199529c02829c547c7f16d62e628be35cd"
    end
    on_intel do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.3/inhomo_v0.1.3_darwin_amd64.tar.gz"
      sha256 "c910ef4b1c388480c434244c558106291e938b728e4730eae35448c418c98351"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.3/inhomo_v0.1.3_linux_arm64.tar.gz"
      sha256 "3674a40c99e3779b31d3ee3b9005c44eb9d2e10f5147915f1808e6a88d66cfb1"
    end
    on_intel do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.3/inhomo_v0.1.3_linux_amd64.tar.gz"
      sha256 "3c3843d58b1b3d988476b4b3bddceaad724c8631cf20b361725a7d63b90374ed"
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
