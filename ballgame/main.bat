
@echo off
cls
setlocal enabledelayedexpansion

:menu
echo ==========================
echo          Main Menu
echo ==========================
echo 1. Start Game
echo 2. Load Progress
echo 3. Exit
echo ==========================
set /p choice=Enter your choice: 

if "%choice%"=="1" (
    python main.py
    goto menu
)

if "%choice%"=="2" (
    set /p load_confirm=Would you like to load (y/n): 
    if /i "!load_confirm!"=="y" (
        set /p filepath=Enter the path to the progress file: 
        python game.py "!filepath!"
        goto menu
    ) else (
        goto menu
    )
)

if "%choice%"=="3" (
    cls
    exit
)

goto menu
