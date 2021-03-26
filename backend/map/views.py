from django.http import response
from django.http.response import HttpResponse
from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Buildings,Structural
from .serializers import Buildingsserializer,StructuralSerializer
# Create your views here.


def index(request):
    return HttpResponse("Hello From me")

@api_view(['GET'])
def getBuildigs(request):

    data = Buildings.objects.all()
    data = Buildingsserializer(data, many=True).data
    return Response(data)

class StructuralView(APIView):

    def get(self,request):

        

        data = StructuralSerializer(Structural.objects.all(),many=True).data
        return Response(data)
        