from django.urls import path
from Users.api.views import (

    RegisterUser,CustomAuthLogin
)


app_name = "Users"

urlpatterns = [

    path("register", RegisterUser, name="register"),
    path("login", CustomAuthLogin.as_view(), name="login"),

]
