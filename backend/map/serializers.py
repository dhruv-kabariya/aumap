from math import trunc
from django.db import models
from django.db.models import fields
from django.db.models.fields import files
from rest_framework import serializers
from django.contrib.auth.models import User

from .models import Buildings, Coordinate, Information, LocationPoint, Marker, Pictures, Review, Street, Structural


class LatLongSerializer(serializers.ModelSerializer):

    class Meta:

        model = Coordinate
        fields = ['latitude', 'longitude']


class StrucPointSerializer(serializers.ModelSerializer):

    # point = LatLongSerializer()

    def to_representation(self, value):
        return LatLongSerializer(value.point).data

    class Meta:

        model = Structural
        fields = ['point']
        # depth=1


class Buildingsserializer(serializers.ModelSerializer):

    structural = StrucPointSerializer(many=True, read_only=True)

    class Meta:
        model = Buildings
        fields = ['name', 'structural']
        depth = 1


class CoordinateSerializer(serializers.ModelSerializer):

    class Meta:

        model = Coordinate
        fields = '__all__'


class StructuralSerializer(serializers.ModelSerializer):

    name = Buildings.objects.values('name').distinct()
    point = serializers.PrimaryKeyRelatedField(read_only=True)

    class Meta:
        model = Structural
        fields = ['name', 'point']
        depth = 1


class StreetSerializer(serializers.ModelSerializer):

    start = LatLongSerializer()
    end = LatLongSerializer()

    class Meta:

        model = Street
        fields = ["name", "length", "start", "end"]


class MarkerSerializer(serializers.ModelSerializer):

    class Meta:

        model = Marker
        fields = ["types", "icon","color"]

class PictureReviewSeralizer(serializers.ModelSerializer):

    class Meta:

        model = Pictures
        fields = ["file_name"]


class LoactionPointSerializer(serializers.ModelSerializer):

    point = LatLongSerializer()
    marker = MarkerSerializer()
    location_pic = PictureReviewSeralizer(many=True)
    class Meta:

        model = LocationPoint
        fields = ["p_name", "point", "website", "desciption", "marker","avg_star","no_of_review","location_pic"]
        depth = 1

class UserReviewDataSerializer(serializers.ModelSerializer):

    class Meta:

        model = User
        fields = ["first_name","last_name"]


class LocationDetailSerializer(serializers.ModelSerializer):

    user = UserReviewDataSerializer(read_only=True)
    review_pic = PictureReviewSeralizer(many=True,read_only=True)

    class Meta:

        model = Review
        fields = ["text","total_like","user","review_pic"]
        
class InformationSerializer(serializers.ModelSerializer):



    class Meta:

        model = Information
        fields = ["weekday","openingtime","closingtime"]


class UserSrializer(serializers.ModelSerializer):


    class Meta:

        model = User
        fields = ["username","first_name","last_name","email"]