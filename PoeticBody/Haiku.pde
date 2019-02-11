class Haiku {

  PImage imag;
  float posX;
  float posY;
  float brigthness;
  float size;

  Haiku (PImage tempImages, float tempPosX, float tempPosY, float tempBrigthness, float tempSize) {
    imag = tempImages;
    posX = tempPosX;
    posY = tempPosY;
    brigthness = tempBrigthness;
    size = tempSize;
  }

  void display () {

    image(imag, posX, posY);
  }
}