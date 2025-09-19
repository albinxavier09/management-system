@echo off
REM Library Management System - Local Setup Script for Windows
REM This script sets up the project for local development with SQLite

echo 🚀 Library Management System - Local Setup
echo ==========================================

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python is not installed or not in PATH. Please install Python first.
    pause
    exit /b 1
)

echo ✅ Python found
python --version

REM Create virtual environment
echo.
echo 🔧 Creating virtual environment...
python -m venv venv

if errorlevel 1 (
    echo ❌ Failed to create virtual environment
    pause
    exit /b 1
)

echo ✅ Virtual environment created

REM Activate virtual environment
echo.
echo 🔄 Activating virtual environment...
call venv\Scripts\activate.bat

if errorlevel 1 (
    echo ❌ Failed to activate virtual environment
    pause
    exit /b 1
)

echo ✅ Virtual environment activated

REM Install requirements
echo.
echo 📦 Installing requirements...
pip install -r requirements-local.txt

if errorlevel 1 (
    echo ❌ Failed to install requirements
    pause
    exit /b 1
)

echo ✅ Requirements installed successfully

REM Make migrations
echo.
echo 🗄️  Creating database migrations...
python manage.py makemigrations

if errorlevel 1 (
    echo ❌ Failed to create migrations
    pause
    exit /b 1
)

REM Apply migrations
echo.
echo 🗄️  Applying migrations...
python manage.py migrate

if errorlevel 1 (
    echo ❌ Failed to apply migrations
    pause
    exit /b 1
)

echo ✅ Database migrations completed

REM Setup groups
echo.
echo 👥 Setting up user groups...
python manage.py setup_groups

REM Create superuser
echo.
echo 👤 Creating superuser...
echo Please create a superuser account for admin access:
python manage.py createsuperuser

REM Ask about sample data
echo.
set /p response="📊 Would you like to populate the database with sample data? (y/n): "

if /i "%response%"=="y" (
    echo 🔄 Adding sample data...
    python manage.py populatedb --users=50
    echo ✅ Sample data added
) else if /i "%response%"=="yes" (
    echo 🔄 Adding sample data...
    python manage.py populatedb --users=50
    echo ✅ Sample data added
) else (
    echo ⏭️  Skipping sample data
)

REM Final instructions
echo.
echo 🎉 Setup completed successfully!
echo.
echo 📝 To start the development server:
echo 1. Activate virtual environment: venv\Scripts\activate
echo 2. Start server: python manage.py runserver
echo 3. Open browser: http://127.0.0.1:8000
echo.
echo 🔧 Important URLs:
echo - Home: http://127.0.0.1:8000
echo - Admin: http://127.0.0.1:8000/admin
echo - Register: http://127.0.0.1:8000/accounts/register
echo - Login: http://127.0.0.1:8000/accounts/login
echo.
echo 👥 User Roles:
echo - Admin: Full access, can create users
echo - Staff: Manage books, issue to students
echo - Student: Browse and request books
echo.
echo 📧 Email notifications will appear in console during development
echo.
echo Happy coding! 🚀
echo.
pause
