# Generated by Django 3.0.8 on 2020-08-26 20:16

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('University', '0003_auto_20200819_0321'),
    ]

    operations = [
        migrations.RenameField(
            model_name='course',
            old_name='deccription',
            new_name='description',
        ),
    ]