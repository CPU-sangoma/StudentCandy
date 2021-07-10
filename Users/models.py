from django.db import models
from django.contrib.auth.models import AbstractUser

from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token
from University.models import TutorProfile, StudentProfile

# Create your models here.

class CustomUser(AbstractUser):
    user_type = models.TextField(null=False,blank=False,default="Student")
    university_college = models.TextField(null=False,blank=False,default="NWU")



@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)

        if instance.user_type == "Tutor":
            TutorProfile.objects.create(
                user=instance)
        else:
            StudentProfile.objects.create(user=instance)




