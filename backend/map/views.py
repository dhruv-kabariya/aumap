from math import cos, asin, sqrt, pi

from django.http.response import HttpResponse

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Buildings, Coordinate, LocationPoint, Street, Structural
from .serializers import Buildingsserializer, LatLongSerializer, LoactionPointSerializer, StreetSerializer, StructuralSerializer
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
