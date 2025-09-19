# Library Management System - Quick Start Guide

This guide will get you up and running with the Library Management System locally in just a few minutes.

## Prerequisites
- Python 3.6+ installed on your system
- Basic command line knowledge

## Step-by-Step Setup

### 1. Open Terminal/Command Prompt
Navigate to the project directory:
```bash
cd library-management-system-master
```

### 2. Create Virtual Environment
```bash
# Create virtual environment
python3 -m venv venv

# Or on Windows:
python -m venv venv
```

### 3. Activate Virtual Environment
```bash
# On Linux/macOS:
source venv/bin/activate

# On Windows:
venv\Scripts\activate
```

### 4. Install Dependencies
```bash
pip install -r requirements-local.txt
```

### 5. Set Up Database
```bash
# Create database tables
python manage.py makemigrations
python manage.py migrate

# Create user groups
python manage.py setup_groups
```

### 6. Create Admin User
```bash
python manage.py createsuperuser
```
Follow the prompts to create your admin account.

### 7. (Optional) Add Sample Data
```bash
python manage.py populatedb --users=20
```

### 8. Start the Server
```bash
python manage.py runserver
```

### 9. Open Your Browser
Visit: http://127.0.0.1:8000

## What's Next?

### Login as Admin
1. Go to http://127.0.0.1:8000/admin
2. Use the superuser credentials you created
3. You can manage all system data here

### Create Regular Users
1. Login as admin user at http://127.0.0.1:8000
2. Go to http://127.0.0.1:8000/adminpage
3. Create student and staff accounts

### Test the System
1. **As Staff**: Add books at http://127.0.0.1:8000/staff-addbook
2. **As Student**: Browse and request books
3. **As Staff**: Issue books to students at http://127.0.0.1:8000/staff-issue

## Key URLs
- **Home**: http://127.0.0.1:8000
- **Admin Panel**: http://127.0.0.1:8000/admin
- **User Registration**: http://127.0.0.1:8000/accounts/register
- **Login**: http://127.0.0.1:8000/accounts/login
- **Create Users** (Admin): http://127.0.0.1:8000/adminpage
- **Staff Dashboard**: http://127.0.0.1:8000/staff-issue
- **Student Dashboard**: http://127.0.0.1:8000/student-dashboard

## User Types
- **Admin**: Create users, full system access
- **Staff/Librarian**: Manage books, issue to students
- **Student**: Browse books, request issues

## Troubleshooting

### "ModuleNotFoundError: No module named 'django'"
- Make sure virtual environment is activated
- Install requirements: `pip install -r requirements-local.txt`

### "You don't have specific permission to access this page"
- Make sure your user is in the correct group (admin/staff/student)
- Use Django admin to assign groups

### Database Issues
- Delete `db.sqlite3` and run migrations again
- Run: `python manage.py migrate --run-syncdb`

## Quick Commands Reference
```bash
# Activate virtual environment
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows

# Start server
python manage.py runserver

# Create superuser
python manage.py createsuperuser

# Add sample data
python manage.py populatedb --users=50

# Reset database
rm db.sqlite3
python manage.py migrate
python manage.py setup_groups
```

## Notes
- Email notifications appear in console during development
- Database file: `db.sqlite3` (SQLite)
- Sample data includes fake books, authors, and users for testing
- All changes are saved locally in SQLite database

Happy coding! 🎉