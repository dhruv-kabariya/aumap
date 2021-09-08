import base64
from datetime import datetime
from math import cos, asin, e, sqrt, pi
from django.contrib.auth.models import User
from django.core.files.base import ContentFile
from django.contrib.auth import authenticate,login
from django.http import response
from django.http.response import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator


from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny

from .models import Buildings, Coordinate, Information, Like, LocationPoint, Pictures, Review, Street, Structural
from .serializers import Buildingsserializer, InformationSerializer, LatLongSerializer, LoactionPointSerializer, LocationDetailSerializer, StreetSerializer, StructuralSerializer, UserSrializer
# Create your views here.


def index(request):
    return HttpResponse("Hello From me")


@api_view(['GET'])
def getBuildigs(request):

    data = Buildings.objects.all()
    data = Buildingsserializer(data, many=True).data
    return Response(data)

def distance(start,end):
        p = pi/180
        a = 0.5 - cos((end.latitude-start.latitude)*p)/2 + cos(start.latitude*p) * \
            cos(end.latitude*p) * \
            (1-cos((end.longitude-start.longitude)*p))/2
        return 12742 * asin(sqrt(a))  # in km


class StructuralView(APIView):

    def get(self, request):

        data = StructuralSerializer(Structural.objects.all(), many=True).data
        return Response(data)


class StreetView(APIView):

    def get(self, request):

        data = StreetSerializer(Street.objects.all(), many=True).data
        return Response(data)


class LocationPointView(APIView):

    def get(self, request):

        data = LoactionPointSerializer(
            LocationPoint.objects.all(), many=True).data
        return Response(data)


class SearchLocationByName(APIView):

    def get(self, request, location):
        # SELECT * FROM table where LIKE %dhr% IN p_name
        data = LocationPoint.objects.filter(p_name__contains=location)
        data = LoactionPointSerializer(data, many=True).data
        return Response(data)


class FindRoute(APIView):

    
    def get_cor(self,from_cor,check):
        coor = []
        for i in Street.objects.filter(start=from_cor):
            if(i.end not in check  ):
                coor.append(i.end)
        for i in Street.objects.filter(end=from_cor):
            if(i.start not in check):
                coor.append(i.start)
        return coor

    def getRoute(self, start, end):
        final_route = [start]


        reachable = self.get_cor(start,final_route)
        find_or_not = False
        while not find_or_not:
                
            min_d = 10**6
            min_c= None
        

            for i in reachable:
                if(LocationPoint.objects.filter(point = i) ):
                    if( i == end):
                        dis = distance(i,end)
                    else:
                        continue
                else:
                    dis = distance(i,end)

                if(min_d>dis):
                    min_d = dis
                    min_c = i

                if(min_c == end):
                    find_or_not = True
                

            final_route.append(min_c)
            reachable = self.get_cor(min_c,final_route)
        
        return final_route

    def get(self, request, start, end):

        start = LocationPoint.objects.get(p_name=start)
        
        end = LocationPoint.objects.get(p_name=end)

        route = self.getRoute(start.point,end.point)
        return Response(LatLongSerializer(route,many=True).data)

class LocationDetail(APIView):

    def get(self,request,location):
        
        data = Review.objects.filter(location=location)
        data = LocationDetailSerializer(data,many=True).data

        return Response(data)

    def post(self,request,location):

        location_id=  location
        data = request.data
        # print(data)
        review = Review.objects.create(
            text = data.get("text"),
            location = LocationPoint.objects.get(id=location_id),
            star =data.get("star"),
            user = User.objects.get(username= data.get("user"))
        )
        review.save()
        
        if("review_pic" in data):
            image = data["review_pic"]
            for im in image:
                im = im["file_name"]
                name = review.user.username +"_"+review.location.p_name
                # print(image)
                if(';base64,' in im):
                    format, imgstr = im.split(';base64,')

                    ext = format.split('/')[-1]
                dataImage = ContentFile(base64.b64decode(
                    im), name=name + str(datetime.now())+".jpeg")
                
                photo = Pictures(
                    file_name = dataImage,
                    user = User.objects.get(username= data.get("user")),
                    review = review,
                    location = LocationPoint.objects.get(id=location_id)
                )

                photo.save()

        j_data = LocationDetailSerializer(review).data

        return Response(j_data)

@method_decorator(csrf_exempt,name="dispatch")
class LikeView(APIView):

    permission_classes = [AllowAny,]
    def get(self,request):
        return Response(
             status=204
        )

    def post(self,request,review):

        user = User.objects.get(username=request.data.get("user"))

        try:
            like = Like.objects.get(
            user = user,
            review = Review.objects.get(
                id=review
            )
            )
            like.delete()

        except :

            like = Like.objects.create(
                user = user,
                review = Review.objects.get(
                    id=review
                )
            )

            like.save()

        return Response(
            status=204
        )

@method_decorator(csrf_exempt,name="dispatch")
class LikeCheckView(APIView):
    
    def post(self,request,review):
        user = User.objects.get(username=request.data.get("user"))
        try:
            like = Like.objects.get(
            user = user,
            review = Review.objects.get(
                id=review
            )
            )
            if(like ):
                return Response(
                    status=204
                )
            else:
                return Response(
                status=203
            )

        except :

            return Response(
                status=203
            )

class InformationView(APIView):

    def get(self,request,location_id):
        # print(Information.objects.filter(location = location_id))
        data = Information.objects.filter(location = location_id)
     
        today_wday = datetime.now().weekday() + 1
        status_raw = Information.objects.get(weekday=today_wday,location = location_id)
        status = False
        if(datetime.now().time()  >= status_raw.openingtime  and datetime.now().time() <= status_raw.closingtime ):
            status = True

        
        data = InformationSerializer(data,many=True).data
        data = {
            "status":status,
            "data" : data
        }

        return Response(data)


@method_decorator(csrf_exempt,name="dispatch")
class Login(APIView):
    
    permission_classes = [AllowAny,]
    
    
    def post(self,request):
        username = request.data['username']
        password = request.data['password']
        user = authenticate(request, username=username, password=password)
        print(user)
        if user != None:
            login(request, user)
            data = UserSrializer(User.objects.get(username = username)).data
            return Response(data)
        else:
            
            return Response(
                
                {
                    "status":False,
                    "error" : "Invalid User Name or Password"
                }
            )

@method_decorator(csrf_exempt,name='dispatch')
class SignUp(APIView):
    permission_classes = [AllowAny,]

    def post(self,request):
        username = request.data['username']
        password = request.data['password']
        first_name = request.data['first_name']
        last_name = request.data['last_name']
        email = request.data['email']
        
        user = User.objects.create_user(
            username = username,
            first_name = first_name,
            last_name=last_name,
            email =email,
            password = password

        )
        user.save()
        data = UserSrializer(user).data
        return Response(
            data
        )