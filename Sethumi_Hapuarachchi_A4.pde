/*
 Sethumi Hapuarachchi
 December 6, 2023
 ICS-3U1
 This is a program of the game Space Invaders 
*/

// miscellaneous variables
int gameState = 0; // controls what screen the user is on
boolean userWinsGame = false; // this checks if the user wins the game
int numberOfPoints = 0; // this is the total number of points the user gained from hitting the aliens and UFO 

// image variables
PImage menuScreenImage; // the image on the main screen
PImage userWinsGameImage; // image if user wins
PImage userLosesGameImage; // image if user loses
PImage backgroundImage; // background image
PImage pauseScreenBanner; // image on the pause screen 

// tank variables
int tankXPosition = 500; // tank's x position
boolean tankMovingLeft = false; // these two variables help control tank movement so it is smooth
boolean tankMovingRight = false;

// alien variables
int[] alienXPosition = {60, 130, 200, 270, 340, 410, 480, 550, 620, 690, 760, 60, 130, 200, 270, 340, 410, 480, 550, 620, 690, 760, 60, 130, 200, 270, 340, 410, 480, 550, 620, 690, 760, 60, 130, 200, 270, 340, 410, 480, 550, 620, 690, 760, 60, 130, 200, 270, 340, 410, 480, 550, 620, 690, 760, 60, 130, 200, 270, 340, 410, 480, 550, 620, 690, 760}; // tracks aliens x positions
int[] alienYPosition = {50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 130, 130, 130, 130, 130, 130, 130, 130, 130, 130, 130, 210, 210, 210, 210, 210, 210, 210, 210, 210, 210, 210, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 370, 370, 370, 370, 370, 370, 370, 370, 370, 370, 370}; // tracks aliens y positions
color[] alienColour = {#FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FFFF00, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF0000, #FF00FF, #FF00FF, #FF00FF, #FF00FF, #FF00FF, #FF00FF, #FF00FF, #FF00FF, #FF00FF, #FF00FF, #FF00FF, #00FFFF, #00FFFF, #00FFFF, #00FFFF, #00FFFF, #00FFFF, #00FFFF, #00FFFF, #00FFFF, #00FFFF, #00FFFF, #00FF00, #00FF00, #00FF00, #00FF00, #00FF00, #00FF00, #00FF00, #00FF00, #00FF00, #00FF00, #00FF00,}; // tracks colour of alien
int[] numberOfHits = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}; // tracks how many hits an alien needs to die
int timeOfLastAlienMovement = 0; // tracks when the aliens last moved
int alienXSpeed = 20; // the speed and direction aliens go in
int numAliens = 55; // the total number of aliens
int numOfDeadAliens = 0; // number of dead aliens
boolean[] alienHitByLaser = new boolean[numAliens]; // this is a boolean tracking if they have been hit by the laser. They all starts off false
boolean aliensAreAtRightEdge = false; // tracks whether the aliens are touching the right edge
boolean aliensAreAtLeftEdge = false; // tracks whether the aliens are touching the left edge
boolean aliensReachedBottom = false; // tracks whether the aliens reached the bottom
int alienAnimationState = 0; // animation state of the aliens

// ufo variables 
int ufoXPosition = 0; // tracks the ufo x position 
boolean ufoHitByLaser = false; // tracks whether the ufo was hit  
boolean ufoOnScreen = false; // tracks whether the ufo is on the screen 
int timeOfLastUFOAppearance = 0; // tracks the time when the ufo appears and disappears

// laser variables
int laserXPosition; // tracks the laser's x position, isn't assigned a value for now since the player would not have shot anything yet
int laserYPosition = 760; // tracks the laser's y position, is currently set as the tanks y position
boolean laserOnScreen = false; // checks whether the laser is on screen, and therefore if the user can shoot a laser

