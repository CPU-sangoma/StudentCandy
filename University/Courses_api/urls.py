from django.urls import path
from . import views


app_name ="Course"

urlpatterns = [

  path("createcourse",views.CreateCourse, name="createCourse"),

  path("getallcourses",views.GetAllCourse,name="all courses"),

  path("coursedetail/<slug>",views.CourseDetail, name="coursedetail"),

  path("getchapters/<slug>",views.GetChapters,name="coursechapters"),

  path("byfaculty/<slug>", views.ByFaculty, name="Faculty courses"),

  path("bycode/<slug>", views.ByCode, name="code courses"),

  path("bylevel/<slug>", views.ByLevel, name="level courses"),

  path("byschool/<slug>", views.BySchool, name="school courses"),

  path("filterby/<school>/<module>", views.BySchoolnModule, name="schoolnmodule courses"),

  path("addChapter/<courseId>",views.AddChapter, name="addChapter"),

  path("addContent/<chapId>",views.AddContent, name="addContent"),

  path("Takecourse/<courseId>/<chapterId>",views.TakeCourse, name="enroll"),

  path("getcoursecomments/<slug>",views.GetCourseComments,name="courseComment"),

  path("myencourses/",views.ListMyCourses, name="coursesenrolled"),

  path("myencoursescom/<slug>",views.ListMyCoursesChapters, name="coursesenrolled"),

  path("askquestion/<chapterID>",views.AskQuestion, name="ask_question"),

  path("getQuestions/<chapter>",views.GetQuestions, name="get_questions"),

  path("myQuestions/<slug>",views.MyQuestions,name="myquestions"),

  path("reply/<slug>",views.Reply,name="reply_question"),

  path("likeresponse/<slug>",views.LikeResponse,name="like_response"),

  path("getreplies/<slug>/",views.GetReplies,name="get_replies"),

  path("getchapter/<slug>/",views.GetChapter,name="chapters"),

  path("getcontent/<slug>",views.GetContents,name="content"),

  path("chaptercomment/<slug>", views.CommentOnChapter, name="commentoncourse"),

  path("lovechapter/<slug>",views.LoveChapters, name="lovechapter"),

  path("getchaptercomments/<slug>",views.GetChapterComments, name="getchaptercomment"),

  #Edit course and its chapters

  path("getmycourses",views.GetMyCourses,name="mycourses"),

  path("deletecourse/<slug>",views.DeleteCourse, name="deletecourse"),

  path("deletechapter/<slug>",views.DeleteChapter,name="deletechapter"),

  path("editcourse/<slug>",views.EditCourse,name="editcourse"),

  path("editchapter/<slug>",views.EditChapter,name="editchapter"),

  path("editcontent/<slug>",views.EditContent,name="editcontent"),

  path("postchapterresource/<slug>",views.CreateChapterResource,name="postchapterres"),

  path("getchapterresource/<slug>",views.GetChapterResources,name="getchapterresources"),

  path("deletechapterresource/<slug>",views.Deletechapterresource,name="getchapterresources"),

  path("updatechapterresource/<slug>",views.UpdateChapResource,name="updatechapterresources"),






]