package view
{
    import flash.display.Sprite;
    import flash.events.Event;
    import model.Command;

    public class PlayerView extends Sprite
    {
        public var currentCommand:int;
        public var speedFactor:int = 1;
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

        public function PlayerView(color:uint)
        {
            this.graphics.beginFill(color, 1);
            this.graphics.drawRect(0,0,100,100);
            this.graphics.endFill();
            this.addEventListener(Event.ENTER_FRAME, enterFrame_eventHandler);
        }

        private function enterFrame_eventHandler(e:Event):void
        {
            if( (this.currentCommand & (Command.COMMAND_UP | (Command.COMMAND_LEFT & Command.COMMAND_RIGHT) )) != Command.COMMAND_UP )
                this.y -= 0.5*this.speedFactor;
            else if( (this.currentCommand & Command.COMMAND_UP) == Command.COMMAND_UP )
                this.y--*this.speedFactor;
            if( (this.currentCommand & (Command.COMMAND_RIGHT | (Command.COMMAND_UP & Command.COMMAND_DOWN) )) != Command.COMMAND_RIGHT )
                this.x += 0.5*this.speedFactor;
            else if( (this.currentCommand & Command.COMMAND_RIGHT ) == Command.COMMAND_RIGHT )
                this.x++;
            if( (this.currentCommand & (Command.COMMAND_DOWN | (Command.COMMAND_LEFT & Command.COMMAND_RIGHT) )) != Command.COMMAND_DOWN )
                this.y += 0.5*this.speedFactor;
            else if( (this.currentCommand & Command.COMMAND_DOWN ) == Command.COMMAND_DOWN )
                this.y++;
            if( (this.currentCommand & (Command.COMMAND_LEFT | (Command.COMMAND_UP & Command.COMMAND_DOWN) )) != Command.COMMAND_LEFT )
                this.x -= 0.5*this.speedFactor;
            else if( (this.currentCommand & Command.COMMAND_LEFT ) == Command.COMMAND_LEFT )
                this.x--;
        }
    }
}