// main methods
void setup() // formatting + importing images 
{
  size(1000, 800);
  textAlign(CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  menuScreenImage = loadImage("MenuScreenPicture.jpg");
  menuScreenImage.resize(500, 300);
  userWinsGameImage = loadImage("userWinsGame.jpg");
  userWinsGameImage.resize(500, 500);
  userLosesGameImage = loadImage("userLosesGame.jpg");
  userLosesGameImage.resize(500, 500);
  backgroundImage = loadImage("galaxyBackground.jpg");
  backgroundImage.resize(1000, 800);
  pauseScreenBanner = loadImage("pauseScreenBanner.jpg");
  pauseScreenBanner.resize(1000, 400);
}

void draw() // does the brunt of the program
{
  switch(gameState) // this switchcase looks as what value game state is, and then will know what it is supposed to do
  {
    case 0:
      generateMenuScreen(); // generates the menu screen
      break;
    case 1:
      generateInstructionsScreen(); // generates instructions screen
      break;
    case 2:
      generateGame(); // generates game
      break;
    case 3:
      generatePauseScreen(); // generates pause screen
      break;
    case 4:
      generateEndScreen(); // generate end screen
      break;
  }
}

void generateMenuScreen() 
{
  background(#000000);
  textSize(100);
  strokeWeight(1);
  fill(#FFFFFF);
  text("Space Invaders", 500, 150);
  image(menuScreenImage, width/2, 350); // photo
  
  // aliens at the bottom
  drawAlienArmsDown(300, 550, #00FF00);
  drawAlienArmsUp(400, 550, #00FFFF);
  drawAlienArmsDown(500, 550, #FF00FF);
  drawAlienArmsUp(600, 550, #FF0000);
  drawAlienArmsDown(700, 550, #FFFF00);

  // instructions button
  stroke(#FFFFFF);
  fill(#000000);
  rect(200, 650, 200, 100);
  textSize(35);
  fill(#FFFFFF);
  text("Instructions", 200, 660);

  // play button
  stroke(#FFFFFF);
  fill(#000000);
  rect(800, 650, 200, 100);
  textSize(35);
  fill(#FFFFFF);
  text("Play", 800, 660);
}

void generateInstructionsScreen()
{
  background(#000000);
  fill(#FFFFFF);
  textSize(30);
  
  // instructions
  text("This is a game of Space Invaders!", 500, 100);
  text("Your goal is to shoot down all of the aliens", 500, 150);
  text("Press left and right to move the tank, and spacebar to shoot a laser", 500, 200);
  text("If the aliens get right above you, you lose", 500, 250);
  text("There are five types of aliens", 500, 300);
  text("Green ones need to be shot once, blue ones twice, pink ones three times, \nred ones four times, and yellow ones five times", 500, 350);
  text("Every alien is worth one point when you kill them", 500, 450);
  text("There is also a UFO that passes by; it is worth 5 points when shot", 500, 500);
  text("Press 'p' to pause the game, and 'r' to reset", 500, 550);

  // aliens at the bottom
  drawAlienArmsDown(300, 750, #00FF00);
  drawAlienArmsUp(400, 750, #00FFFF);
  drawAlienArmsDown(500, 750, #FF00FF);
  drawAlienArmsUp(600, 750, #FF0000);
  drawAlienArmsDown(700, 750, #FFFF00);

  // back to menu button
  stroke(#FFFFFF);
  fill(#000000);
  rect(200, 650, 200, 100);
  textSize(35);
  fill(#FFFFFF);
  text("Back", 200, 660);
}

void generateGame()
{
  image(backgroundImage, width/2, height/2); // space background
  moveTank(); // controls how the tank moves
  
  // moving the aliens 
  drawAllAliens(); // draws the aliens
  moveAliens(); // moves the aliens
  checkLaserAndAlienCollision(); // checks whether the laser hit an alien
  
  // moving the UFO
  if (millis() - timeOfLastUFOAppearance > 10000 && !ufoOnScreen) // if it has been more than 10 seconds and the ufo isn't currently on the screen
  {
    ufoXPosition = 0; // x position is set to 0
    ufoOnScreen = true; // the condition is set to true
    timeOfLastUFOAppearance = millis(); // the variable is set to the current time to avoid the UFO returning to to the left edge
  }
  if (ufoOnScreen) // if the ufo is on the screen
  {
    moveUFO(); // the ufo is moved
  }
  checkLaserAndUFOCollision(); // checks whether the laser hit the UFO
  
  if (laserOnScreen) // if the laser is on the screen
  {
    moveLaser(); // it will move the laser
  } 
  checkWhoIsWinning(); // checks if the win or lose conditions were met
  textSize(20);
  fill(#FFFFFF);
  text(numberOfPoints, 975, 50); // writes the number of points in the corner
}

void generatePauseScreen() 
{
  background(#000000);
  image(pauseScreenBanner, width/2, 50);
  fill(#FFFFFF);
  textSize(100);
  text("Game is paused", width/2, 400);
  
  // aliens at the bottom
  drawAlienArmsDown(300, 500, #00FF00);
  drawAlienArmsUp(400, 500, #00FFFF);
  drawAlienArmsDown(500, 500, #FF00FF);
  drawAlienArmsUp(600, 500, #FF0000);
  drawAlienArmsDown(700, 500, #FFFF00);

  // back to game button button
  stroke(#FFFFFF);
  fill(#000000);
  rect(200, 650, 200, 100);
  textSize(35);
  fill(#FFFFFF);
  text("Back", 200, 660);
}

void generateEndScreen()
{
  strokeWeight(1);
  
  if (userWinsGame) // if the user shot down all aliens (the user won)
  {
    background(#000000);
    image(userWinsGameImage, width/2, 250);
    fill(#FFFFFF);
    // winning message
    textSize(40);
    text("You Win!", width/2, 550);
    text("You shot down all the aliens!", width/2, 600);
    text("You got " + numberOfPoints + " points", width/2, 650);
  }
  
  else // if the aliens reached the bottom (the user lost)
  {
    background(#000000);
    image(userLosesGameImage, width/2, 250);
    textSize(40);
    // losing message
    text("You Lose!", width/2, 550);
    text("You shot down " + numOfDeadAliens + " aliens", width/2, 600);
    text("You got " + numberOfPoints + " points", width/2, 650);
  }
  
  // play again button
  textSize(40);
  stroke(#FFFFFF);
  fill(#000000);
  rect(width/2, 725, 200, 100);
  fill(#FFFFFF);
  text("Play Again", width/2, 735);
}

void resetVariables() // this method is to be called when the user wants to reset in the middle of the game so the variables are put back into their original states
{
  userWinsGame = false;
  numberOfPoints = 0; 
    
  tankXPosition = 500;
  tankMovingLeft = false;
  tankMovingRight = false;
  
  // i have to do the arrays in a loop since I can't reset an array all at once 
  for (int j = 0; j < 5; j++) // this is how many rows of aliens there are
  {
    for (int i = 0; i < 11; i++) // and how many aliens there are in a row 
    {
      alienXPosition[i+(j*11)] = 60+70*i;
      alienYPosition[i+(j*11)] = 60+j*80;
      alienHitByLaser[i+(j*11)] = false;
      numberOfHits[i+(j*11)] = 5-j;
    }
  }
  
  timeOfLastAlienMovement = 0;
  alienXSpeed = 20;
  numOfDeadAliens = 0; 
  aliensAreAtRightEdge = false;
  aliensAreAtLeftEdge = false;
  aliensReachedBottom = false;
  alienAnimationState = 0;
  
  ufoXPosition = 0; 
  ufoHitByLaser = false;
  ufoOnScreen = false;
  timeOfLastUFOAppearance = 0;
  
  laserYPosition = 760;
  laserOnScreen = false;
}

void mousePressed() // for pressing buttons on the menu, instructions screen, paused screen, and end screen
{
  if (gameState == 0) // if the user is on the menu screen
  {
    // pressing instructions button
    if (mouseX > 100 && mouseX < 300 && mouseY > 600 && mouseY < 700)
    {
      gameState = 1; // goes to the instructions screen
    }

    // pressing play button
    if (mouseX > 700 && mouseX < 900 && mouseY > 600 && mouseY < 700)
    {
      gameState = 2; // goes to the game
      timeOfLastAlienMovement = millis(); // tracks the time that the game started, makes sure the aliens move properly
      timeOfLastUFOAppearance = millis(); // same applies to the UFO
    }
  }
  
  else if (gameState == 1) // if the user is on the instructions screen
  {
    // pressing back to menu button
    if (mouseX > 100 && mouseX < 300 && mouseY > 600 && mouseY < 700)
    {
      gameState = 0; // switches to the menu
    }
  } 
  
  else if (gameState == 3) // if the user is on the pause game screen
  {
    // pressing back button to go back to game
    if (mouseX > 100 && mouseX < 300 && mouseY > 600 && mouseY < 700)
    {
      gameState = 2; // goes back to game
      timeOfLastAlienMovement = millis(); // tracks the time that the user went back, makes sure the aliens move properly
      timeOfLastUFOAppearance = millis(); // same applies to UFO
    }
  }
  
  else if (gameState == 4) // if the user is on the end game screen
  {
    // pressing restart
    if (mouseX > 400 && mouseX < 600 && mouseY > 675 && mouseY < 775)
    {
      gameState = 0; // it switches back to the menu screen 
      resetVariables(); // it resets the variables 
    }
  }
}

void keyPressed() // used when moving the tank, shooting the laser, and pausing and resetting the game
{
  if (gameState == 2) // if the player is in the game 
  {
    if (keyCode == 80 || keyCode == 112) // if the user presses p (pause)
    {
      gameState = 3; // the game goes to the pause screen
    }
    else if (keyCode == 82 || keyCode == 114) // if the user presses r (reset)
    {
      gameState = 0; // the game goes back to the menu
      resetVariables(); // resets the variables
    } 
    
    if (keyCode == 37) // if the user presses the left key
    {
      tankMovingLeft = true; // the program knows the user wants to go to the left
    } 
    if (keyCode == 39) // if the user presses the right key
    {
      tankMovingRight = true; // the program knows the user wants to go to the right
    }

    if (keyCode == 32 && !laserOnScreen) // if the user is pressing the space bar and the laser isn't on the screen
    {
      laserXPosition = tankXPosition; // this will make sure it shoots from where the tank shot it from
      laserOnScreen = true; // the laser is now on the screen 
    }
  }
}

void keyReleased() // for the tank movement
{
  if (gameState == 2) // if the player is on the game
  {
    if (keyCode == 37) // if the user lets go of the left arrow
    {
      tankMovingLeft = false; // this boolean becomes false
    }
    if (keyCode == 39) // similarily if the right arrow isn't pressed
    {
      tankMovingRight = false; // this boolean becomes false
    }
  }
}

// sub methods
void drawTank() // draws the still image of the tank  
{
  fill(#00FF00);
  stroke(#00FF00);
  strokeWeight(1);
  rect(tankXPosition, 790, 45, 20);
  rect(tankXPosition, 780, 30, 15);
  rect(tankXPosition, 780, 10, 25);
  rect(tankXPosition, 775, 4, 30);
}

void moveTank() 
{
  drawTank(); // first draws the still image
  if (tankMovingLeft) // if the user wants to go left
  {
    tankXPosition-=5; // it changes the x position by -5
  }
  if (tankMovingRight) // if the user wants to go right
  {
    tankXPosition+=5; // it changes the x position by 5
  }

  // checking if it hits the edges, and if it does, it changes the x position
  if (tankXPosition < 20) // if it his the left edge
  {
    tankXPosition+=5;
  } 
  else if (tankXPosition > 980) // if it hits the right edge
  {
    tankXPosition-=5; 
  }
}

void drawAllAliens()
{
  for (int i = 0; i < numAliens; i++) // this loop appears in many of the methods. This loops for how many aliens there are
  {
    if (!alienHitByLaser[i]) // if the alien has not been hit by the laser 
    {
      drawAlien(alienXPosition[i], alienYPosition[i], alienColour[i]); // it will draw the alien
    }
  }
}

void drawAlien(int xPos, int yPos, int alienColour) // this is where the animation states are changed as well as where they are drawn, origin: middle of alien
{
  if (alienAnimationState == 0) // if animation state is 0 
  {
    drawAlienArmsDown(xPos, yPos, alienColour); // the arms are down
  }
  else if (alienAnimationState == 1) // if animation state is 1
  {
    drawAlienArmsUp(xPos, yPos, alienColour); // arms are up
  }
}

void moveAliens() 
{
  if (millis() - timeOfLastAlienMovement > 1000) // if it has been more than one second since they last moved 
  {
    alienAnimationState = (alienAnimationState + 1)%2; // the alien's animation state is changed 
    moveAliensHorizontally(); // all of the aliens are moved horizantally
    checkAlienEdges(); // then it checks if any aliens are near the edges 
    timeOfLastAlienMovement = millis(); // so the computer remembers when the aliens last moved
  }
}

void checkAlienEdges() 
{
  for (int i = 0; i < numAliens; i++) // checking for all aliens
  {
    if (alienXPosition[i] >= 940 && !alienHitByLaser[i]) // if an alien is near the right edge and wasn't shot down
    {
      aliensAreAtRightEdge = true; // the program knows the aliens are too close to the edge
    }
  }
  for (int i = 0; i < numAliens; i++)
  {
    if (alienXPosition[i] <= 60 && !alienHitByLaser[i]) // similarily, if an alien is near the left edge and wasn't shot down
    {
      aliensAreAtLeftEdge = true; // the program knows the aliens are too close to the edge
    }
  }
 
  if (aliensAreAtRightEdge) // if the aliens are near the right edge
  {
    moveAliensDown(); // they are moved down
    reverseDirection(-1); // they reverse their direction (in this case they have to go left)
    moveAliensHorizontally(); // then they move horizantally
    aliensAreAtRightEdge = false; // the boolean indicating they are at the right is deactivated
  }

  // if the aliens are too much to the left, the same principle applies
  else if (aliensAreAtLeftEdge)
  {
    moveAliensDown();
    reverseDirection(1); // this time, it makes sure the aliens go to the right
    moveAliensHorizontally();
    aliensAreAtLeftEdge = false;
  }
}

void reverseDirection(int direction) // this changes the direction that the aliens go in, direction is either positive or negative (positive = to the right, negative = to the left)
{
  alienXSpeed = direction*abs(alienXSpeed); 
}

void moveAliensDown() 
{
  for (int i = 0; i < numAliens; i++)
  {
    alienYPosition[i] = alienYPosition[i] + 30; // the aliens are moved down
  }
}

void moveAliensHorizontally() 
{
  for (int i = 0; i < numAliens; i++)
  {
    alienXPosition[i]+=alienXSpeed; // the alien's x position is changed
  }
}

void moveUFO()
{
  if (ufoXPosition > 1000 && ufoOnScreen) // if the alien is at the right edge and it is on the screen
  {
    ufoOnScreen = false; // this boolean is false
    timeOfLastUFOAppearance = millis(); // the computer stores this information so it will wait ten seconds next time
  }
  else 
  {
    drawUFO(ufoXPosition, 60);
    ufoXPosition+=2; // changes the ufo x position
  }
}

void drawLaser() // draws the still image of the laser
{
  strokeWeight(5);
  stroke(#FFFFFF);
  line(laserXPosition, laserYPosition, laserXPosition, laserYPosition - 20);
}

void moveLaser() // moves the laser
{
  drawLaser(); // draws the still image of the laser
  if (laserYPosition > 10) // if the laser is still on the screen
  {
    laserYPosition-=10; // then it moves upwards
  } 
  else // once it is off the screen
  {
    laserOnScreen = false;
    laserYPosition = 760; // resetting the laser's y position so it starts from the right place
  }
}

void checkLaserAndAlienCollision() 
{
  for (int i = 0; i < numAliens; i++)
  {
    // the conditions that check whether the laser is touching the alien
    boolean laserPastLeftOfAlien = laserXPosition > alienXPosition[i] - 30;
    boolean laserBehindRightOfAlien = laserXPosition < alienXPosition[i] + 30;
    boolean laserPastTopOfAlien = laserYPosition - 10 > alienYPosition[i] - 20;
    boolean laserPastBottomOfAlien = laserYPosition - 10 < alienYPosition[i] + 15;
    
    if (laserPastLeftOfAlien && laserBehindRightOfAlien && laserPastTopOfAlien && laserPastBottomOfAlien && !alienHitByLaser[i]) // if the laser is touching the alien and wasn't shot down 
    {
      laserOnScreen = false; // the boolean turns off
      laserYPosition = 760; // the laser's y position is reset
      numberOfHits[i]-=1; // the number of hits is decreased by 1
      if (numberOfHits[i] == 0) // if number of hits for that alien reaches 0 (it has to equal zero in order to make sure the player doesn't accidentally earn new points if it hits it again)
      {
        alienHitByLaser[i] = true; // the program knows that alien has been hit
        numberOfPoints++; // the number of points increases by 1
      }
    }
  }
}

void checkLaserAndUFOCollision()
{
  // conditions that the laser is touching the ufo
  boolean laserPastLeftOfUFO = laserXPosition > ufoXPosition - 35;
  boolean laserBehindRightOfUFO = laserXPosition < ufoXPosition + 35;
  boolean laserUnderTopOfUFO = laserYPosition - 10 > 45;
  boolean laserPastBottomOfUFO = laserYPosition - 10 < 75;
  
  if (laserPastLeftOfUFO && laserBehindRightOfUFO && laserUnderTopOfUFO && laserPastBottomOfUFO) // if the laser touches the UFO
  {
    ufoXPosition = 1100; // the ufo X position is switched to be larger than 1000 so it doesn't do anything
    laserOnScreen = false; // the two booleans switch to false
    ufoOnScreen = false; // the ufo is taken off the screen
    timeOfLastUFOAppearance = millis(); // the computer stores the time
    numberOfPoints+=5; // the number of points increases by 5
  }
}

void checkWhoIsWinning()
{
  // checking if the user won
  numOfDeadAliens = 0; // the number of dead aliens is set to 0
    
  for (int i = 0; i < numAliens; i++) // this loop checks how many aliens are dead 
  {
    if (alienHitByLaser[i] == true) // if the alien was hit by the laser
    {
      numOfDeadAliens++; // the number of dead aliens increases
    }
  }
  
  if (numOfDeadAliens >= numAliens) // if all the aliens were shot down
  {
    userWinsGame = true; // the program knows the user won the game
    gameState = 4; // the program switches to the end screen 
  }
  
  // checking if the aliens won
  for (int i = 0; i < numAliens; i++)
  {
    if (alienYPosition[i] >= 700 && !alienHitByLaser[i]) // if an alien is at the bottom and wasn't hit by the laser
    {
      aliensReachedBottom = true; // the program knows the aliens reached the bottom
    }
  }
  
  if (aliensReachedBottom) // if the aliens reached the bottom
  {
    userWinsGame = false; // the program knows aliens won
    gameState = 4; // the program switches to the end screen
  }
}


// drawing methods 
void drawAlienArmsDown(int xPos, int yPos, color alienColour) // origin: the middle of the alien
{
  drawPixel(xPos, yPos, alienColour); // square of reference of aliens position

  for (int i = 0; i < 2; i++)
  {
    drawPixel((xPos-25)+i*50, yPos, alienColour);
    drawPixel((xPos-25)+i*50, yPos + 5, alienColour);
    drawPixel((xPos-25)+i*50, yPos + 10, alienColour);
  }

  drawPixel(xPos - 20, yPos, alienColour);
  drawPixel(xPos - 20, yPos - 5, alienColour);
  drawPixel(xPos + 20, yPos, alienColour);
  drawPixel(xPos + 20, yPos - 5, alienColour);

  for (int i = 0; i < 4; i++)
  {
    drawPixel((xPos - 15), (yPos - 5)+i*5, alienColour);
  }

  for (int i = 0; i < 7; i++)
  {
    drawPixel((xPos - 15)+i*5, yPos - 10, alienColour);
  }

  drawPixel(xPos - 5, yPos - 5, alienColour);
  drawPixel(xPos, yPos - 5, alienColour);
  drawPixel(xPos + 5, yPos - 5, alienColour);
  drawPixel(xPos + 15, yPos - 5, alienColour);

  for (int i = 0; i < 7; i++)
  {
    drawPixel((xPos - 15)+i*5, yPos, alienColour);
  }

  for (int i = 0; i < 7; i++)
  {
    drawPixel((xPos - 15)+i*5, yPos + 5, alienColour);
  }

  drawPixel(xPos - 10, yPos + 15, alienColour);
  drawPixel(xPos - 5, yPos + 15, alienColour);
  drawPixel(xPos + 5, yPos + 15, alienColour);
  drawPixel(xPos + 10, yPos + 15, alienColour);
  drawPixel(xPos + 15, yPos + 10, alienColour);

  drawPixel(xPos - 15, yPos - 15, alienColour);
  drawPixel(xPos - 20, yPos - 20, alienColour);
  drawPixel(xPos + 15, yPos - 15, alienColour);
  drawPixel(xPos + 20, yPos - 20, alienColour);
}

void drawAlienArmsUp(int xPos, int yPos, color alienColour) // origin: middle of alien
{
  drawPixel(xPos, yPos, alienColour); // square of reference of aliens position

  for (int i = 0; i < 2; i++)
  {
    drawPixel((xPos-25)+i*50, yPos, alienColour);
    drawPixel((xPos-25)+i*50, yPos - 5, alienColour);
    drawPixel((xPos-25)+i*50, yPos - 10, alienColour);
  }

  drawPixel(xPos - 20, yPos, alienColour);
  drawPixel(xPos - 20, yPos - 5, alienColour);
  drawPixel(xPos + 20, yPos, alienColour);
  drawPixel(xPos + 20, yPos - 5, alienColour);

  for (int i = 0; i < 4; i++)
  {
    drawPixel((xPos - 15), (yPos - 5)+i*5, alienColour);
  }

  for (int i = 0; i < 7; i++)
  {
    drawPixel((xPos - 15)+i*5, yPos - 10, alienColour);
  }

  drawPixel(xPos - 5, yPos - 5, alienColour);
  drawPixel(xPos, yPos - 5, alienColour);
  drawPixel(xPos + 5, yPos - 5, alienColour);
  drawPixel(xPos + 15, yPos - 5, alienColour);

  for (int i = 0; i < 7; i++)
  {
    drawPixel((xPos - 15)+i*5, yPos, alienColour);
  }

  for (int i = 0; i < 7; i++)
  {
    drawPixel((xPos - 15)+i*5, yPos + 5, alienColour);
  }

  drawPixel(xPos - 20, yPos + 15, alienColour);
  drawPixel(xPos + 20, yPos + 15, alienColour);
  drawPixel(xPos + 15, yPos + 10, alienColour);

  drawPixel(xPos - 15, yPos - 15, alienColour);
  drawPixel(xPos - 20, yPos - 20, alienColour);
  drawPixel(xPos + 15, yPos - 15, alienColour);
  drawPixel(xPos + 20, yPos - 20, alienColour);
}

void drawUFO(int xPos, int yPos) // origin: middle window
{
  drawPixel(xPos, yPos, #000000); // ufo point of reference
  
  for (int i = 0; i < 5; i++)
  {
    drawPixel((xPos - 10)+i*5, yPos - 15, #A500FF); 
  }
  for (int i = 0; i < 9; i++)
  {
    drawPixel((xPos - 20)+i*5, yPos - 10, #A500FF);
  }
  for (int i = 0; i < 11; i++)
  {
    drawPixel((xPos - 25)+i*5, yPos - 5, #A500FF);
  }
  
  drawPixel(xPos - 30, yPos, #A500FF);
  for (int i = 0; i < 6; i++)
  {
    drawPixel((xPos - 25)+i*10, yPos, #A500FF);
  }
  drawPixel(xPos + 30, yPos, #A500FF);
  
  for (int i = 0; i < 15; i++)
  {
    drawPixel((xPos - 35)+i*5, yPos + 5, #A500FF);
  }
  for (int i = 0; i < 3; i++)
  {
    drawPixel((xPos - 25)+i*20, yPos + 10, #A500FF);
    drawPixel((xPos - 20)+i*20, yPos + 10, #A500FF);
    drawPixel((xPos - 15)+i*20, yPos + 10, #A500FF);
  }
  drawPixel((xPos - 20), yPos + 15, #A500FF);
  drawPixel((xPos + 20), yPos + 15, #A500FF);
}

void drawPixel(int xPos, int yPos, color colour) // this method is used when drawing the aliens and ufo, origin: top left of square  
{
  fill(colour);
  stroke(colour);
  strokeWeight(1);
  beginShape();
  vertex(xPos, yPos);
  vertex(xPos + 5, yPos);
  vertex(xPos + 5, yPos + 5);
  vertex(xPos, yPos + 5);
  vertex(xPos, yPos);
  endShape();
}
