# Generated by Django 3.0.8 on 2020-08-19 01:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('University', '0002_auto_20200819_0058'),
    ]

    operations = [
        migrations.AddField(
            model_name='chapters',
            name='price',
            field=models.DecimalField(decimal_places=2, default=100.0, max_digits=5),
        ),
        migrations.AlterField(
            model_name='tutorprofile',
            name='about',
            field=models.TextField(blank=True, default='Great Tutor', null=True),
        ),
    ]
