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
python manage.py migrate app_name 0032_name_of_migration
```
This will undo `0033_name_of_migration` and move the db one step back. It is safe to delete the migration file after. It is also possible to just provide the first 4 numbers of the migration and not provide the full name.

**Create fixutres**
```bash linenums="1"
python manage.py dumpdata app_name
```
The output should be saved to a `.json` file.

**Load fixutres**
```bash linenums="1"
python manage.py loaddata fixture_name.json
```

**Start interactive terminal**
```bash linenums="1"
python manage.py shell
```
