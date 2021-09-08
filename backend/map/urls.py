from django.contrib import admin
from django.urls import path

from .views import FindRoute, InformationView, LikeCheckView, LikeView, LocationDetail, LocationPointView, Login, SearchLocationByName, SignUp, StreetView, getBuildigs, index, StructuralView

urlpatterns = [
    path('', index, name="home"),
    path('buildings/', getBuildigs, name='Buildigs'),
    path('structural/', StructuralView.as_view(),),
    path('streets/', StreetView.as_view(),),
    path('locationpoints/', LocationPointView.as_view(),),
    path('locationpoints/<str:location>', SearchLocationByName.as_view(),),
    path('findroute/<str:start>/<str:end>', FindRoute.as_view(),),
    path('review/<int:location>',LocationDetail.as_view()),
    path('like/<int:review>/',LikeView.as_view()),
    path('likecheck/<int:review>/',LikeCheckView.as_view()),
    
    path('information/<int:location_id>',InformationView.as_view()),
    path('login/',Login.as_view()),
    path('signup/',SignUp.as_view()),

]


# http:www.homepage.com/
