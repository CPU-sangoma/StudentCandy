from rest_framework import serializers
from University.models import Course, Chapters, Contents, Enrolled, ChatRoom, Question, Responses, ResponseVotes, \
    ChapterComment, LoveChapter , ChapterResource


class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Course
        fields = ['id', 'certified', 'module_name', 'thumbnail', 'faculty', 'university',
                  'level', 'paid', 'tutor', 'module_code','introduction_vid','description']
        read_only_fields = ('tutor',)
        depth = 1


class ChapterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Chapters
        fields = ['course', 'id', 'description', 'length', 'name','likes','reviews','tutor','bought','price']
        depth = 1


class ContentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contents
        fields = ['chapter', 'content_file', 'content_type', 'name','chapter','tutor']
        depth = 1


class EnrolledSerializers(serializers.ModelSerializer):
    class Meta:
        model = Enrolled
        fields = ['id', 'course', 'student','chapter']
        depth = 1


class ChatRoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChatRoom
        fields = ['id', ' tutor', 'course', 'name']
        depth = 1


class QuestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = ['id', 'body', 'file', 'author', 'chapter']
        read_only_fields = ('author', 'chapter')
        depth = 1


class ResponseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Responses
        fields = ['id', 'body', 'file', 'author', 'question', 'votes']
        read_only_files = ('author', 'question')
        depth = 2


class ResponseVotesSerializer(serializers.ModelSerializer):
    class Meta:
        model = ResponseVotes
        fields = ['id', 'voter', 'response']
        read_only_files = ('voter', 'response')
        depth = 1


class ChapterCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChapterComment
        fields = ['id', 'commenter', 'chapter', 'body']
        read_only_files = ('commenter', 'chapter')
        depth = 1

class ChapterVotesSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoveChapter
        fields = ['id', 'voter', 'chapter']
        read_only_files = ('voter', 'chapter')
        depth = 1

class ChapterResourceSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChapterResource
        fields = ['id','chapter','name','file']
        read_only_files = ('chapter')
        depth = 1