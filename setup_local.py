#!/usr/bin/env python
"""
Local Development Setup Script for Library Management System
This script helps set up the project for local development with SQLite
"""

import os
import sys
import subprocess
import django
from django.core.management import execute_from_command_line

def run_command(command, description):
    """Run a shell command and handle errors"""
    print(f"\n🔄 {description}...")
    try:
        result = subprocess.run(command, shell=True, check=True, capture_output=True, text=True)
        print(f"✅ {description} completed successfully")
        if result.stdout:
            print(result.stdout)
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Error during {description}")
        print(f"Error: {e.stderr}")
        return False

def setup_project():
    """Main setup function"""
    print("🚀 Starting Library Management System Local Setup")
    print("=" * 50)

    # Check if we're in the right directory
    if not os.path.exists('manage.py'):
        print("❌ Error: manage.py not found. Please run this script from the project root directory.")
        return False

    # Install local requirements
    print("\n📦 Installing dependencies...")
    if os.path.exists('requirements-local.txt'):
        if not run_command('pip install -r requirements-local.txt', 'Installing local requirements'):
            return False
    else:
        print("⚠️  requirements-local.txt not found, using original requirements.txt")
        if not run_command('pip install -r requirements.txt', 'Installing requirements'):
            return False

    # Setup Django
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dbms.settings')
    django.setup()

    # Create migrations
    if not run_command('python manage.py makemigrations', 'Creating migrations'):
        return False

    # Apply migrations
    if not run_command('python manage.py migrate', 'Applying migrations'):
        return False

    # Create superuser prompt
    print("\n👤 Creating superuser account...")
    print("You'll be prompted to create a superuser account for admin access.")
    try:
        execute_from_command_line(['manage.py', 'createsuperuser'])
    except KeyboardInterrupt:
        print("\n⚠️  Superuser creation skipped. You can create one later with: python manage.py createsuperuser")

    # Create user groups
    print("\n👥 Setting up user groups...")
    setup_groups_script = '''
from django.contrib.auth.models import Group

# Create groups if they don't exist
groups = ['admin', 'staff', 'student']
for group_name in groups:
    group, created = Group.objects.get_or_create(name=group_name)
    if created:
        print(f"Created group: {group_name}")
    else:
        print(f"Group already exists: {group_name}")
'''

    try:
        from django.core.management import execute_from_command_line
        execute_from_command_line(['manage.py', 'shell', '-c', setup_groups_script])
    except Exception as e:
        print(f"⚠️  Could not create groups automatically: {e}")
        print("You can create them manually in the Django admin or shell")

    # Populate database with sample data (optional)
    print("\n📊 Would you like to populate the database with sample data? (y/n): ", end="")
    response = input().lower().strip()
    if response in ['y', 'yes']:
        if not run_command('python manage.py populatedb --users=50', 'Populating database with sample data'):
            print("⚠️  Sample data creation failed, but you can continue without it")

    # Final instructions
    print("\n" + "=" * 50)
    print("🎉 Setup completed successfully!")
    print("\n📝 Next steps:")
    print("1. Start the development server: python manage.py runserver")
    print("2. Open your browser and go to: http://127.0.0.1:8000")
    print("3. Access admin panel at: http://127.0.0.1:8000/admin")
    print("4. Register new users at: http://127.0.0.1:8000/accounts/register")
    print("\n🔧 Available user roles:")
    print("- Admin: Full system access")
    print("- Staff: Can manage books and issue them")
    print("- Student: Can request book issues")
    print("\n📧 Email notifications will be displayed in the console during development")

    return True

if __name__ == '__main__':
    if setup_project():
        sys.exit(0)
    else:
        print("\n❌ Setup failed. Please check the errors above and try again.")
        sys.exit(1)
