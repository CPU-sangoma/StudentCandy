from rest_framework import serializers
from Users.models import CustomUser
from University.models import TutorProfile,StudentProfile


class UserRegSerializers(serializers.ModelSerializer):
    password2 = serializers.CharField(style={'input': 'password'}, write_only=True)

    class Meta:
        model = CustomUser
        fields = ['email', 'username', 'password', 'password2', 'user_type']
        extra_kwargs = {
            'password': {'write_only': True}
        }

    def save(self):
        CusUser = CustomUser(
            email=self.validated_data['email'],
            username=self.validated_data['username'],
            user_type=self.validated_data['user_type']
        )

        password = self.validated_data['password']
        password2 = self.validated_data['password2']

        if password != password2:
            raise serializers.ValidationError({'password': 'passwords must match'})
        else:
            CusUser.set_password(password)
            CusUser.save()
            return CusUser
