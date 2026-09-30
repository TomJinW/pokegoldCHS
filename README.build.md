# 如何编译汉化

## 步骤零：环境准备（概览）

这里记载了编译汉化版 ROM 需要的依赖环境，有经验的用户可以自行安装相关依赖。

### Windows (x86_64, arm64)：
- 需要一个 Linux 环境。Windows 10 或以上推荐使用 [WSL](https://learn.microsoft.com/zh-cn/windows/wsl/install)（Windows Subsystem for Linux）。使用 WSL 的情况下，步骤和 Linux 环境下相同。
- 纯 Windows 环境下亦可以使用 [SnDream/rgbds-ws](https://github.com/SnDream/rgbds-ws) ，将完整的本仓库克隆到该环境中的 home 目录，再配合本仓库内的 _prepare-win32.sh 进行编译。该环境具体使用方法请参考 [SnDream/rgbds-ws](https://github.com/SnDream/rgbds-ws) 提供的使用教程。arm64 版 Windows 在该环境下为 x86_64 转译运行。

### macOS (arm64, x86_64) 和 Linux (x86_64, arm64)：
- git
- RGBDS 1.0.4（使用 `rgbasm --version` 核对）。
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
	
- 安装 [RGBDS 1.0.4](https://github.com/gbdev/rgbds/releases/tag/v1.0.4)。按[官方安装说明](https://rgbds.gbdev.io/install)选择适合架构的预编译包，或从源码编译。安装后用 `rgbasm --version` 确认版本为 1.0.4。

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
	
- 安装 [RGBDS 1.0.4](https://github.com/gbdev/rgbds/releases/tag/v1.0.4)。按[官方安装说明](https://rgbds.gbdev.io/install)选择 macOS 预编译包或从源码编译；Apple Silicon 请选 arm64 版本。安装后用 `rgbasm --version` 确认版本为 1.0.4。

## 步骤二：编译ROM

### macOS 和 Linux 首次编译：

- 克隆代码仓库（将本仓库和与水晶版汉化共享的 excel 仓库一并克隆）：

	```
	git clone https://github.com/TomJinW/pokegoldCHS --recursive && cd pokegoldCHS
	```
	

- 添加运行权限并运行：

	```
	chmod +x _prepare.command && ./_prepare.command
	```

- 脚本会创建一个 build 文件夹，会自动把代码复制到 build 文件夹，脚本还会自动把汉化更改应用到 build 文件夹中，并在 build 文件夹中进行编译。

- 最后看到「done!」说明一切完成。

### 首次编译完成之后：

- 可以直接在 build 文件夹里修改需要的部分并运行 make 来重新编译游戏，汉化版的修改已经应用于 build 文件夹，所以可以不需要再运行 _prepare.command：

	```
	cd build
	make
	```

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
	
	
	
