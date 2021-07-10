from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny, IsAuthenticated
from .serializers import CourseSerializer, ChapterSerializer, ContentSerializer, EnrolledSerializers, QuestionSerializer,ResponseSerializer, ChapterCommentSerializer, ChapterResourceSerializer
from University.models import Course, Chapters, Contents, Enrolled, ChatRoom, Question, Responses, ChapterComment,ResponseVotes, LoveChapter , ChapterResource
from Users.models import CustomUser

@api_view(['POST', ])
@permission_classes((IsAuthenticated,))
def CreateCourse(request):
    user = request.user
    data = {}
    if user.user_type == "Tutor":
        if user.tut_user.approved is True:
            if user.tut_user.complete is True:
                course = Course(tutor=user.tut_user,university=user.university_college)
                seri = CourseSerializer(course, data=request.data)

                if seri.is_valid():
                    seri.save()
                    data['operations'] = "Course Uploaded"
                    chat = ChatRoom(tutor=user.tut_user, course=course, name=course.module_name)
                    chat.save()
                    return Response(data=data, status=status.HTTP_201_CREATED)

                else:
                    data['operations'] = "Failed"
                    return Response(data=data,status=status.HTTP_400_BAD_REQUEST)
            else:
                data['operations'] = "You need to finish editing your profile"
                return Response(data=data, status=status.HTTP_400_BAD_REQUEST)
        else:
            data['operations'] = "You are not yet approved to upload courses"
            return Response(data=data,status=status.HTTP_401_UNAUTHORIZED)
    else:
        return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)



@api_view(['GET', ])
@permission_classes((AllowAny,))
def GetAllCourse(request):
    course = Course.objects.all()
    seri = CourseSerializer(course, many=True)

    return Response(data=seri.data, status=status.HTTP_200_OK)


@api_view(['GET', ])
@permission_classes((AllowAny,))
def CourseDetail(request, slug):
    course = Course.objects.get(id=slug)
    seri = CourseSerializer(course)

    return Response(data=seri.data, status=status.HTTP_200_OK)


@api_view(['GET', ])
@permission_classes((AllowAny,))
def ByFaculty(request, slug):
    course = Course.objects.filter(faculty=slug)
    seri = CourseSerializer(course, many=True)

    return Response(data=seri.data, status=status.HTTP_200_OK)

@api_view(['GET', ])
@permission_classes((AllowAny,))
def ByCode(request, slug):
    course = Course.objects.filter(module_code__iexact=slug)
    seri = CourseSerializer(course, many=True)

    return Response(data=seri.data, status=status.HTTP_200_OK)


@api_view(['GET', ])
@permission_classes((AllowAny,))
def ByLevel(request, slug):
    course = Course.objects.filter(Level=slug)
    seri = CourseSerializer(course, many=True)

    return Response(data=seri.data, status=status.HTTP_200_OK)


@api_view(['GET', ])
@permission_classes((AllowAny,))
def BySchool(request, slug):
    course = Course.objects.filter(university=slug)
    seri = CourseSerializer(course, many=True)

    return Response(data=seri.data, status=status.HTTP_200_OK)


@api_view(['GET', ])
@permission_classes((AllowAny,))
def BySchoolnModule(request, school, module):
    course = Course.objects.filter(university=school, module_name=module)
    seri = CourseSerializer(course, many=True)

    return Response(data=seri.data, status=status.HTTP_200_OK)


@api_view(['POST', ])
@permission_classes((IsAuthenticated,))
def AddChapter(request, courseId):
    user = request.user
    data = {}

    if user.user_type == "Tutor":
        course = Course.objects.get(id=courseId)
        chapters = Chapters(course=course,tutor=user.tut_user)
        seriChap = ChapterSerializer(chapters, request.data)

        if seriChap.is_valid():
            seriChap.save()
            data['operations'] = "Successful"

            return Response(data=data, status=status.HTTP_201_CREATED)
        else:
            data['operations'] = "Failed1"
            print(seriChap.errors)
            print(course.module_name)
            return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)
    else:
        data['operations'] = "Failed2"
        return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['POST', ])
@permission_classes((IsAuthenticated,))
def AddContent(request, chapId):
    user = request.user
    data = {}

    if user.user_type == "Tutor":
        chapter = Chapters.objects.get(id=chapId)

        content = Contents(chapter_id=chapId,tutor=user.tut_user)

        seri = ContentSerializer(content, data=request.data)

        if seri.is_valid():
            seri.save()
            data['operations'] = "success"
            return Response(data=data, status=status.HTTP_201_CREATED)
        else:
            data['operations'] = "failed"
            return Response(data=data, status=status.HTTP_400_BAD_REQUEST)
    else:
        return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['POST', ])
