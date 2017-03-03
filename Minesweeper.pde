

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>();//ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS] [NUM_COLS];
    for(int row = 0; row < NUM_ROWS; row++)
        for(int col = 0; col < NUM_COLS; col++)
            buttons [row] [col] = new MSButton(row, col);
    //your code to declare and initialize buttons goes here

    
    
    
    setBombs();
}
public void setBombs()
{     
    for(int nI = 0; nI < 89; nI++){
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        for(int i = 0; i < 99; i++){   
            if(!bombs.contains(buttons [row] [col]))
                bombs.add(buttons [row] [col]);    
        }
    }
}

public void draw ()
{
    background(0);
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r=0;r<NUM_ROWS;r++){
        for(int c=0; c<NUM_COLS;c++){
            if(!buttons[r][c].isClicked()==true&&!bombs.contains(buttons[r][c])){
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    for(int r=0; r<NUM_ROWS; r++){
        for(int c=0; c<NUM_COLS; c++){
            if(!buttons[r][c].isClicked()&&bombs.contains(buttons[r][c])){
                buttons[r][c].marked=false;
                buttons[r][c].clicked=true;
                    buttons[10][6].setLabel("Y");
                    buttons[10][7].setLabel("O");
                    buttons[10][8].setLabel("U");
                    buttons[10][10].setLabel("L");
                    buttons[10][11].setLabel("O");
                    buttons[10][12].setLabel("S");
                    buttons[10][13].setLabel("T");
            }
        }
    }
}
public void displayWinningMessage()
{
    buttons[10][6].setLabel(" ");
    buttons[10][7].setLabel("Y");
    buttons[10][8].setLabel("O");
    buttons[10][9].setLabel("U");
    buttons[10][10].setLabel(" ");
    buttons[10][11].setLabel("W");
    buttons[10][12].setLabel("O");
    buttons[10][13].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    
    public void mousePressed () 
    {
        if(mouseButton==LEFT&&!marked)
        {
            clicked = true;
            if(bombs.contains(this)){
                displayLosingMessage();
            }
            else if(countBombs(r,c)>0){
                label=""+countBombs(r,c);
            }
            else{
                if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
                    buttons[r][c-1].mousePressed();
                if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
                    buttons[r][c+1].mousePressed();
                if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
                    buttons[r-1][c].mousePressed();
                if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
                    buttons[r+1][c].mousePressed();
                if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
                    buttons[r-1][c-1].mousePressed();
                if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
                    buttons[r+1][c+1].mousePressed();
                if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
                    buttons[r-1][c+1].mousePressed();
                if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
                    buttons[r+1][c-1].mousePressed();
            }
        }
        if(mouseButton ==RIGHT){
            marked=!marked;
        }
    }
       

        //your code here
    

    public void draw () 
    {    
        if(marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
    
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r >= 0 && c >=0 && r < NUM_ROWS && c < NUM_COLS)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(row+1, col) && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if(isValid(row-1, col) && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if(isValid(row, col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++; 
        if(isValid(row, col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if(isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        if(isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if(isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if(isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        
        return numBombs;
    }
}



