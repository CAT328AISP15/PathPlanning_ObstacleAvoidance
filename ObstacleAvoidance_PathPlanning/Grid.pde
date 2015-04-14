public class Grid
{
  Cell[][] Cells;
  
  int GridWidth;
  int GridHeight;
  int CellSize; 
  
  public Grid(int gWidth, int gHeight, int cSize)
  {
    GridWidth = gWidth;
    GridHeight = gHeight;
    CellSize = cSize;
    
    Cells = new Cell[GridWidth][GridHeight];
    
    CreateGrid();
  }
  
  void CreateGrid()
  {
    for(int x = 0; x < GridWidth; x++)
    {
      for(int y = 0; y < GridHeight; y++)
      {
        Cell cell = new Cell(x * CellSize, y * CellSize, CellSize);
        
        //These are walls
        if(x == 3 && y == 2 ||
            x == 3 && y == 3 ||
            x == 7 && y == 2 ||
            x == 7 && y == 3 ||
            x == 3 && y == 7 ||
            x == 4 && y == 7 ||
            x == 5 && y == 7 ||
            x == 6 && y == 7 ||
            x == 7 && y == 7)
          cell.IsWall = true;
        else
          cell.IsGrass = true;
          
        Cells[x][y] = cell;
      }
    }
  }
  
  Cell GetNearestCell(int worldX, int worldY)
  {
    worldX /= CellSize;
    worldY /= CellSize;
   
    int xCell = (int)floor(worldX);
    int yCell = (int)floor(worldY);
   
    return GetCell(xCell, yCell); 
  }
  
  //This is not cell at world coordinate but cell at matrix 
  Cell GetCell(int x, int y)
  {
    if(x < 0 || y < 0 || x > GridWidth || y > GridHeight) return null;
   
    return Cells[x][y]; 
  }
  
  void render()
  {
    for(int x = 0; x < GridWidth; x++)
    {
      for(int y = 0; y < GridHeight; y++)
      {
        Cells[x][y].render(); 
      }
    } 
  }
}
