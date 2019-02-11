void updates(int haiku_start, int haiku_end)
{
  bg= loadImage("bg4.jpg");
  bg.resize(width, height);


  for (int i = 0; i < images.length; i ++ ) {

    images[i] = loadImage( "haiku" + i + ".png");
  }


  for (int i= haiku_start; i< haiku_end; i++) {
    int posX;
    int posY;
    posY= int(random(0, height/4));
    posX = int(random(0, width/4));
    haiku1[i] = new Haiku(images[i], (i - haiku_start)*posX, (i - haiku_start)*posY, 0, 10); // the object haiku has 5 parameters, Haiku( array of images, positionX, positionY, brightness of the images, size)
  }   
  img.loadPixels();

  noStroke();
  fill(255, 255, 255, 100);
  rect(0, 0, width, height);
  for (int i= haiku_start; i< haiku_end; i++) { //here the object is displayed
    haiku1[i].display();
  }

  loadPixels();
  for (int j= 0; j<width*height; j++) { //here the object is displayed
    img.pixels[j] = pixels[j];
  }



  img.updatePixels();

  image(img, 0, 0);
}