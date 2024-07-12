---
title: Django
---

# Useful Django Commands
A collection of useful django commands that are used on a daily basis.

**Create migrations**
```bash linenums="1"
python manage.py makemigrations
```

**Apply migrations**
```bash linenums="1"
python manage.py migrate
```

**Create superuser**
```bash linenums="1"
python manage.py createsuperuser
```

**Change user password**
```bash linenums="1"
python manage.py changepassword <username>
```

**Clear all data**
```bash linenums="1"
python manage.py flush
```

**Revert to a previous migration**
```bash linenums="1"
python manage.py migrate 0032_name_of_migration
```
This will delete `0033_name_of_migration` and move the db one step back.

**Create fixutres**
```bash linenums="1"
python manage.py dumpdata app_name
```
The output should be saved to a `.json` file.

**Load fixutres**
```bash linenums="1"
python manage.py loaddata fixture_name.json
```

