#!/usr/bin/python3

from PIL import Image
import os
import argparse
import sys

parser = argparse.ArgumentParser(description="Change image color")
parser.add_argument('-f', type=str, default=None)
parser.add_argument('-o', type=str, default=None)
args = parser.parse_args()

# Cargar la imagen
imagen = Image.open(args.f)

# Crear una copia modificada de la imagen
imagen_modificada = Image.new("RGBA", (imagen.width, imagen.height))

# Obtener los píxeles de la imagen
pixeles = imagen_modificada.load()
pixeles2 = imagen.load()

# Definir el nuevo color (por ejemplo, cambiar negro a azul)
cnew = (1, 168, 199, 255)

# Recorrer todos los píxeles y cambiar el color de las curvas negras
for i in range(imagen_modificada.width):
    for j in range(imagen_modificada.height):
        pixel = pixeles2[i, j]
        # print(pixel)
        if pixel != (255, 255, 255, pixel[3]):  # Negro
            factor = (255-pixel[0])/255
            if factor < 0.2:
                pixeles[i, j] = (255, 255, 255, 50)
                continue
            factor=0
            aux = (int(cnew[0] - factor), int(cnew[1]-factor), int(cnew[2]-factor), pixel[3])
            pixeles[i, j] = aux
        else:
            pixeles[i, j] = (255, 255, 255, 0)

# Guardar la imagen modificada
imagen_modificada.save(args.o)


