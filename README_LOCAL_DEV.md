# Library Management System - Local Development Guide

This guide will help you set up and run the Library Management System locally using SQLite instead of PostgreSQL.

## Prerequisites

- Python 3.6 or higher
- pip (Python package installer)
- Git (optional, for cloning)

## Quick Start

### 1. Navigate to Project Directory
```bash
cd library-management-system-master
```

### 2. Create Virtual Environment (Recommended)
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate
```

### 3. Install Dependencies
```bash
# Install local development dependencies (without PostgreSQL)
pip install -r requirements-local.txt
```

### 4. Set Up Database and Initial Data
```bash
# Create database migrations
python manage.py makemigrations

# Apply migrations to create database tables
python manage.py migrate

# Set up user groups (admin, staff, student)
python manage.py setup_groups

# Create a superuser account
python manage.py createsuperuser
```

### 5. (Optional) Populate with Sample Data
```bash
# Add sample books, authors, and users for testing
python manage.py populatedb --users=50
```

### 6. Start Development Server
```bash
python manage.py runserver
```

The application will be available at: http://127.0.0.1:8000

## User Roles and Access

### Admin Users
- **Access**: Full system access
- **Capabilities**: 
  - Create new users (students and staff)
  - Manage all system settings
  - Access Django admin panel
- **URL**: http://127.0.0.1:8000/admin
- **Login**: Use the superuser account you created

### Staff/Librarian Users
- **Access**: Book management and issuing
- **Capabilities**:
  - Add new books to the library
  - Issue books to students
  - Manage book returns
  - View pending book requests
- **Dashboard**: http://127.0.0.1:8000/staff-issue

### Student Users
- **Access**: Book browsing and requesting
- **Capabilities**:
  - Browse available books
  - Request book issues
  - View their issued books
- **Dashboard**: http://127.0.0.1:8000/student-dashboard

## Key URLs

- **Home Page**: http://127.0.0.1:8000
- **User Registration**: http://127.0.0.1:8000/accounts/register
- **User Login**: http://127.0.0.1:8000/accounts/login
- **Admin Panel**: http://127.0.0.1:8000/admin
- **Admin User Creation**: http://127.0.0.1:8000/adminpage
- **Staff Dashboard**: http://127.0.0.1:8000/staff-issue
- **Add Books**: http://127.0.0.1:8000/staff-addbook
- **Student Dashboard**: http://127.0.0.1:8000/student-dashboard

## Creating Users

### Method 1: Using Django Admin (Recommended for initial setup)
1. Login to admin panel: http://127.0.0.1:8000/admin
2. Go to "Users" → "Add user"
3. Create the user account
4. Go to "Students" or "Librarians" to create the profile
5. Assign the user to appropriate group (admin/staff/student)

### Method 2: Using Admin Interface (After creating an admin user)
1. Create an admin user and assign them to 'admin' group
2. Login as admin user
3. Go to: http://127.0.0.1:8000/adminpage
4. Create new users and their profiles

## Database Information

- **Database Type**: SQLite3
- **Database File**: `db.sqlite3` (created in project root)
- **No additional database setup required**

## Email Configuration

For local development, emails are displayed in the console instead of being sent. Check your terminal/command prompt to see email notifications when books are issued.

## Development Features

### Search Functionality
The system supports searching by:
- Book title
- Author name
- ISBN
- User information

### AJAX Features
- Real-time book request processing
- Dynamic status updates without page refresh

### Sample Data
Use the `populatedb` command to generate sample data for testing:
```bash
# Generate 100 sample records
python manage.py populatedb --users=100
```

## Project Structure

```
library-management-system-master/
├── dbms/                   # Django project settings
│   ├── settings.py         # Main settings (configured for SQLite)
│   ├── urls.py            # URL routing
│   └── wsgi.py            # WSGI configuration
├── library/               # Main application
│   ├── models.py          # Database models
│   ├── views.py           # View controllers
│   ├── forms.py           # Django forms
│   ├── urls.py            # App URL routing
│   ├── admin.py           # Admin interface
│   ├── templates/         # HTML templates
│   ├── static/            # CSS, JS, images
│   └── management/        # Custom commands
├── manage.py              # Django management script
├── requirements-local.txt # Local development dependencies
└── db.sqlite3            # SQLite database (created after migration)
```

## Troubleshooting

### Common Issues

1. **ModuleNotFoundError**: Make sure you've installed the requirements:
   ```bash
   pip install -r requirements-local.txt
   ```

2. **Migration Issues**: If you encounter database errors:
   ```bash
   python manage.py migrate --run-syncdb
   ```

3. **Permission Denied**: Make sure your user is in the correct group:
   ```bash
   python manage.py shell
   >>> from django.contrib.auth.models import User, Group
   >>> user = User.objects.get(username='your_username')
   >>> group = Group.objects.get(name='staff')  # or 'student' or 'admin'
   >>> user.groups.add(group)
   ```

4. **Static Files Not Loading**: Run:
   ```bash
   python manage.py collectstatic
   ```

### Resetting the Database
If you need to start fresh:
```bash
# Remove the database file
rm db.sqlite3

# Recreate and migrate
python manage.py migrate
python manage.py setup_groups
python manage.py createsuperuser
```

## Development Workflow

1. Make code changes
2. Create/update migrations if models changed:
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```
3. Test your changes
4. Check for any errors in the console

## Production Deployment Note

This configuration is for local development only. For production deployment:
- Use a production database (PostgreSQL, MySQL)
- Configure proper email backend
- Set DEBUG = False
- Configure allowed hosts properly
- Use a proper web server (Gunicorn, uWSGI)

## Support

If you encounter issues:
1. Check the console output for error messages
2. Verify all dependencies are installed
3. Ensure you're running the correct Python version
4. Make sure the virtual environment is activated

Happy coding! 🚀