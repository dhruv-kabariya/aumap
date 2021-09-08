from django.contrib import admin

from .models import *
# Register your models here.

admin.site.register([Coordinate, Structural, Buildings, Street,
                     LocationPoint, Marker, Information, Pictures,Review,Like])
