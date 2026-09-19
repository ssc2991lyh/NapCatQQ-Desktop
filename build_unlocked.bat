@echo off
chcp 65001 >nul
REM ============================================================
REM  NapCatQQ-Desktop 破除4bot限制后 —— 本机一键编译脚本
REM  前置依赖(只需装一次):
REM    1) Rust 工具链: https://rustup.rs  (装完重启终端)
REM    2) Visual Studio 2022 生成工具: 勾选 "使用 C++ 的桌面开发" + Windows 11 SDK
REM    3) pnpm:        npm i -g pnpm
REM  用法: 在仓库根目录(本文件所在目录)双击运行
REM ============================================================
where cargo >nul 2>nul || (echo [错误] 未检测到 cargo，请先装 Rust: https://rustup.rs && pause && exit /b 1)
where pnpm  >nul 2>nul || (echo [错误] 未检测到 pnpm，请先执行: npm i -g pnpm && pause && exit /b 1)

echo [1/3] 安装前端依赖 (pnpm install)...
call pnpm install
if errorlevel 1 (echo [失败] pnpm install 出错 && pause && exit /b 1)

echo [2/3] 编译 Tauri 应用 (release, 约10-30分钟, 老机器可能较慢)...
call pnpm run tauri build
if errorlevel 1 (echo [失败] 编译出错，请确认 Rust / VS2022 生成工具 / Windows SDK 已装齐 && pause && exit /b 1)

echo [3/3] 编译完成！产物位于:
echo   src-tauri\target\release\bundle\msi\*.msi
echo   src-tauri\target\release\bundle\nsis\*.exe
echo 用这个 MSI 覆盖安装即可(配置在 %%ProgramData%%\NapCatQQ Desktop, 不会丢)。
pause
