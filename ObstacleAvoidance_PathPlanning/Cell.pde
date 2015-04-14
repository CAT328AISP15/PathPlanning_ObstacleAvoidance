public class Cell
{
  int CellX;
  int CellY;
  
  PVector Position;
  
  int CellSize;

  Boolean IsWalkable;

  Boolean IsGrass = false;
  Boolean IsPathUnWalked = false;
  Boolean IsPathWalked = false;
  Boolean IsWall = false;
  
  color GrassColor = #00CC00;
  color PathUnWalkedColor = #FF9966;
  color PathWalkedColor = #FF0000;
  color WallColor = #660033;
 
  Cell(int x, int y, int size)
  {
    CellX = x;
    CellY = y;
    CellSize = size; 
    
    Position = new PVector(CellX, CellY);
  }
  
  void render()
  {
    if(IsGrass)
    {
      fill(GrassColor);
    }
    
    if(IsPathUnWalked)
    {
      fill(PathUnWalkedColor);
    }
    
    if(IsWall)
    {
      fill(WallColor); 
    }
    
    rect(Position.x, Position.y, CellSize, CellSize);
  }
  
  PVector GetRelativePosition(PVector position)
  {
    PVector offset = PVector.sub(Position, position);
    offset.div(CellSize);
    
    return offset;
  }
}
