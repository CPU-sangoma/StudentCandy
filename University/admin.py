from django.contrib import admin
from .models import TutorProfile, StudentProfile
# Register your models here.

admin.site.register(TutorProfile)
admin.site.register(StudentProfile)