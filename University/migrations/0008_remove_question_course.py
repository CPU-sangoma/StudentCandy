# Generated by Django 3.0.8 on 2020-09-20 20:58

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('University', '0007_question_course'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='question',
            name='course',
        ),
    ]
