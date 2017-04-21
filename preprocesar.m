function newImage = preprocesar(image, mask)

newImage = image;
newImage(~mask) = 255;