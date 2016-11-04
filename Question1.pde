class Tile
{
  float x,y;
  color tileColour, initColor;
  boolean isShowing;
  boolean matched;

  Tile(float newx, float newy, color colour)
  {
    x = newx;
    y = newy;
    tileColour = colour;
    initColor = color(170);
    matched = false;
  }
}

final int numRows = 4;
final int numCols = 3;
final int tileSize = 100;
final int numTiles = numRows * numCols;
int spacingHor, spacingVer;

//array of tiles
Tile[][] myTiles = new Tile[numRows][numCols];

//Temp place to store tile vals to check matches
int rowNum;
int colNum;

final color[] myColors = 
{
  color(227, 41, 41),   // red
  color(214, 122, 224), // purple
  color(115, 111, 234), // blue
  color(83, 216, 97),   // green
  color(252, 255, 95),  // yellow
  color(211, 133, 15),  // brown
};

//Track which colours have been used (parallel array to myColors)
int[] checkColours = new int[numTiles/2];

int counter = 0;
int numMatches = 0;

boolean gameWon = false;

void setup()
{
  size(600, 600);
  
  spacingHor = (width - numCols*tileSize)/ (numCols + 1);
  spacingVer = (height - numRows*tileSize)/ (numRows + 1);
  
 setupTiles();
    
}

void draw()
{
  background(255);
  for(int i=0; i<numRows; i++)
  {
    for(int j=0; j<numCols; j++)
    {
      drawTile(myTiles[i][j]);
    }
  }
  
  if(gameWon)
  {
    fill(0);
    textSize(36);
    textAlign(CENTER);
    text("YOU WIN!", width/2, height/2);
  }
  
}

void drawTile(Tile drawThis)
{
  if (drawThis.isShowing)
  {
    fill(drawThis.tileColour);
  }
  else
  {
    fill(drawThis.initColor);
  }
  rect(drawThis.x, drawThis.y, tileSize, tileSize);
}

void mousePressed()
{
 if (!gameWon)
 {
   println("if statement");
  for(int i=0; i<numRows; i++)
  {
    for(int j=0; j<numCols; j++)
    {
     if (mouseX <= j*tileSize + (j+1)*spacingHor + tileSize && mouseX >= j*tileSize + (j+1)*spacingHor
     && mouseY <= i*tileSize + (i+1)*spacingVer + tileSize && mouseY >= i*tileSize + (i+1)*spacingVer)
     {

       if (counter == 0)
       {
         rowNum = i;
         colNum = j;
       }
       
       else if (counter == 1)
       {
         if(myTiles[rowNum][colNum].tileColour == myTiles[i][j].tileColour)
         {
           myTiles[rowNum][colNum].matched = true;
           myTiles[i][j].matched = true;
           println("match");
           numMatches ++;
           
           if (numMatches == numTiles/2)
           {
             gameWon = true;
             println("game ending");
           }
         }
       }
       
       else if (counter == 2)
       {
          for (int k =0; k<numRows; k++)
         {
           for (int l=0; l<numCols; l++)
           {
             if (myTiles[k][l].isShowing && !myTiles[k][l].matched)
             {
               myTiles[k][l].isShowing = false;             
             }
           }
          }
         counter = 0;
         rowNum = i;
         colNum = j;
       }
       
       myTiles[i][j].isShowing = true;
       counter ++;
     }
   }
  }
 }
 
 else
 {
    numMatches = 0;
    counter = 0;
    setupTiles();
    gameWon = false;
 }
}

void setupTiles()
{
   for (int i=0; i<checkColours.length; i++)
   {
     checkColours[i] = 0;
   }

  for(int i=0; i<numRows; i++)
  {
    for(int j=0; j<numCols; j++)
    {
      
      boolean found = false; 
      //Initialize with starter values, as these will be changed in while loop below
      int indexNum = 0;
      color colorToSend = myColors[indexNum];
       while (!found)
       {
         indexNum = (int)random(6);
         
         if(checkColours[indexNum] < 2)
         {
           found = true;
           colorToSend = myColors[indexNum];
           checkColours[indexNum] ++;
         }
       }
       
     myTiles[i][j] = new Tile(j*tileSize + (j+1)*spacingHor, i*tileSize + (i+1)*spacingVer, colorToSend);  
     myTiles[i][j].isShowing = false;
    }
  }
}