package view
{
    import flash.display.Sprite;
    import flash.events.Event;
    import model.Command;

    public class PlayerView extends Sprite
    {
        public var currentCommand:int;
        public function execute(action:int):int {
            var status:int = 0; // status = 0 -> successful.
            this.currentCommand |= action;
            return status;
        }

        public function unexecute(action:int):int {
            var status:int = 0;
            // must remove that flag. ^= might work;
            this.currentCommand ^= action;
            return status;
        }

        public function PlayerView()
        {
            this.graphics.beginFill(0xff0000, 1);
            this.graphics.drawRect(0,0,100,100);
            this.graphics.endFill();
            this.addEventListener(Event.ENTER_FRAME, enterFrame_eventHandler);
        }

        private function enterFrame_eventHandler(e:Event):void
        {
            if( (this.currentCommand & Command.COMMAND_UP) == Command.COMMAND_UP )
                this.y--;
            if( (this.currentCommand & Command.COMMAND_RIGHT ) == Command.COMMAND_RIGHT )
                this.x++;
            if( (this.currentCommand & Command.COMMAND_DOWN ) == Command.COMMAND_DOWN )
                this.y++;
            if( (this.currentCommand & Command.COMMAND_LEFT ) == Command.COMMAND_LEFT )
                this.x--;
        }
    }
}