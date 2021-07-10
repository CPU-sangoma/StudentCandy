from django.urls import path
from . import views


app_name ="Mypro"

urlpatterns = [

    path('myprofile/',views.MyProfile, name="myprofile"),
    path('editprofile',views.EditMyProfile, name="editmyprofile"),
    path('selectprofile/<slug>',views.GetChosenTutor, name="chosenTutor"),


]




