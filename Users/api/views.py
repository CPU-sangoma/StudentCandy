from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from Users.api.serializers import UserRegSerializers
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken


class CustomAuthLogin(ObtainAuthToken):

    def post(self,request,*args,**kwargs):
        serializer = self.serializer_class(data=request.data,context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token = Token.objects.get(user=user)
        return Response({
            'token': token.key,
            'user_type': user.user_type,
        })






@api_view(['POST', ])
@permission_classes((AllowAny,))
def RegisterUser(request):
    serializer = UserRegSerializers(data=request.data)
    data = {}
    datas=[]

    if serializer.is_valid():
        cusUser = serializer.save()
        data['response'] = "successfully registered"
        data['email'] = cusUser.email
        data['username'] = cusUser.username
        data['type'] = cusUser.user_type
        token = Token.objects.get(user=cusUser).key
        data['token'] = token
        datas = [data['email'],data['response'],data['token']]
    else:
        data = serializer.errors
    return Response(data=data)
