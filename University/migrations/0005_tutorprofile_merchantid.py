# Generated by Django 3.0.8 on 2020-09-06 11:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('University', '0004_auto_20200826_2216'),
    ]

    operations = [
        migrations.AddField(
            model_name='tutorprofile',
            name='merchantId',
            field=models.TextField(null=True),
        ),
    ]