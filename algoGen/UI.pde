void setUi() {
  
  
  //UI
  cp5 = new ControlP5(this);
  
  
  //global control
  
  Group GLOBAL = cp5.addGroup("GLOBAL")
             .setPosition(20, 20);
             
  cp5.addSlider("size", 1, 15, size, 0, 5, sliderLength, 10)
             .setGroup(GLOBAL);
             
  cp5.addSlider("opacity", 0, 255, opacity, 0, 20, sliderLength, 10)
             .setGroup(GLOBAL);
             
  cp5.addSlider("popSize", 300, 50000, popSize, 0, 35, sliderLength, 10)
             .setGroup(GLOBAL);
             
  //global control
  
  Group DIST = cp5.addGroup("DISTORTION")
             .setPosition(580, 20);           
             
  cp5.addSlider("distortion", 0, 100, distortion, 0, 5, sliderLength, 10)
             .setGroup(DIST);
             
  cp5.addSlider("noiseDistortion", 0, 100, noiseDistortion, 0, 20, sliderLength, 10)
             .setGroup(DIST);
             
  cp5.addSlider("noiseRatio", 0.1, 2, noiseRatio, 0, 35, sliderLength, 10)
             .setGroup(DIST);
             
  cp5.addSlider("noiseSpeed", 0.1, 2, noiseSpeed, 0, 50, sliderLength, 10)
             .setGroup(DIST);
             
  //obstacle control
  
  Group OBS = cp5.addGroup("OBSTACLES")
             .setPosition(300, 20);
             
  cp5.addSlider("nbObs", 20, 500, nbObs, 0, 5, sliderLength, 10)
             .setGroup(OBS);
             
  cp5.addSlider("sizeRangeX", 5, 200, sizeRangeX, 0, 20, sliderLength, 10)
             .setGroup(OBS);
   
  cp5.addSlider("sizeRangeY", 5, 200, sizeRangeY, 0, 35, sliderLength, 10)
             .setGroup(OBS);
             
    //color control
  
  Group COLOR = cp5.addGroup("COLOR")
             .setPosition(20, 100);
             
  cp5.addSlider("h", 0, 255, h, 0, 5, sliderLength, 10)
             .setGroup(COLOR);
             
  cp5.addSlider("offSat", 0, 255, offSat, 0, 20, sliderLength, 10)
             .setGroup(COLOR);
}
