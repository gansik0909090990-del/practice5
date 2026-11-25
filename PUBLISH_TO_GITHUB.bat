@echo off
setlocal
chcp 65001 >nul
title Publish practice5 to GitHub

echo ==========================================
echo       PRACTICE 5 - GITHUB PUBLISHER
echo ==========================================
echo.
echo Before continuing, create an EMPTY repository on:
echo https://github.com/new
echo Do not add README, .gitignore or a license there.
echo.
set /p REPO_URL=Paste the repository HTTPS URL here: 

if "%REPO_URL%"=="" (
    echo.
    echo ERROR: Repository URL is empty.
    pause
    exit /b 1
)

git --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ERROR: Git was not found. Install Git for Windows first:
    echo https://git-scm.com/download/win
    pause
    exit /b 1
)

git remote get-url origin >nul 2>&1
if errorlevel 1 (
    git remote add origin "%REPO_URL%"
) else (
    git remote set-url origin "%REPO_URL%"
)

if errorlevel 1 (
    echo.
    echo ERROR: Could not configure the GitHub remote.
    pause
    exit /b 1
)

echo.
echo Pushing main branch...
git push -u origin main
if errorlevel 1 (
    echo.
    echo Push failed. Check the repository URL and GitHub sign-in.
    pause
    exit /b 1
)

echo.
echo Pushing fix/tested-bug branch...
git push -u origin fix/tested-bug
if errorlevel 1 (
    echo.
    echo The main branch was pushed, but the fix branch push failed.
    pause
    exit /b 1
)

echo.
echo SUCCESS: Both branches were pushed to GitHub.
echo Open your GitHub repository in a browser and check the Commits tab.
pause
endlocal
