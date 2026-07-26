# 本文件由 tools/brewgen 依据 Release 的 checksums.txt 生成，请勿手改。
# 更新方式：发布流水线（.github/workflows/release.yml）打 tag 时重新生成并附到 Release。
class Inhomo < Formula
  desc "Audit plaintext HTTP leaks through mihomo egress proxy nodes"
  homepage "https://github.com/xunull/inhomo"
  version "0.1.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.4/inhomo_v0.1.4_darwin_arm64.tar.gz"
      sha256 "1e88c06dcf7df1c3facce8350a4543c1f48872749cd4ca0656e95b922f98ef76"
    end
    on_intel do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.4/inhomo_v0.1.4_darwin_amd64.tar.gz"
      sha256 "808d110b61af8a3e91ee285e223e721b688b5b2c1764cb94c3e0a6dde74866c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.4/inhomo_v0.1.4_linux_arm64.tar.gz"
      sha256 "4cd5988e4a4c5a7ce379ed23899d98d76dc20dbb00229f967e136dce5c5f1dd2"
    end
    on_intel do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.4/inhomo_v0.1.4_linux_amd64.tar.gz"
      sha256 "9135bde90ed36e4d220f8aceae1b89701aebfb83955d04fb64ac104da948a877"
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
