# Generated by Django 4.2.10 on 2025-03-13 16:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chapters', '0006_chapter_is_accept'),
    ]

    operations = [
        migrations.AddField(
            model_name='chapter',
            name='note',
            field=models.CharField(max_length=250, null=True),
        ),
    ]
