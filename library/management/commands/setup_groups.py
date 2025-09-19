from django.core.management.base import BaseCommand
from django.contrib.auth.models import Group

class Command(BaseCommand):
    help = 'Creates the required user groups for the library management system'

    def handle(self, *args, **options):
        """Create the required groups: admin, staff, and student"""

        groups = ['admin', 'staff', 'student']
        created_count = 0

        self.stdout.write("Setting up user groups...")

        for group_name in groups:
            group, created = Group.objects.get_or_create(name=group_name)
            if created:
                self.stdout.write(
                    self.style.SUCCESS(f'✅ Created group: {group_name}')
                )
                created_count += 1
            else:
                self.stdout.write(
                    self.style.WARNING(f'ℹ️  Group already exists: {group_name}')
                )

        if created_count > 0:
            self.stdout.write(
                self.style.SUCCESS(f'\n🎉 Successfully created {created_count} new group(s)')
            )
        else:
            self.stdout.write(
                self.style.SUCCESS('\n✅ All required groups already exist')
            )

        self.stdout.write('\n📝 Available groups:')
        self.stdout.write('- admin: Full system access, can create users')
        self.stdout.write('- staff: Can manage books and issue them to students')
        self.stdout.write('- student: Can request book issues')
