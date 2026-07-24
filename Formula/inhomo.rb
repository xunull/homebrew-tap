# 本文件由 tools/brewgen 依据 Release 的 checksums.txt 生成，请勿手改。
# 更新方式：发布流水线（.github/workflows/release.yml）打 tag 时重新生成并附到 Release。
class Inhomo < Formula
  desc "Audit plaintext HTTP leaks through mihomo egress proxy nodes"
  homepage "https://github.com/xunull/inhomo"
  version "0.1.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.2/inhomo_v0.1.2_darwin_arm64.tar.gz"
      sha256 "8c5aa2c5cafb9cf2a6bd9821f1f0eaa94b60f8b903454bda53dc3d74beb167d5"
    end
    on_intel do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.2/inhomo_v0.1.2_darwin_amd64.tar.gz"
      sha256 "5eeec2da72814f50f638c49efbe50545fd8ed3fcd318f16510058e5f094e79a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.2/inhomo_v0.1.2_linux_arm64.tar.gz"
      sha256 "27f2c926f2160055be6ec2710086625592186a58f73dde47faa514675a7c6244"
    end
    on_intel do
      url "https://github.com/xunull/inhomo/releases/download/v0.1.2/inhomo_v0.1.2_linux_amd64.tar.gz"
      sha256 "84b01c5b3244ad020e51ecea1640ef85cca75eb0d84a5aff77b82c086efb84f8"
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
