#!/bin/bash

# Library Management System - Local Setup Script
# This script sets up the project for local development with SQLite

echo "🚀 Library Management System - Local Setup"
echo "=========================================="

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3 first."
    exit 1
fi

echo "✅ Python 3 found: $(python3 --version)"

# Create virtual environment
echo ""
echo "🔧 Creating virtual environment..."
python3 -m venv venv

if [ $? -ne 0 ]; then
    echo "❌ Failed to create virtual environment"
    exit 1
fi

echo "✅ Virtual environment created"

# Activate virtual environment
echo ""
echo "🔄 Activating virtual environment..."
source venv/bin/activate

if [ $? -ne 0 ]; then
    echo "❌ Failed to activate virtual environment"
    exit 1
fi

echo "✅ Virtual environment activated"

# Install requirements
echo ""
echo "📦 Installing requirements..."
pip install -r requirements-local.txt

if [ $? -ne 0 ]; then
    echo "❌ Failed to install requirements"
    exit 1
fi

echo "✅ Requirements installed successfully"

# Make migrations
echo ""
echo "🗄️  Creating database migrations..."
python manage.py makemigrations

if [ $? -ne 0 ]; then
    echo "❌ Failed to create migrations"
    exit 1
fi

# Apply migrations
echo ""
echo "🗄️  Applying migrations..."
python manage.py migrate

if [ $? -ne 0 ]; then
    echo "❌ Failed to apply migrations"
    exit 1
fi

echo "✅ Database migrations completed"

# Setup groups
echo ""
echo "👥 Setting up user groups..."
python manage.py setup_groups

# Create superuser
echo ""
echo "👤 Creating superuser..."
echo "Please create a superuser account for admin access:"
python manage.py createsuperuser

# Ask about sample data
echo ""
echo "📊 Would you like to populate the database with sample data? (y/n)"
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "🔄 Adding sample data..."
    python manage.py populatedb --users=50
    echo "✅ Sample data added"
else
    echo "⏭️  Skipping sample data"
fi

# Final instructions
echo ""
echo "🎉 Setup completed successfully!"
echo ""
echo "📝 To start the development server:"
echo "1. Activate virtual environment: source venv/bin/activate"
echo "2. Start server: python manage.py runserver"
echo "3. Open browser: http://127.0.0.1:8000"
echo ""
echo "🔧 Important URLs:"
echo "- Home: http://127.0.0.1:8000"
echo "- Admin: http://127.0.0.1:8000/admin"
echo "- Register: http://127.0.0.1:8000/accounts/register"
echo "- Login: http://127.0.0.1:8000/accounts/login"
echo ""
echo "👥 User Roles:"
echo "- Admin: Full access, can create users"
echo "- Staff: Manage books, issue to students"
echo "- Student: Browse and request books"
echo ""
echo "📧 Email notifications will appear in console during development"
echo ""
echo "Happy coding! 🚀"
