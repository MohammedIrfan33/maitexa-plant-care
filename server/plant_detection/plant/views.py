from django.shortcuts import render
from django.shortcuts import render
from django.conf import settings
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView
from .models import testing
from .serializers import PlantDetectionSerializer
import io

from django.http import JsonResponse
from keras.models import load_model
from PIL import Image, ImageOps
import numpy as np

# Create your views here.
class PlantDetectionSerializerAPIView(GenericAPIView):
    serializer_class = PlantDetectionSerializer

    def post(self, request):
        # Load the model
        model = load_model("keras_model.h5", compile=False)

        # Load the labels
        class_names = open("labels.txt", "r").readlines()

        # Create the array of the right shape to feed into the keras model
        # The 'length' or number of images you can put into the array is
        # determined by the first position in the shape tuple, in this case 1
        data = np.ndarray(shape=(1, 224, 224, 3), dtype=np.float32)

        # Get the image from the request
        image = Image.open(request.FILES['image']).convert("RGB")

        # resizing the image to be at least 224x224 and then cropping from the center
        size = (224, 224)
        image = ImageOps.fit(image, size, Image.Resampling.LANCZOS)

        # turn the image into a numpy array
        image_array = np.asarray(image)

        # Normalize the image
        normalized_image_array = (image_array.astype(np.float32) / 127.5) - 1

        # Load the image into the array
        data[0] = normalized_image_array

        # Predict the model
        prediction = model.predict(data)
        index = np.argmax(prediction)
        class_name = class_names[index]
        confidence_score = prediction[0][index]

        # Return the prediction result as JSON
        response_data = {
            'class_name': class_name[2:],
            'confidence_score': confidence_score
        }
        return Response({'data':response_data,'message':'Plant Disease Detected successfully', 'success':True}, status = status.HTTP_201_CREATED)

   