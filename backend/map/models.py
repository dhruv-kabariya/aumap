from os import name
from django.db import models
from django.db.models.fields import IntegerField

# Create your models here.

class Coordinate(models.Model):
    
    lang = models.FloatField()
    lat = models.FloatField()
    id = models.CharField(max_length=256,primary_key=True,unique=True)
    walkable=  models.BooleanField(default=False)

    def __str__(self):
        return str(self.lang) + "-" + str(self.lat)


class Buildings(models.Model):

    name = models.CharField(max_length=50)
    key = models.CharField(max_length=10,unique=True,null=False,default="0000")
    id = models.IntegerField(unique=True,primary_key=True)

    def __str__(self):
        return self.name + "-->" + str(self.key)

class Structural(models.Model):

    name = models.ForeignKey(Buildings,on_delete=models.CASCADE)
    id = IntegerField(unique=True,primary_key=True)
    point = models.ForeignKey(Coordinate,on_delete=models.CASCADE)

    def __str__(self) :
        return str(self.name) + "-->" + str(self.point)

class Street(models.Model):

    name = models.CharField(max_length=100)
    # models.ForeignKey("app.Model", , on_delete=models.CASCADE)
    start = models.ForeignKey(Coordinate,on_delete=models.CASCADE,related_name="start")
    end = models.ForeignKey(Coordinate,on_delete=models.CASCADE,related_name="end")
    id = models.IntegerField(primary_key=True)

    def __str__(self) :
        return self.name     

class LocationPoint(models.Model):

    id = models.IntegerField(primary_key=True)
    p_name=  models.CharField(max_length=200)
    point = models.ForeignKey(Coordinate,on_delete=models.CASCADE)

    def __str__(self) :
        return self.p_name 




