# Generated by Django 4.2.10 on 2025-03-13 16:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('books', '0008_like'),
    ]

    operations = [
        migrations.AddField(
            model_name='book',
            name='note',
            field=models.CharField(max_length=250, null=True),
        ),
    ]
