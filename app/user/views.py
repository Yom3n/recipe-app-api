from rest_framework import generics

from user.serializers import UserSerializer

class CreateUserView(generics.CreateAPIView):
    """Create a new uesr in the system"""
    serializer_class = UserSerializer
    