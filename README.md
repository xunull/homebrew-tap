# homebrew-tap

[inhomo](https://github.com/xunull/inhomo) 的 Homebrew tap —— 审计经由 mihomo 出站的明文 HTTP 泄露。

## 安装

```bash
brew tap xunull/tap
brew install inhomo
```

## 后台常驻

```bash
brew services start inhomo   # 后台跑 serve，读 ~/.inhomo/config.yaml
```

用法详见 [inhomo 主仓库 README](https://github.com/xunull/inhomo)。

> formula 由主仓库发布流水线在打 tag 时用 `tools/brewgen` 生成（指向 GitHub Release 的预编译二进制，sha256 取自 `checksums.txt`）。
