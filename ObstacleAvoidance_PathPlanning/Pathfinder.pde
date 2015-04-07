static class Pathfinder
{
  static WrappedNode[][] ActiveGridWrapper;
 
  public static ArrayList<Cell> GetPath(Cell from, Cell to)
  {
    
    if(GridInstance.Instance == null) return null; //Cannot pathfind without a active grid
    
    if(ActiveGridWrapper == null)
    {
      ActiveGridWrapper = new WrappedNode[GridInstance.Instance.GridWidth][GridInstance.Instance.GridHeight];
     
      //Iteratiing through the grid creating a new double array but instead of just
      //Cells, it will contained a instance of WrappedNode that takes in the 
      //cell in that position
      for(int i = 0; i < GridInstance.Instance.GridWidth; i++)
      {
        for(int j = 0; j < GridInstance.Instance.GridHeight; j++)
        {
          Cell c = GridInstance.Instance.GetCell(i, j);
         
          WrappedNode node = new WrappedNode(c);
          ActiveGridWrapper[i][j] = node; 
        }
      }
      
      for(int i = 0; i < GridInstance.Instance.GridWidth; i++)
      {
        for(int j = 0; j < GridInstance.Instance.GridHeight; j++)
        {
          WrappedNode node = ActiveGridWrapper[i][j];
          
          if(i > 0) //Getting Left Neighbor
            node.Neighbors.add(ActiveGridWrapper[i - 1][j]);
          if(j > 0) //Getting Down Neighbor
            node.Neighbors.add(ActiveGridWrapper[i][j - 1]);
          if(i < GridInstance.Instance.GridWidth - 1) //Getting Right Neighbor
            node.Neighbors.add(ActiveGridWrapper[i + 1][j]);
          if(j < GridInstance.Instance.GridHeight - 1) //Getting Up Neighbor 
            node.Neighbors.add(ActiveGridWrapper[i][j + 1]);
        } 
      }
      
    }
    
    //Resetting Each Node Just to be safe before actually trying to pathfind.
    for(int i = 0; i < GridInstance.Instance.GridWidth; i++)
    {
      for(int j = 0; j < GridInstance.Instance.GridHeight; j++)
      {
        ActiveGridWrapper[i][j].ResetNode();
      } 
    }
    
    // 1) Add the starting square (or node) to the open list
    ArrayList<WrappedNode> openList = new ArrayList<WrappedNode>();
    ArrayList<WrappedNode> closedList = new ArrayList<WrappedNode>();
    
    openList.add(ActiveGridWrapper[from.CellX / 32][from.CellY / 32]);
    
    //2) Repeat the following:
    while(true)
    {
      //a) Look for the lowest F cost square on the open list. We refer to this
      // as the current square.
      WrappedNode current = null;
     
      for(WrappedNode node : openList)
      {
        if(current == null || node.FScore < current.FScore)
          current = node;
      }
      
      // b) Switch the current node to the closed list.
      closedList.add(current);
      openList.remove(current);
      
      //For each of the 4 squares adjacent to this current square
      for(WrappedNode neighbor : current.Neighbors)
      {
        //If it is not walkable or if it is on the closed list, ignore it. Otherwise do the following
        if(closedList.contains(neighbor)) continue;
        
        if(neighbor.CellNode.IsWall) continue;
        
        WrappedNode oldParent = neighbor.Parent;
        float oldGScore = neighbor.GScore;
        
        //If it isn't on the open list, add it to the open list.
        openList.add(neighbor);
        
        //Make the current square the parent of this square.
        //Record the F, G, and H cost of the square
        
        neighbor.Parent = current;
        neighbor.ScoreG();
        neighbor.HScore = neighbor.CellNode.GetRelativePosition(to.Position).magSq();
        
        //If it is on the open list already, check to see if this path to that square is better,
        //using G cost as the measure. A lower G cost means that this is a better path. If so,
        //change the parent of the square to the current square, and recalculate the G and F scores of
        //the square. If you are keeping your open list sorted by F Score, you may need to resort
        //the list to account for the change
        
        if(oldParent != null && oldGScore < neighbor.GScore)
        {
          neighbor.Parent = oldParent;
          neighbor.ScoreG(); 
        }
      }
      
      //Add the target square to the closed list, in which case the path has been found.
      if(current.CellNode == to)
      {
        //3) Save the path. Working backwards from the target square, go from each square to its parent
        //square until you reach the starting square. That is your path.
      
        ArrayList<Cell> path = new ArrayList<Cell>();
        
        while(current != null)
        {
          path.add(0, current.CellNode);
          current = current.Parent;
        }
        
        return path;
      }
      
      //Fail to find the target square, and the open list is empty. In this case there is not path.
      if(openList.size() == 0)
      {
        return null; 
      }
    }
  } 
}
