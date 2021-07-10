from django.db import models
from django.conf import settings


# Create your models here.

class TutorProfile(models.Model):
    # bro all fields of this model are required...we need the data.
    user = models.OneToOneField(settings.AUTH_USER_MODEL, related_name='tut_user', on_delete=models.CASCADE)
    name = models.TextField(blank=True, null=True, default="test")
    surname = models.TextField(blank=True, null=True, default="test")
    profilepicture = models.ImageField(blank=True, null=True, default="media/tutorProfile/profile.png", upload_to="media/tutorProfile")
    year_of_study = models.IntegerField(blank=True, null=True, default=1)
    varsity_college = models.TextField(blank=True, null=True, default="test")
    faculty = models.TextField(blank=True, null=True, default="test")
    qualification = models.TextField(blank=True, null=True, default="test")
    cell_number = models.TextField(blank=True, null=True, default="test")
    approved = models.BooleanField(blank=True,null=True, default=False)
    complete = models.BooleanField(blank=True,null=True,default=False)
    about = models.TextField(blank=True, null=True, default="Great Tutor")
    merchantId = models.TextField(blank=False,null=True)


class StudentProfile(models.Model):
    # bro all fields of this model are required...we need the data.
    user = models.OneToOneField(settings.AUTH_USER_MODEL, related_name='stu_user', on_delete=models.CASCADE)
    name = models.TextField(blank=True, null=True, default="test")
    surname = models.TextField(blank=True, null=True, default="test")
    profilepicture = models.ImageField(blank=True, null=True, default="media/tutorProfile/profile.png", upload_to="media/studentprofile")
    year_of_study = models.IntegerField(blank=True, null=True, default=1)
    varsity_college = models.TextField(blank=True, null=True, default="test")
    faculty = models.TextField(blank=True, null=True, default="test")
    qualification = models.TextField(blank=True, null=True, default="test")
    cell_number = models.TextField(blank=True, null=True, default="test")


class Course(models.Model):
    module_code = models.TextField(blank=True, null=True, default="test")
    module_name = models.TextField(blank=True, null=True, default="test")
    description = models.TextField(blank=True, null=True, default="Ohh Yesss")
    thumbnail = models.ImageField(blank=True, null=True, default="test", upload_to="media/coursethumbnail")
    tutor = models.ForeignKey(TutorProfile, on_delete=models.CASCADE, related_name="tutor")
    faculty = models.TextField(blank=True, null=True, default="test")
    university = models.TextField(blank=True, null=True, default="test")
    enrolled_students_number = models.IntegerField(blank=True, null=True, default=0)
    certified = models.BooleanField(blank=True, null=True, default=False)
    level = models.IntegerField(blank=True, null=True, default=2)
    paid = models.BooleanField(blank=True, null=True, default=True)
    introduction_vid = models.FileField(blank=True, null=True, default="tes", upload_to="media/CourseResources")


class Chapters(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="course")
    name = models.TextField(blank=True, null=True, default="chapName")
    description = models.TextField(blank=True, null=True, default="test")
    length = models.IntegerField(blank=True, null=True, default=1)
    likes = models.IntegerField(blank=True,null=True, default=0)
    price = models.DecimalField(default=100.00,max_digits=5, decimal_places=2)
    reviews = models.IntegerField(blank=True,null=True,default=0)
    bought = models.BooleanField(blank=True,null=True,default=False)
    tutor = models.ForeignKey(TutorProfile, on_delete=models.CASCADE, related_name="tutor_chapters")

class ChapterComment(models.Model):
    chapter = models.ForeignKey(Chapters,on_delete=models.CASCADE, related_name="comment_course")
    body = models.TextField(blank=True, null=True)
    commenter = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="comment_author")



class Enrolled(models.Model):
    student = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name="enrolled_stu")
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="enrolled_module")
    chapter = models.ForeignKey(Chapters,on_delete=models.CASCADE,default=1, related_name="enrolled_chapter")


class Contents(models.Model):
    chapter = models.ForeignKey(Chapters, on_delete=models.CASCADE, related_name="cont_chapter")
    content_file = models.FileField(blank=True, null=True, default="tes", upload_to="media/CourseResources")
    name = models.TextField(blank=True, null=True, default="computing")
    content_type = models.TextField(blank=True, null=True, default="mp4")
    tutor = models.ForeignKey(TutorProfile, on_delete=models.CASCADE, related_name="tutor_contents")



class ChatRoom(models.Model):
    tutor = models.ForeignKey(TutorProfile, on_delete=models.CASCADE, related_name="chat_tutor")
    course = models.OneToOneField(Course, on_delete=models.CASCADE, related_name="chat_course")
    name = models.TextField(null=True, blank=True)


class Question(models.Model):
    chapter = models.ForeignKey(Chapters, on_delete=models.CASCADE, related_name="Qchapters", null=True)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="question_user")
    body = models.TextField(blank=True, null=True, default="ok")
    file = models.FileField(blank=True, null=True, upload_to="media/chatroomQuestions")


class Responses(models.Model):
    question = models.ForeignKey(Question,blank=True, null=True, on_delete=models.CASCADE)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="response_user")
    body = models.TextField(blank=True, null=True, default="ok")
    file = models.FileField(blank=True, null=True, default="des", upload_to="media/chatroomResponses")
    votes = models.IntegerField(blank=True, null=True, default=0)


class ResponseVotes(models.Model):
    response = models.ForeignKey(Responses, blank=True, null=True, on_delete=models.CASCADE,related_name="vote_response")
    voter = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="voter_name")

class LoveChapter(models.Model):
    chapter = models.ForeignKey(Chapters,on_delete=models.CASCADE,related_name="loved_chapter")
    lover = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="lover_name")

class ChapterResource(models.Model):
    chapter = models.ForeignKey(Chapters,on_delete=models.CASCADE,related_name="chapterresorces")
    name = models.TextField(null=True,blank=True)
    file = models.FileField(blank=True, null=True, default="tes", upload_to="media/ChapterResource")
    tutor = models.ForeignKey(TutorProfile,on_delete=models.CASCADE,related_name="chapterrestutor")



