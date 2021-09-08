from re import S
from django.core.exceptions import FieldError, ValidationError
from django.db import models
from django.contrib.auth.models import User

from math import cos, asin, sqrt, pi


class Coordinate(models.Model):

    id = models.AutoField(auto_created=True, primary_key=True)
    latitude = models.FloatField()
    longitude = models.FloatField()
    walkable = models.BooleanField(default=False)

    def __str__(self):
        return str(self.id) + " - " + str(self.latitude) + "-" + str(self.longitude)


class Marker(models.Model):

    id = models.AutoField(primary_key=True, unique=True)
    types = models.CharField(max_length=10)
    icon = models.CharField(max_length=100)
    color = models.CharField(max_length=50,default="grey")

    def __str__(self):
        return self.types + " " + self.icon


class Buildings(models.Model):

    id = models.AutoField(unique=True, primary_key=True)
    name = models.CharField(max_length=50)
    marker = models.ForeignKey(
        Marker,on_delete=models.CASCADE
        ,
        blank=True,null=True
    )

    def __str__(self):
        return self.name


class Structural(models.Model):

    # trigger
    def pointValidation(value):
        if(Coordinate.objects.get(id=value).walkable):
            raise ValidationError(('%(value)s point is not walkable'),
                                  params={'value': value},)

    id = models.AutoField(primary_key=True)
    name = models.ForeignKey(
        Buildings, on_delete=models.CASCADE, related_name='structural')
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

    id = models.AutoField(primary_key=True)
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



class LocationPoint(models.Model):

    id = models.AutoField(primary_key=True)
    p_name = models.CharField(max_length=200)
    point = models.ForeignKey(Coordinate, on_delete=models.CASCADE)
    marker = models.ForeignKey(Marker, on_delete=models.CASCADE)
    website = models.URLField(blank=True)
    desciption = models.TextField(blank=True)
    phone = models.IntegerField(blank=True,null=True)
    avg_star = models.FloatField(default=0)
    no_of_review = models.IntegerField(default=0)

    def __str__(self):
        return self.p_name

class Review(models.Model):

    def checkLike(value):
    
        #trigger
        if(value<1):
            raise ValidationError(('Stars cannot be less than 1'),
                                  params={'value': value},)
        
        #trigger
        if(value>5):
            raise ValidationError(('Stars cannot be greater than 1'),
                                  params={'value': value},)

    #trigger
    def calAvgStar(self,location_id,star_now):
        loc = LocationPoint.objects.get(id = location_id)
        old_avg = loc.avg_star * loc.no_of_review + star_now
        new_avg = old_avg/(loc.no_of_review + 1)
        loc.no_of_review +=1
        loc.avg_star = new_avg
        loc.save() 
        
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    text = models.TextField()
    star = models.IntegerField(validators=[checkLike])
    timestamp = models.DateTimeField(auto_created=True,auto_now=True)
    location = models.ForeignKey(LocationPoint,on_delete=models.CASCADE)
    total_like = models.IntegerField(default=0)


    def save(self,*args,**kwargs) :
        
        self.calAvgStar(self.location.id,self.star)
        
        return super(Review,self).save(*args,**kwargs)




class Pictures(models.Model):

    id = models.AutoField(primary_key=True)
    location = models.ForeignKey(LocationPoint,null=True, on_delete=models.CASCADE,blank=True,related_name="location_pic")
    file_name = models.ImageField(upload_to='locationimage/')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    timestamp = models.DateTimeField(auto_now=True)
    review = models.ForeignKey(Review,blank=True,null=True,on_delete=models.CASCADE,related_name="review_pic")


class Information(models.Model):

    class Weekdays(models.IntegerChoices):

        Monday = 1
        Tuesday = 2
        Wednesday = 3
        Thruesday = 4
        Friday = 5
        Saturday = 6
        Sunday = 7

    id = models.AutoField(primary_key=True)
    location = models.ForeignKey(LocationPoint, on_delete=models.CASCADE)
    weekday = models.IntegerField(choices=Weekdays.choices)
    openingtime = models.TimeField()
    closingtime = models.TimeField()


    def __str__(self) :
        return str(self.location) + " " + str(self.weekday)



class Like(models.Model):

    def addLike(self,review_id):
        re = Review.objects.get(id= review_id)
        re.total_like +=1
        re.save()



    def deleteLike(self,review_id):
        re = Review.objects.get(id= review_id)
        re.total_like -=1
        re.save()
    

    id = models.AutoField(primary_key=True)
    review = models.ForeignKey(Review,on_delete=models.CASCADE)
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    timestamp = models.DateTimeField(auto_now=True)

    def save(self,*args,**kwargs) :
        
        self.addLike(self.review.id)
        
        return super(Like,self).save(*args,**kwargs)


    def delete(self, *args,**kwargs):
        
        self.deleteLike(self.review.id)
        return super(Like,self).delete(*args,**kwargs)