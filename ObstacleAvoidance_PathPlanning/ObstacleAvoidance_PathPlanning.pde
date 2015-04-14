Grid grid;
ArrayList<Cell> path;

void setup()
{
   size(352, 352);
   smooth();
   
   grid = new Grid(11, 11, 32);
   GridInstance.Instance = grid;
   
   Cell startingCell = GridInstance.Instance.GetCell(5, 5);
   Cell targetCell = GridInstance.Instance.GetCell(5, 9);
   
   path = Pathfinder.GetPath(startingCell, targetCell);
   
   
   for(int x = 0; x < path.size(); x++)
   {
     path.get(x).IsPathUnWalked = true;
   }
   
   
}

void draw()
{
   grid.render();
}
