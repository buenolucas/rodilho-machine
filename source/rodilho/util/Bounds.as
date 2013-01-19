package rodilho.util {

    import flash.display.DisplayObject;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Matrix;
    public class Bounds
    {
        public static function getVisibleBounds(source:DisplayObject):Rectangle
        {
            // Updated 11-18-2010;
            // Thanks to Mark in the comments for this addition;
            var matrix:Matrix = new Matrix()
            matrix.tx = -source.getBounds(null).x;
            matrix.ty = -source.getBounds(null).y;

            var data:BitmapData = new BitmapData(source.width, source.height, true, 0x00000000);
            data.draw(source, matrix);
            var bounds : Rectangle = data.getColorBoundsRect(0xFFFFFFFF, 0x000000, false);
            data.dispose();
            return bounds;
        }
    }
}
