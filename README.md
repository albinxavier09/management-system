# Library Management System 📚

A comprehensive web-based library management system built with Django, featuring book cataloging, user management, and automated book issuing workflows.

## ✨ Features

### 🔐 User Management
- **Role-based Access Control**: Admin, Staff/Librarian, and Student roles
- **User Registration & Authentication**: Secure login system
- **Profile Management**: Detailed user profiles with enrollment/employee information

### 📖 Book Management
- **Comprehensive Book Cataloging**: ISBN, author, publisher tracking
- **Advanced Search**: Search by title, author, ISBN, or user information
- **Book Availability Tracking**: Real-time availability status

### 🔄 Library Operations
- **Book Issuing System**: Streamlined book checkout process
- **Return Management**: Automated due date calculation and fine tracking
- **Request Queue**: Students can request books, staff can approve
- **Fine Calculation**: Automatic late fee calculation

### 🎨 User Interface
- **Responsive Design**: Bootstrap-based modern UI
- **AJAX Integration**: Real-time updates without page refresh
- **Dashboard Views**: Role-specific dashboards for different user types

### 📧 Notifications
- **Email Alerts**: Automated notifications for book issues and due dates
- **Console Development Mode**: Email notifications in console for development

## 🚀 Quick Start

### Prerequisites
- Python 3.6 or higher
- pip (Python package installer)

### Option 1: Automated Setup

**Linux/macOS:**
```bash
git clone https://github.com/albinxavier09/management-system.git
cd management-system
chmod +x setup.sh
./setup.sh
```

**Windows:**
```cmd
git clone https://github.com/albinxavier09/management-system.git
cd management-system
setup.bat
```

### Option 2: Manual Setup

1. **Clone the repository:**
```bash
git clone https://github.com/albinxavier09/management-system.git
cd management-system
```

2. **Create virtual environment:**
```bash
python3 -m venv venv
source venv/bin/activate  # Linux/macOS
# or
venv\Scripts\activate     # Windows
```

3. **Install dependencies:**
```bash
pip install -r requirements-local.txt
```

4. **Set up database:**
```bash
python manage.py makemigrations
python manage.py migrate
python manage.py setup_groups
python manage.py createsuperuser
```

5. **Start the development server:**
```bash
python manage.py runserver
```

6. **Access the application:**
Open your browser and visit: `http://127.0.0.1:8000`

## 📱 Application URLs

| Page | URL | Access |
|------|-----|--------|
| Home | `http://127.0.0.1:8000` | All users |
| Admin Panel | `http://127.0.0.1:8000/admin` | Admin only |
| User Registration | `http://127.0.0.1:8000/accounts/register` | Public |
| User Login | `http://127.0.0.1:8000/accounts/login` | Public |
| Create Users | `http://127.0.0.1:8000/adminpage` | Admin only |
| Staff Dashboard | `http://127.0.0.1:8000/staff-issue` | Staff only |
| Add Books | `http://127.0.0.1:8000/staff-addbook` | Staff only |
| Student Dashboard | `http://127.0.0.1:8000/student-dashboard` | Students only |

## 👥 User Roles

### 🔧 Admin
- Full system access and management
- Create and manage user accounts
- Access to Django admin panel
- System configuration

### 📋 Staff/Librarian
- Manage book inventory
- Issue and return books
- Process student requests
- Generate reports

### 🎓 Student
- Browse book catalog
- Request book issues
- View personal book history
- Search library collection

## 🛠️ Technology Stack

- **Backend**: Django 1.11.11
- **Database**: SQLite3 (development) / PostgreSQL (production)
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap
- **Authentication**: Django built-in authentication
- **AJAX**: jQuery for dynamic interactions
- **Email**: Django email framework with console backend (development)

## 📁 Project Structure

```
management-system/
├── dbms/                   # Django project settings
│   ├── settings.py         # Main configuration
│   ├── urls.py            # URL routing
│   └── wsgi.py            # WSGI configuration
├── library/               # Main application
│   ├── models.py          # Database models
│   ├── views.py           # View controllers
│   ├── forms.py           # Django forms
│   ├── urls.py            # App URLs
│   ├── admin.py           # Admin interface
│   ├── templates/         # HTML templates
│   ├── static/            # CSS, JS, images
│   └── management/        # Custom Django commands
├── requirements-local.txt # Development dependencies
├── setup.sh              # Linux/macOS setup script
├── setup.bat             # Windows setup script
├── QUICK_START.md        # Quick setup guide
└── README_LOCAL_DEV.md   # Detailed development guide
```

## 📊 Database Models

- **Books**: Book information with issue tracking
- **Author**: Author details and bibliography
- **Publisher**: Publisher information
- **Student**: Student profiles and enrollment data
- **Librarian**: Staff profiles and permissions
- **Issue**: Book issue tracking and history

## 🎯 Key Features in Detail

### Book Management
- Add new books with complete metadata
- Track book availability in real-time
- Manage multiple copies of the same book
- ISBN validation and duplicate prevention

### Issue Management
- Request-based book issuing workflow
- Automated due date calculation (14 days)
- Fine calculation for overdue books
- Email notifications for issues and returns

### Search & Discovery
- Multi-field search functionality
- Filter by author, title, ISBN
- User search for administrative tasks
- Advanced search capabilities

### Reporting
- Track issued books per student
- Monitor overdue books
- Generate fine reports
- User activity logging

## 🔧 Development Commands

```bash
# Start development server
python manage.py runserver

# Create database migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Set up user groups
python manage.py setup_groups

# Generate sample data
python manage.py populatedb --users=50

# Collect static files
python manage.py collectstatic
```

## 🧪 Testing

Generate sample data for testing:
```bash
python manage.py populatedb --users=100
```

This creates:
- Sample books with random titles
- Fake authors and publishers
- Test user accounts
- Sample student and librarian profiles

## 📋 Environment Variables

For production deployment, set these environment variables:
- `SECRET_KEY`: Django secret key
- `DEBUG`: Set to `False` for production
- `DATABASE_URL`: Production database URL
- `SENDGRID_API_KEY`: Email service API key

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🐛 Troubleshooting

### Common Issues

1. **Module not found errors**: Ensure virtual environment is activated and dependencies are installed
2. **Database errors**: Run `python manage.py migrate --run-syncdb`
3. **Permission denied**: Check user group assignments in Django admin
4. **Static files not loading**: Run `python manage.py collectstatic`

### Getting Help

- Check the [QUICK_START.md](QUICK_START.md) for setup instructions
- Review [README_LOCAL_DEV.md](README_LOCAL_DEV.md) for detailed development guide
- Create an issue for bug reports or feature requests

## 🎉 Acknowledgments

- Django framework for the robust backend
- Bootstrap for responsive UI components
- Material Design for modern styling
- Factory Boy for test data generation

---

**Happy Coding! 🚀**

Built with ❤️ using Django