# Generated by Django 4.2.10 on 2025-02-13 10:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chapters', '0005_alter_chapter_book'),
    ]

    operations = [
        migrations.AddField(
            model_name='chapter',
            name='is_accept',
            field=models.BooleanField(default=False),
        ),
    ]
