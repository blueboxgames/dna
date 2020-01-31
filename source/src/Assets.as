package
{
    public class Assets
    {
        [Embed(source = "../assets/bolts.png")] public static const Bolts:Class;
        [Embed(source = "../assets/tv/item1.png")] public static const TV1:Class;
        [Embed(source = "../assets/tv/item2.png")] public static const TV2:Class;
        [Embed(source = "../assets/fan/itam1.png")] public static const FAN1:Class;
        [Embed(source = "../assets/fan/itam2.png")] public static const FAN2:Class;
        [Embed(source = "../assets/car/wheel.png")] public static const CAR1:Class;
        public function Assets()
        {
        }
    }
}