@permission_classes((IsAuthenticated,))
def TakeCourse(request, courseId,chapterId):
    user = request.user
    course = Course.objects.get(id=courseId)
    chapter = Chapters.objects.get(id=chapterId)
    data = {}

    enrolled = Enrolled.objects.filter(course=course,student=user,chapter=chapter)
    if not enrolled:
        enrolling = Enrolled(course=course,chapter=chapter)
        enrolling.save()
        enrolling.student.add(user)
        course.enrolled_students_number = course.enrolled_students_number + 1
        course.save()
        chapter.bought = True
        chapter.save()
        data['operations'] = "enrolled successfuly"
        return Response(data=data,status=status.HTTP_201_CREATED)
    else:
        data['operations'] = "Already taking this module"
        return Response(data=data, status=status.HTTP_200_OK)



@api_view(['GET', ])
@permission_classes((IsAuthenticated,))
def ListMyCourses(request):

    user = request.user
    enrolled = Enrolled.objects.filter(student=user)
    enseri = EnrolledSerializers(enrolled, many=True)
 
    return Response(data=enseri.data, status=status.HTTP_200_OK)

@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def ListMyCoursesChapters(request,slug):
    user = request.user
    course = Course.objects.get(id=slug)

    enrolled = Enrolled.objects.filter(student=user,course=course)

    enseri = EnrolledSerializers(enrolled, many=True)

    return Response(data=enseri.data, status=status.HTTP_200_OK)



@api_view(['POST', ])
@permission_classes((IsAuthenticated,))
def AskQuestion(request,chapterID):
    user = request.user
    data = {}
    chapter = Chapters.objects.get(id=chapterID)


    qus = Question(author=user,chapter=chapter)

    qSeri = QuestionSerializer(qus,data=request.data)



    if qSeri.is_valid():
        qSeri.save()
        if qSeri.save:

            mydata = Question.objects.filter(author=user).last()
            mydataseri = QuestionSerializer(mydata)
            return Response(data=mydataseri.data,status=status.HTTP_200_OK)

    else:
        print(qSeri.errors)
        return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def MyQuestions(request,slug):

    chapter = Chapters.objects.get(id = slug)
    user =request.user
    qus = Question.objects.filter(author = user, chapter = chapter)
    qusSeri = QuestionSerializer(qus,many=True)

    return Response(data=qusSeri.data,status=status.HTTP_200_OK)

@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def GetQuestions(request,chapter):
    user = request.user
    chap = Chapters.objects.get(id = chapter)
    ques = Question.objects.filter(chapter = chap)

    queseri = QuestionSerializer(ques, many=True)

    return Response(data=queseri.data,status=status.HTTP_200_OK)

