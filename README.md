# homebrew-tap

xunull 的 Homebrew tap。

## 先信任本 tap

```bash
brew tap xunull/tap
brew trust xunull/tap      # Homebrew 6.x 起：信任第三方 tap，不加这步 install 会被拒
```

> `brew trust` 是必需的一步：Homebrew 6.x 对第三方 tap 加了信任门，未 `brew trust` 就 `brew install` 会报 `Refusing to load formula ... from untrusted tap`。`brew trust xunull/tap` 后即可正常安装（也可 `brew trust --formula xunull/tap/inhomo` 只信任单个 formula）。

---

## inhomo

审计经由 mihomo 出站的明文 HTTP 泄露，并把每一条连接事件记进内嵌 DuckDB，用内置 React 面板分析。

```bash
brew install inhomo
```

后台常驻：

```bash
brew services start inhomo   # 后台跑 serve，读 ~/.inhomo/config.yaml
```

用法详见 [inhomo 主仓库 README](https://github.com/xunull/inhomo)。

> formula 由主仓库发布流水线在打 tag 时用 `tools/brewgen` 生成（指向 GitHub Release 的预编译二进制，sha256 取自 `checksums.txt`）。

---

## pcpm

找出那些启动它的作业已经消失、却还在跑的进程 —— 比如 AI 编程工具为了调试起的 dev server，工具退出后它一跑就是好几天。

```bash
brew install pcpm
```

```bash
pcpm forgotten     # 有什么被落下了
pcpm ports         # 我的哪些进程在监听 TCP 端口
```

macOS 与 Linux 均可安装。用法详见 [pcpm 主仓库 README](https://github.com/xunull/pcpm)。

> cask 由主仓库发布流水线在打 tag 时用 GoReleaser 生成。

---

## 为什么一个是 formula、一个是 cask

`inhomo` 在 `Formula/`，`pcpm` 在 `Casks/`，两者共存互不影响，安装命令都是 `brew install`。

差异来自各自的发布方式：inhomo 的 DuckDB 驱动带各平台预编译静态库，必须开 CGO 且无法交叉编译，只能用自研 `tools/brewgen` 配 4 个原生 runner 出 formula；pcpm 是纯 Go，交叉编译无碍，用 GoReleaser 发布，而 GoReleaser 2.17 已弃用 `brews`，官方方向是 `homebrew_casks`。

Homebrew 6.x 起，cask 里 `binary` 这类可移植 stanza 在 Linux 上同样可用，所以 pcpm 走 cask 并不影响 Linux 用户。
