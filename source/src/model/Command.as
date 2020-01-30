package model
{
    public class Command
    {
        public static const COMMAND_IDLE:int   = 0x0000;
        public static const COMMAND_UP:int     = 0x0001;
        public static const COMMAND_DOWN:int   = 0x0002;
        public static const COMMAND_LEFT:int   = 0x0004;
        public static const COMMAND_RIGHT:int  = 0x0008;
        public static const COMMAND_ACTION:int = 0x0010;
        public static const COMMAND_DROP:int   = 0x0020;

        public function Command()
        {
            
        }
    }
}