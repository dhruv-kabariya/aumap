from django.db import models
from django.db.models import fields
from rest_framework import serializers
from rest_framework.utils import model_meta

from .models import Buildings,Coordinate, LocationPoint, Marker, Street,Structural

class LatLongSerializer(serializers.ModelSerializer):
    
    class Meta:

        model  = Coordinate
        fields = ['latitude','longitude']

class StrucPointSerializer(serializers.ModelSerializer):
    
    # point = LatLongSerializer()

    def to_representation(self, value):
        return LatLongSerializer(value.point).data

    class Meta:

        model  = Structural
        fields = ['point']
        # depth=1

class Buildingsserializer(serializers.ModelSerializer):
    
    structural = StrucPointSerializer(many=True,read_only=True)

    class Meta:
        model = Buildings
        fields = ['name','structural']
        depth=1

class CoordinateSerializer(serializers.ModelSerializer):

    class Meta:

        model  = Coordinate
        fields = '__all__'

class StructuralSerializer(serializers.ModelSerializer):

    name = Buildings.objects.values('name').distinct()
    point = serializers.PrimaryKeyRelatedField(read_only=True)

    class Meta:
        model = Structural
        fields = ['name','point']
        depth = 1


class StreetSerializer(serializers.ModelSerializer):

    start = LatLongSerializer()
    end = LatLongSerializer()

    class Meta:

        model = Street
        fields = ["name","length","start","end"]
        # depth =1


class MarkerSerializer(serializers.ModelSerializer):

    class Meta:

        model = Marker
        fields =  ["types","icon"]

class LoactionPointSerializer(serializers.ModelSerializer):

    point = LatLongSerializer()
    marker = MarkerSerializer()

    class Meta:

        model = LocationPoint
        fields = ["p_name","point","website","desciption","marker"]
        depth  =1
