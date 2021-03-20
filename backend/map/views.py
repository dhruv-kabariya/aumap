from django.http.response import HttpResponse
from django.shortcuts import render, render_to_response

# Create your views here.
def index(request):
    return HttpResponse("Hello From me")