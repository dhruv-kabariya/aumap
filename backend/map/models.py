from django.core.exceptions import FieldError, ValidationError
from django.db import models
from django.contrib.auth.models import User

from math import cos, asin, sqrt, pi


class Coordinate(models.Model):

    id = models.IntegerField(auto_created=True, primary_key=True)
    latitude = models.FloatField()
    longitude = models.FloatField()
    walkable = models.BooleanField(default=False)

    def __str__(self):
        return str(self.id) + " - " + str(self.latitude) + "-" + str(self.longitude)


class Buildings(models.Model):

    id = models.IntegerField(unique=True, primary_key=True)
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name

class Structural(models.Model):

    # trigger
    def pointValidation(value):
        if(Coordinate.objects.get(id=value).walkable):
            raise ValidationError(('%(value)s point is not walkable'),
                                  params={'value': value},)

    id = models.IntegerField(primary_key=True)
    name = models.ForeignKey(Buildings, on_delete=models.CASCADE,related_name='structural')
    point = models.ForeignKey(
        Coordinate, on_delete=models.CASCADE, validators=[pointValidation])

    def __str__(self):
        return str(self.name) + "-->" + str(self.point)


class Street(models.Model):

    # point trigger
    def pointValidation(value):
        if(not Coordinate.objects.get(id=value).walkable):
            raise ValidationError(('%(value)s point is not walkable'),
                                  params={'value': value},)

    id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=100)
    start = models.ForeignKey(
        Coordinate, on_delete=models.CASCADE, related_name="start", validators=[pointValidation])
    end = models.ForeignKey(
        Coordinate, on_delete=models.CASCADE, related_name="end", validators=[pointValidation])
    length = models.FloatField(blank=True)

    def distance(self):
        p = pi/180
        a = 0.5 - cos((self.end.latitude-self.start.latitude)*p)/2 + cos(self.start.latitude*p) * \
            cos(self.end.latitude*p) * \
            (1-cos((self.end.longitude-self.start.longitude)*p))/2
        return 12742 * asin(sqrt(a))  # in km

    def save(self, *args, **kwargs):
        self.length = self.distance()
        print(args)
        print(kwargs)
        super(Street, self).save(*args, **kwargs)

    # models.ForeignKey("app.Model", , on_delete=models.CASCADE)
    def __str__(self):
        return self.name


class Marker(models.Model):

    id = models.IntegerField(primary_key=True, unique=True)
    types = models.CharField(max_length=10)
    icon = models.CharField(max_length=100)

    def __str__(self):
        return self.types + self.icon


class LocationPoint(models.Model):

    id = models.IntegerField(primary_key=True)
    p_name = models.CharField(max_length=200)
    point = models.ForeignKey(Coordinate, on_delete=models.CASCADE)
    marker = models.ForeignKey(Marker, on_delete=models.CASCADE)
    website = models.URLField(blank=True)
    desciption = models.TextField()

    def __str__(self):
        return self.p_name


class Pictures(models.Model):

    id = models.IntegerField(primary_key=True)
    location = models.ForeignKey(LocationPoint, on_delete=models.CASCADE)
    file_name = models.ImageField(upload_to='locationimage/')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    timestamp = models.DateTimeField(auto_now=True)


class Information(models.Model):

    class Weekdays(models.IntegerChoices):

        Monday = 1
        Tuesday = 2
        Wednesday = 3
        Thruesday = 4
        Friday = 5
        Saturday = 6
        Sunday = 7

    id = models.IntegerField(primary_key=True)
    location = models.ForeignKey(LocationPoint, on_delete=models.CASCADE)
    weekday = models.IntegerField(choices=Weekdays.choices)
    openingtime = models.TimeField()
    closingtime = models.TimeField()
