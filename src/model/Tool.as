package model
{
    import view.PlayerView;

    public class Tool
    {
        public var repairable:Repairable;
        public function Tool(player:PlayerView, repairs:Repairable)
        {
            this.repairable = repairable;
        }
    }
}