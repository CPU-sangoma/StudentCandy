from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny, IsAuthenticated
from University.models import StudentProfile, TutorProfile
from .serializers import StudentProSerializers,TutorProSerializer
from University.Courses_api.serializers import CourseSerializer,Course



@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def MyProfile(request):

    user = request.user
    data = {}

    if user.user_type == "Tutor":
        profile = TutorProfile.objects.get(user=user)
        seri = TutorProSerializer(profile,data=request.data)
        if seri.is_valid():
            data['operations'] = "success"
            print(seri.data)
            return Response(status=status.HTTP_200_OK,data=seri.data)
        else:
            data['operations'] = "failed"
            return Response(status=status.HTTP_404_NOT_FOUND,data=data)
    else:
        profile = StudentProfile(user=user)
        seri = StudentProSerializers(profile, data=request.data)
        if seri.is_valid():
            print(seri.data)
            return Response(status=status.HTTP_200_OK, data=seri.data)


@api_view(['PATCH',])
@permission_classes((IsAuthenticated,))
def EditMyProfile(request):


    user = request.user
    data = {}

    if user.user_type == "Tutor":
        profile = TutorProfile.objects.get(user=user)
        seri = TutorProSerializer(profile,data=request.data)

        if seri.is_valid():
            data['operations'] = "success"
            profile.complete = 1
            profile.save()
            seri.save()
            return Response(status=status.HTTP_200_OK,data=data)
        else:
            data['operations'] = "failed"
            return Response(status=status.HTTP_400_BAD_REQUEST, data=data)
    else:
        profile = StudentProfile.objects.get(user=user)
        seri = StudentProSerializers(profile, data=request.data)

        if seri.is_valid():
            data['operations'] = "success"
            seri.save()
            return Response(status=status.HTTP_200_OK, data=data)
        else:
            data['operations'] = "failed"
            return Response(status=status.HTTP_400_BAD_REQUEST, data=data)



@api_view(['GET',])
@permission_classes((AllowAny,))
def GetChosenTutor(request,slug):

    tutor = TutorProfile.objects.get(id=slug)
    tutseri = TutorProSerializer(tutor)

    return Response(data=tutseri.data, status=status.HTTP_200_OK)



