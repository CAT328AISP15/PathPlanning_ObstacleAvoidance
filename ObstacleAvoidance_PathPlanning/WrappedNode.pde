static class WrappedNode
{
  Cell CellNode;
  
  float GScore;
  float HScore;
  float FScore;
 
  WrappedNode Parent;
 
  ArrayList<WrappedNode> Neighbors = new ArrayList<WrappedNode>();
  
  public WrappedNode(Cell cell)
  {
    CellNode = cell; 
  }
  
  void ResetNode()
  {
    Parent = null;
    GScore = 0;
    HScore = 0; 
  }
  
  void ScoreG()
  {
    GScore = 0;
    
    WrappedNode currentParent = Parent;
   
    while(currentParent != null)
    {
      GScore++;
      currentParent = currentParent.Parent;
    } 
  }
}
