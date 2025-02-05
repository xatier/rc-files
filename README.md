# my rcfiles

## Usage

Clone the repo and put the config files to proper locations.

```bash
git clone git@github.com:xatier/rc-files.git
cp rc-files/xxx ~/.xxx
```

## License(s)

All codes are under their own license(s) from the original projects.

Other codes written by myself are under
[GPL](https://www.gnu.org/copyleft/gpl.html).

## Config files

### `bashrc`, `bash_profile`, and `inputrc`

My settings and aliases for bash and readline.

### bin

My collections of little programs

#### vpngate and v.sh

- VPN scripts

- requirements

```bash
pacman -S perl perl-libwww openvpn shadowsocks chromium openconnect
```

#### srandr

Simple `xrandr`

A dirty script to manage my notebook's screen output using xrandr.

Original script is from [@PkmX](https://github.com/PkmX)

Usage: `srandr [lvds|vga|lvds-vga|vga-lvds|mirror|debug]`

- or like this => `srandr[l|v|lv|vl|m]`

### conky.conf

Conky configuration (`~/.config/conky/conky.conf`).

### emacs & prelude-modules.el

Emacs stuff, probably outdated, didn't use `emacs` for a while.

### gdbinit

[GDB](https://www.gnu.org/software/gdb/) debugger settings

### gitconfig, gitattributes, and gitmessage

Global [git](https://git-scm.com/) config

Global [git attributes](https://git-scm.com/docs/gitattributes) config

Global [commit.template](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration)

### hammerspoon

[Hammerspoon](https://www.hammerspoon.org/) config `~/.hammerspoon/init.lua`.

Try to port some of my AwesomeWM config (`rc.lua`) stuff to macOS. Totally a
game changer for my Macs!

### mpv

[MPV Media player](https://github.com/mpv-player/mpv)
(`~/.config/mpv/mpv.conf`)

### python

`PYTHONSTARTUP` is set to `$HOME/.pythonrc.py` in `bashrc`.

`ipython profile create` to create default ipython config.

Put `ipython_config.py` under `~/.ipython/profile_default/`.

See [pip](pip/README.md) for user pip setup.

### ranger

[ranger file manager](https://github.com/ranger/ranger)

### rc.lua

Configuration file for the [awesome wm](https://awesomewm.org/)

- awesome 4.3

- disable some layouts

- use `vim` and `urxvt` as editor and terminal (with urxvt daemon)

- add some widgets

  - network usage
  - text clock
  - CPU usage
  - memory usage
  - and so on ...

- Installation

  - [vicious widgets](http://git.sysphere.org/vicious/log/)

    ```bash
    pacman -S vicious
    ```

  - pick up a great wallpaper

    ```lua
    beautiful.wallpaper = "/home/xatierlike/Pictures/something.jpg"
    ```

  - [urxvt terminal emulator](http://software.schmorp.de/pkg/rxvt-unicode.html)

    ```bash
    pacman -S rxvt-unicode urxvt-perl
    ```

    - add `urxvtd -q -o -f` to `.xinitrc`

  - check battery name in
  `vicious.register(batwidget, vicious.widgets.bat, '$2% $3[$1]', 2, 'BAT1')`

    To get the battery name (`BAT0` or `BAT1` for example)

    ```bash
    ls /sys/class/power_supply/
    ```

  - [shutter-project](http://shutter-project.org/)

    ```bash
    pacman -S shutter
    ```

### ripgrep

[ripgrep](https://github.com/BurntSushi/ripgrep) configurations (`~/.config/ripgrep/rc`)

Ref: [GUIDE.md](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file)

### screenrc

Screen settings, didn't use screen for a long long while.

### tmux.conf

- use `Ctrl-b` for prefix key
- vi-like key bindings
- use `Shift + <-/->` to switch windows

### Vimium

[Vimium](https://github.com/philc/vimium) The hacker's browser.

#### Custom key mappings

`defaultKeyMappings` can be found
[here](https://github.com/philc/vimium/blob/master/background_scripts/commands.js#L284).

```text
map b Vomnibar.activateInNewTab
map o Vomnibar.activateInNewTab
map t Vomnibar.activateTabSelection
```

#### Custom search engines

Use the
[script](https://gist.github.com/philc/e849b48e6c5f32592d62?permalink_comment_id=4096511#gistcomment-4096511)
to import search engine from `Edge`.

```text
anime: https://ani.gamer.com.tw/search.php?kw=%s  ani.gamer.com.tw
aur: https://aur.archlinux.org/packages/?O=0&K=%s  aur.archlinux.org
ccc: https://camelcamelcamel.com/search?sq=%s  camelcamelcamel.com
code: https://cs.github.com?q=%s  GitHub
ddg: https://duckduckgo.com/?q=%s&kg=p&kp=-2&kl=tw-tzh&k1=-1&kz=1&kc=1&kav=1&kn=1&kh=1&kg=p  DuckDuckGo
dmhy: http://share.dmhy.org/topics/list?keyword=%s  动漫花园
doc: https://devdocs.io/#q=%s  DevDocs
docs: https://devdocs.io/#q=%s  DevDocs
e: https://www.ecosia.org/search?q=%s&addon=opensearch  Ecosia
emoji: https://emojipedia.org/search/?q=%s&utm_source=opensearch  Emojipedia
g: https://www.google.com/search?hl=zh-TW&lr=lang_en%7Clang_zh-TW%7Clang_ja&q=%s  Google(en)
github: https://github.com/search?q=%s&ref=opensearch  GitHub
lex: https://www.lexico.com/search?utf8=%E2%9C%93&filter=noad&dictionary=en&s=t&query=%s  lexico.com
man: https://man.archlinux.org/search?q=%s&go=Go  man.archlinux.org
pacman: https://archlinux.org/packages/?q=%s  Arch
q: https://www.qwant.com/?r=US&sr=en&l=en_gb&h=0&s=0&a=1&b=1&vt=1&hc=0&smartNews=1&theme=0&i=1&q=%s  Qwant
tw: https://itaigi.tw/k/%s  itaigi.tw
twitter: https://twitter.com/search?q=%s  Twitter
w: https://<whoogle>/search?q=%s  Whoogle
wolf: https://www.wolframalpha.com/input/?i=%s  Wolfram|Alpha
youtube: https://www.youtube.com/results?search_query=%s&page=&utm_source=opensearch  YouTube
```

### vimrc

My vimrc, simple stuff

Suggest installing [fzf](https://github.com/junegunn/fzf) and [ale](https://github.com/dense-analysis/ale).

```bash
pacman -S fzf

mkdir -p ~/.vim/pack/git-plugins/start
git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale
```

### VS Code

- Recommend installing `visual-studio-code-bin` from AUR (Microsoft-branded release)
- settings locations

```bash
# Linux
~/.config/Code/User/settings.json

# Mac
~/Library/Application\ Support/Code\ -\ Insiders/User/settings.json

# Linux remote
~/.vscode-server-insiders/data/Machine/settings.json
```

- list installed extensions

```bash
$ code --list-extensions --show-versions
asvetliakov.vscode-neovim@1.18.15
bierner.emojisense@0.10.0
bierner.github-markdown-preview@0.3.0
bierner.markdown-checkbox@0.4.0
bierner.markdown-emoji@0.3.1
bierner.markdown-footnotes@0.1.1
bierner.markdown-mermaid@1.27.0
bierner.markdown-preview-github-styles@2.1.0
bierner.markdown-shiki@0.1.1
davidanson.vscode-markdownlint@0.58.2
davidlday.languagetool-linter@0.25.1
docsmsft.docs-yaml@1.0.5
eamodio.gitlens@16.2.1
editorconfig.editorconfig@0.16.4
esbenp.prettier-vscode@11.0.0
github.copilot@1.264.0
github.copilot-chat@0.23.2
github.github-vscode-theme@6.3.5
github.remotehub@0.65.2024112101
github.vscode-pull-request-github@0.103.2024121117
golang.go@0.44.0
hbenl.vscode-test-explorer@2.22.1
ms-azuretools.vscode-docker@1.29.4
ms-python.black-formatter@2024.5.13171011
ms-python.debugpy@2024.15.2025012801
ms-python.flake8@2023.13.13171014
ms-python.isort@2023.13.13171013
ms-python.mypy-type-checker@2024.1.13171012
ms-python.python@2024.23.2025012801
ms-python.vscode-pylance@2025.1.102
ms-vscode-remote.remote-containers@0.394.0
ms-vscode-remote.remote-ssh@0.117.2025013120
ms-vscode-remote.remote-ssh-edit@0.87.0
ms-vscode-remote.vscode-remote-extensionpack@0.26.0
ms-vscode.cmake-tools@1.20.47
ms-vscode.cpptools@1.23.5
ms-vscode.cpptools-themes@2.0.0
ms-vscode.makefile-tools@0.11.13
ms-vscode.remote-explorer@0.5.2025010909
ms-vscode.remote-repositories@0.43.2024112101
ms-vscode.remote-server@1.5.2
ms-vscode.test-adapter-converter@0.2.1
ms-vscode.vscode-typescript-next@5.8.20250204
ms-vsliveshare.vsliveshare@1.0.5948
octref.vetur@0.37.3
redhat.fabric8-analytics@0.9.5
redhat.vscode-commons@0.0.6
redhat.vscode-xml@0.27.2
redhat.vscode-yaml@1.15.0
rvest.vs-code-prettier-eslint@6.0.0
streetsidesoftware.code-spell-checker@4.0.34
sumneko.lua@3.13.5
timonwong.shellcheck@0.37.6
tomoki1207.pdf@1.2.2
twxs.cmake@0.0.17
visualstudioexptteam.vscodeintellicode@1.3.2
vscode-icons-team.vscode-icons@12.11.0
vscodevim.vim@1.29.0
```

- install extensions

```bash
code --install-extension <extension ID>
```

### xinitrc

- [HIME for input method](http://hime.luna.com.tw/)

- xmodmap to swap Capslock and Ctrl

- launch some applications

- launch the awesome wm and keep logs

### xmodmap

Swap `CapsLock` and `Control\_L`

Usage:  `xmodmap ~/.xmodmap`

- or run `bin/swapcaps`

### Xresources

[rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html) configurations

### yamllint

[yamllint](https://github.com/adrienverge/yamllint) configurations (`~/.config/yamllint/config`)
