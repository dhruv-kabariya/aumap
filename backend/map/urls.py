from django.contrib import admin
from django.urls import path

from .views import LocationPointView, StreetView, getBuildigs, index,StructuralView

urlpatterns = [
    path('', index, name="home"),
    path('buildings/', getBuildigs, name='Buildigs'),
    path('structural/',StructuralView.as_view(),),
    path('streets/',StreetView.as_view(),),
    path('locationpoints/',LocationPointView.as_view(),),
    
]


# http:www.homepage.com/
