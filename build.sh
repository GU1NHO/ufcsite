#!/usr/bin/env bash
# exit on error
set -o errexit

pip install -r requirements.txt

python manage.py collectstatic --no-input

# Execute as migrações antes de qualquer outra coisa
python manage.py migrate

# Crie o superusuário se não existir
python manage.py shell << EOF
import os
from django.contrib.auth import get_user_model

User = get_user_model()
if not User.objects.filter(username=os.environ.get("DJANGO_SUPERUSER_USERNAME", "admin")).exists():
    User.objects.create_superuser(
        os.environ.get("DJANGO_SUPERUSER_USERNAME", "admin"),
        os.environ.get("DJANGO_SUPERUSER_EMAIL", "admin@example.com"),
        os.environ.get("DJANGO_SUPERUSER_PASSWORD", "password")
    )
EOF