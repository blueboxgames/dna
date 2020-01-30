package utils
{
    public class CoreUtils
    {
        public function CoreUtils()
        {
            
        }

        public static function getDistance(x1:int, x2:int, y1:int, y2:int):Number
        {
            return Math.sqrt( (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) );
        }
    }
}