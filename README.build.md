# 如何编译汉化

## 步骤零：环境准备（概览）

这里记载了编译汉化版 ROM 需要的依赖环境，有经验的用户可以自行安装相关依赖。

### Windows (x86_64, arm64)：
- 需要一个 Linux 环境。Windows 10 或以上推荐使用 [WSL](https://learn.microsoft.com/zh-cn/windows/wsl/install)（Windows Subsystem for Linux）。使用 WSL 的情况下，步骤和 Linux 环境下相同。
- 纯 Windows 环境下亦可以使用 [SnDream/rgbds-ws](https://github.com/SnDream/rgbds-ws) ，将完整的本仓库克隆到该环境中的 home 目录，再配合本仓库内的 _prepare-win32.sh 进行编译。该环境具体使用方法请参考 [SnDream/rgbds-ws](https://github.com/SnDream/rgbds-ws) 提供的使用教程。arm64 版 Windows 在该环境下为 x86_64 转译运行。

### macOS (arm64, x86_64) 和 Linux (x86_64, arm64)：
- git
- RGBDS 0.7.0 - 0.8.0。
	- 注意：RGBDS 0.9.0 rc 存在编译问题，当前无法正确编译 VC 补丁。
- gcc
- python3 和 pip3
- openpyxl


## 步骤一：安装环境
### Linux (以 Ubuntu 为例）：
- 更新源：

	```
	sudo apt update
	```
	
- 安装所需依赖：

	```
	sudo apt install git gcc python3-pip
	```
	
- 安装 openpyxl，用于读取汉化 Excel 文件。
	
	```
	sudo pip3 install openpyxl
	```
	
- rgbds 安装选项
	-  （仅限 x86_64）从 Github Release 上下载原版 RGBDS 0.8.0，文件名为：  [rgbds-0.8.0-linux-x86_64.tar.xz](https://github.com/gbdev/rgbds/releases/tag/v0.8.0)
	- arm64 Linux 需要自行从源代码编译 RGBDS 并安装。[前往这里](https://rgbds.gbdev.io/install/source)查看官方教程。

 	
 		```
		# 创建解压目录
		mkdir rgbds

		# 解压下载好的文件到 rgbds 目录
		tar -xvf rgbds-0.8.0-linux-x86_64.tar.xz -C rgbds

		# 切换到目录
		cd rgbds

		# 使用管理员密码安装 rgbds
		sudo ./install.sh
		```

		
### macOS：
- 安装 Xcode Command Line Tools，如果安装了 Xcode ，可以跳过这个步骤。
	
	```
	xcode-select --install
	```
	
- 安装 [Homebrew](https://brew.sh) 包管理器，以用来安装其他软件。
	
	```
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	```

	- 如果已经安装过 [Homebrew](https://brew.sh) 包管理器，更新源。
	
		```
		brew update
		```

- 如果系统低于 macOS Ventura，还需要安装 python3。此操作会自动安装 pip3。
	
	```
	brew install python@3
	```

- 安装 openpyxl，用于读取汉化 Excel 文件。
	
	```
	pip3 install openpyxl
	```
	
- rgbds 安装选项
	1. 通过 [Homebrew](https://brew.sh) 安装。目前 Homebrew 版 rgbds 暂未更新到 0.9.0，通过该方法安装的 rgbds 0.8.0 将原生支持 x86_64 或 arm64。如果将来 rgbds 0.9.0 正式版发布之后，此安装方法无法继续使用。

		```
		brew install rgbds
		```

	2.  从 Github Release 上下载原版 RGBDS 0.8.0，文件名为：  [rgbds-0.8.0-macos-x86_64.zip
](https://github.com/gbdev/rgbds/releases/tag/v0.8.0) 目前 rgbds 0.8.0 预编译包仅有 x86_64 版，Apple Silicon Mac （arm64）通过 Rosetta 2 转译运行。 rgbds 0.9.0 RC 提供了 Universal Binary，但是 rgbds 0.9.0 RC 当前无法正确编译 Virtual Console 补丁。

		- 如果需要原生 arm64 版 rgbds，你可以：

			1. [前往这里下载](https://tomjinw.github.io/download/rgbds-0.8.0-macos-arm64.zip) 本人编译的 arm64 Mac 版 rgbds，文件名为：rgbds-0.8.0-macos-arm64.zip。
			2. 使用源代码自行编译 rgbds，[前往这里](https://rgbds.gbdev.io/install/source)查看官方教程。
 	
	3. 下载好压缩包之后：

 		```
		# 双击 zip 文件自动解压，并切换到解压后目录：
		cd rgbds-0.8.0-macos-x86_64

		# 或者如果下载的是本人编译的 arm64 Mac 版 rgbds：
		cd rgbds-0.8.0-macos-arm64

		# 可恶的 macOS GateKeeper 会默认阻止来源不明的 App，需要删除 App 的 com.apple.quarantine 属性。
		xattr -d com.apple.quarantine rgbasm
		xattr -d com.apple.quarantine rgbgfx
		xattr -d com.apple.quarantine rgblink
		xattr -d com.apple.quarantine rgbfix

		# 使用管理员密码安装 rgbds
		sudo ./install.sh
		```


## 步骤二：编译ROM

### macOS 和 Linux

- 克隆代码仓库（将本仓库和与水晶版汉化共享的 excel 仓库一并克隆）：

	```
	git clone https://github.com/TomJinW/pokegoldCHS --recursive && cd pokegoldCHS
	```
	

- 添加运行权限并运行：

	```
	chmod +x _importBuild.sh _prepare.command && ./_prepare.command
	```

- 脚本会自动导入汉化文本并编译 ROM。

- 最后看到「Restore Backup?」提示是否将repo恢复到未加入汉化文本的状态，输入1或者2并按下回车键选择。如果直接按下回车会默认使用选项1。

## 查看编译 ROM

- 编译好的ROM的文件存档如图所示：

```
pokegoldCHS
│   README.md
│   ...    
│ 	pokegold.gbc 			（宝可梦·金，GBC 专用汉化版）
│ 	pokegold_64KB.gbc 		（宝可梦·金，GB 共通汉化版）
│ 	pokegold.patch			（宝可梦·金，VC 用补丁，GBC 专用汉化版）
│ 	pokegold_vc.gbc			（宝可梦·金，VC修正版，GBC 专用汉化版）
│ 	pokegold_debug.gbc		（宝可梦·金，Debug 版，GB 共通汉化版）
│ 	pokegold_debug_32KB.gbc	（宝可梦·金，Debug 版，GBC 专用汉化版）
│   ...   
│ 	pokesilver.gbc 				（宝可梦·银，GBC 专用汉化版）
│ 	pokesilver_64KB.gbc 		（宝可梦·银，GB 共通汉化版）
│ 	pokesilver.patch			（宝可梦·银，VC 用补丁，GBC 专用汉化版）
│ 	pokesilver_vc.gbc			（宝可梦·银，VC修正版，GBC 专用汉化版）
│ 	pokesilver_debug.gbc		（宝可梦·银，Debug 版，GB 共通汉化版）
│ 	pokesilver_debug_32KB.gbc	（宝可梦·银，Debug 版，GBC 专用汉化版）
└───────
```

	
- VC修正版 ROM 是生成 VC 补丁的副产物，无法在 3DS VC 中实现各种功能，**请务必不要在 3DS VC 中直接使用 VC 修正版 ROM，一定要使用原版 ROM (GBC 专用汉化版) + VC .patch 补丁。**
	
	
	