@api_view(['POST', ])
@permission_classes((IsAuthenticated,))
def Reply(request, slug):
    user = request.user

    data = {}

    question = Question.objects.get(id=slug)

    res = Responses(question=question, author=user)

    rSeri = ResponseSerializer(res,data=request.data)

    if rSeri.is_valid():
        print(res.question)
        rSeri.save()
        rdata = Responses.objects.filter(author=user).last()
        rdataseri = ResponseSerializer(rdata)
        return Response(data=rdataseri.data,status=status.HTTP_200_OK)

    else:
        print(rSeri.errors)
        return Response(status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def GetReplies(request,slug):
    user = request.user
    ques = Question.objects.get(id = slug)
    res = Responses.objects.filter(question = ques)

    reseri = ResponseSerializer(res, many=True)

    return Response(data=reseri.data,status=status.HTTP_200_OK)

@api_view(['GET',])
@permission_classes((AllowAny,))
def GetChapter(request,slug):

    course = Course.objects.get(id=slug)
    chap = Chapters.objects.filter(course = course)

    chapseri = ChapterSerializer(chap,many=True)

    return Response(data=chapseri.data,status=status.HTTP_200_OK)

@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def GetContents(request,slug):

    chapter = Chapters.objects.get(id=slug)
    cont = Contents.objects.filter(chapter = chapter)
    contseri = ContentSerializer(cont,many=True)

    return Response(data=contseri.data,status=status.HTTP_200_OK)

@api_view(['POST',])
@permission_classes((IsAuthenticated,))
def CommentOnChapter(request,slug):

    user = request.user
    chapter = Chapters.objects.get(id=slug)
    com = ChapterComment(commenter=user, chapter=chapter)
    cserializer = ChapterCommentSerializer(com,data=request.data)
    data = {}

    if cserializer.is_valid():
        cserializer.save()
        chapter.reviews = chapter.reviews + 1
        chapter.save()
        data['operations'] = "successful"
        return Response(data=data,status=status.HTTP_201_CREATED)
    else:
        print(cserializer.errors)
        data['operations'] = "failed"
        return Response(data=data, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST',])
@permission_classes((IsAuthenticated,))
def LoveChapters(request,slug):
    user = request.user
    data = {}
    chapter = Chapters.objects.get(id=slug)

    chapvote = LoveChapter.objects.filter(lover=user, chapter=chapter)
    if chapvote.count() > 0:
        data['operations'] = "unliked complete"
        chapvote.delete()
        chapter.likes = chapter.likes - 1
        chapter.save()
        return Response(data=data, status=status.HTTP_201_CREATED)
    else:
        data['operations'] = "successfully liked"
        chappv = LoveChapter(lover=user, chapter=chapter)
        chapter.likes = chapter.likes + 1
        chapter.save()
        chappv.save()
        return Response(data=data, status=status.HTTP_201_CREATED)

@api_view(['GET',])
@permission_classes((AllowAny,))
def GetChapterComments(request,slug):

    chapter = ChapterComment.objects.filter(chapter=slug)
    chapseri = ChapterCommentSerializer(chapter,many=True)

    return Response(data=chapseri.data,status=status.HTTP_200_OK)




@api_view(['POST',])
@permission_classes((IsAuthenticated,))
def LikeResponse(request,slug):

    user = request.user
    data = {}
    response = Responses.objects.get(id=slug)


    resvote = ResponseVotes.objects.filter(voter=user, response=response)
    if resvote.count() > 0:
        data['operations'] = "unliked complete"
        resvote.delete()
        response.votes = response.votes - 1
        response.save()
        return Response(data=data, status=status.HTTP_201_CREATED)
    else:
        data['operations'] = "successfully liked"
        respv = ResponseVotes(voter = user , response=response)
        response.votes = response.votes +1
        response.save()
        respv.save()
        return Response(data=data, status=status.HTTP_201_CREATED)



@api_view(['GET',])
@permission_classes((AllowAny,))
def GetChapters(request,slug):

    course = Course.objects.get(id=slug)
    chap = Chapters.objects.filter(course = course)

    chapseri = ChapterSerializer(chap,many=True)

    return Response(data=chapseri.data,status=status.HTTP_200_OK)

@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def GetCourseComments(request,slug):
    course = Course.objects.get(id =slug)
    courseCom = ChapterComment.objects.filter(course = course)
    ccseri = ChapterCommentSerializer(courseCom,many=True)

    return Response(data=ccseri.data,status=status.HTTP_200_OK)


#edit course/chapters/content Views

@api_view(['GET', ])
@permission_classes((IsAuthenticated,))
def GetMyCourses(request):
    user = request.user
    if user.user_type == "Tutor":
        courses = Course.objects.filter(tutor=user.tut_user)
        seri = CourseSerializer(courses, many=True)
        return Response(data=seri.data, status=status.HTTP_200_OK)
    else:
        return Response(status=status.HTTP_401_UNAUTHORIZED)


@api_view(['DELETE',])
@permission_classes((IsAuthenticated,))
def DeleteCourse(request, slug):
    user = request.user
    course = Course.objects.get(id=slug)
    data = {}

    if course.enrolled_students_number <= 0:
        if course.tutor == user.tut_user:
            data['operations'] = "deleted succesfuly"
            course.delete()
            return Response(data=data, status=status.HTTP_200_OK)
        else:
            data['operations'] = "failed"
            return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)
    else:
        data['operations'] = "failed, someone has already enrolled for this course,"
        return Response(data=data, status=status.HTTP_400_BAD_REQUEST)


@api_view(['DELETE',])
@permission_classes((IsAuthenticated,))
def DeleteChapter(request, slug):
    user = request.user
    chapter = Chapters.objects.get(id=slug)
    data = {}

    if chapter.bought is False:
        if chapter.tutor == user.tut_user:
            data['operations'] = "deleted succesfuly"
            chapter.delete()
            return Response(data=data, status=status.HTTP_200_OK)
        else:
            data['operations'] = "failed"
            return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)
    else:
        data['operations'] = "failed, someone has already bought this chapter,"
        return Response(data=data, status=status.HTTP_400_BAD_REQUEST)

@api_view(['PATCH',])
@permission_classes((IsAuthenticated,))
def EditCourse(request,slug):

    user = request.user
    course = Course.objects.get(id=slug)
    data = {}

    if user.user_type == "Tutor":
        if course.tutor == user.tut_user:
            CourseSeri =CourseSerializer(course,request.data)

            if CourseSeri.is_valid():
                data['operations'] = "Updated Successfully"
                CourseSeri.save()
                return Response(data=data, status=status.HTTP_200_OK)
            else:
                data['operations'] = "Failed"
                return Response(data=data, status=status.HTTP_400_BAD_REQUEST)
        else:
            data['operations'] = "Not the Tutor of this Course"
            return Response(data=data,status=status.HTTP_401_UNAUTHORIZED)
    else:
        data['operations'] = "Not the Tutor"
        return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['PATCH', ])
