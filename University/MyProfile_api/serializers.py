from rest_framework import serializers
from University.models import StudentProfile,TutorProfile



class StudentProSerializers(serializers.ModelSerializer):


    class Meta:
        model = StudentProfile
        fields = ['name','surname','profilepicture','year_of_study','varsity_college','faculty','qualification','cell_number']




class TutorProSerializer(serializers.ModelSerializer):


    class Meta:
        model = TutorProfile
        fields = ['name','surname','profilepicture','year_of_study','varsity_college','faculty','qualification','cell_number','approved','about','merchantId']