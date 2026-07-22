# homebrew-tap

[inhomo](https://github.com/xunull/inhomo) 的 Homebrew tap —— 审计经由 mihomo 出站的明文 HTTP 泄露。

## 安装

```bash
brew tap xunull/tap
brew trust xunull/tap      # Homebrew 6.x 起：信任第三方 tap，不加这步 install 会被拒
brew install inhomo
```

> `brew trust` 是必需的一步：Homebrew 6.x 对第三方 tap 加了信任门，未 `brew trust` 就 `brew install` 会报 `Refusing to load formula ... from untrusted tap`。`brew trust xunull/tap` 后即可正常安装（也可 `brew trust --formula xunull/tap/inhomo` 只信任单个 formula）。

## 后台常驻

```bash
brew services start inhomo   # 后台跑 serve，读 ~/.inhomo/config.yaml
```

用法详见 [inhomo 主仓库 README](https://github.com/xunull/inhomo)。

> formula 由主仓库发布流水线在打 tag 时用 `tools/brewgen` 生成（指向 GitHub Release 的预编译二进制，sha256 取自 `checksums.txt`）。