@permission_classes((IsAuthenticated,))
def EditChapter(request, slug):
    user = request.user
    chapter = Chapters.objects.get(id=slug)
    data = {}

    if user.user_type == "Tutor":
        if chapter.tutor == user.tut_user:
            ChapterSeri = ChapterSerializer(chapter, request.data)

            if ChapterSeri.is_valid():
                data['operations'] = "Updated Successfully"
                ChapterSeri.save()
                return Response(data=data, status=status.HTTP_200_OK)
            else:
                data['operations'] = "Failed"
                return Response(data=data, status=status.HTTP_400_BAD_REQUEST)
        else:
            data['operations'] = "Not the Tutor of this Chapter"
            return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)
    else:
        data['operations'] = "Not a Tutor"
        return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['PATCH', ])
@permission_classes((IsAuthenticated,))
def EditContent(request, slug):
    user = request.user
    content = Contents.objects.get(id=slug)
    data = {}

    if user.user_type == "Tutor":
        if content.tutor == user.tut_user:
            ContentSeri = ContentSerializer(content, request.data)

            if ContentSeri.is_valid():
                data['operations'] = "Updated Successfully"
                ContentSeri.save()
                return Response(data=data, status=status.HTTP_200_OK)
            else:
                data['operations'] = "Failed"
                return Response(data=data, status=status.HTTP_400_BAD_REQUEST)
        else:
            data['operations'] = "Not the Tutor of this Content"
            return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)
    else:
        data['operations'] = "Not a Tutor"
        return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)



@api_view(['POST',])
@permission_classes((IsAuthenticated,))
def CreateChapterResource(request,slug):

    data = {}
    user = request.user
    chapter = Chapters.objects.get(id=slug)

    if user.user_type == "Tutor":
        if chapter.tutor == user.tut_user:
            chapterres = ChapterResource(tutor=user.tut_user, chapter=chapter)
            chapresseri = ChapterResourceSerializer(chapterres, request.data)

            if chapresseri.is_valid():
                data['operations'] = "created Successfully"
                chapresseri.save()
                data['operations'] = "successfully"
                return Response(data=data, status=status.HTTP_201_CREATED)
            else:
                data['operations'] = "Failed"
                return Response(data=data, status=status.HTTP_400_BAD_REQUEST)

        else:
            data['operations'] = "Not authorized, not the owner of this chapter"
            return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)

    else:
        data['operations'] = "Not authorized"
        return Response(data=data,status=status.HTTP_401_UNAUTHORIZED)



@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def GetChapterResources(request,slug):

    chapter = Chapters.objects.get(id=slug)
    chapterres = ChapterResource.objects.filter(chapter=chapter)
    chapterresseri = ChapterResourceSerializer(chapterres,many=True)

    return Response(data=chapterresseri.data,status=status.HTTP_200_OK)

@api_view(['DELETE',])
@permission_classes((IsAuthenticated,))
def Deletechapterresource(request,slug):

    user = request.user

    data = {}

    if user.user_type == "Tutor":
        chapterres = ChapterResource.objects.get(id=slug)

        if chapterres.tutor == user.tut_user:
            chapterres.delete()
            data['operations'] = "sucessfuly deleted"
            return Response(data=data, status=status.HTTP_200_OK)

        else:
            data['operations'] = "Not authorized, you are not the author"
            return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)




    else:
        data['operations'] = "Not authorized, you need to be a tutor"
        return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)

@api_view(['PATCH',])
@permission_classes((IsAuthenticated,))
def UpdateChapResource(request,slug):
    user = request.user

    data = {}

    if user.user_type == "Tutor":
        chapterres = ChapterResource.objects.get(id=slug)
        if chapterres.tutor == user.tut_user:
            chapterresseri = ChapterResourceSerializer(chapterres,request.data)

            if chapterresseri.is_valid():
                chapterresseri.save()
                data['operations'] = "updated successfully"
                return Response(data=data,status=status.HTTP_200_OK)

            else:
                data['operations'] = "Failed"
                return Response(data=data, status=status.HTTP_400_BAD_REQUEST)

        else:
            data['operations'] = "Not authorized, you are not the author"
            return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)

    else:
        data['operations'] = "Not authorized, you need to be a tutor"
        return Response(data=data, status=status.HTTP_401_UNAUTHORIZED)

