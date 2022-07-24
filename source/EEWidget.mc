class EEWidget {
    protected var width;
    protected var height;
    protected var absOffsetX;
    protected var absOffsetY;
    protected var posCenterX;
    protected var posCenterY;
    protected var backgroundColor_ = Graphics.COLOR_TRANSPARENT;

    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, drawSizeYInPercent as Number) {
        var screenSize = System.getDeviceSettings().screenWidth;
        self.absOffsetX = offsetXInPercent  * screenSize / 100;
        self.absOffsetY = offsetYInPercent  * screenSize / 100;
        self.width = drawSizeXInPercent * screenSize / 100;
        self.height = drawSizeYInPercent * screenSize / 100;
        self.posCenterX = self.absOffsetX  + self.width / 2;
        self.posCenterY = self.absOffsetY  + self.height / 2;        
    }

    (:debug)
    function drawBorder(dc as Dc){
        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, backgroundColor_);
        dc.drawLine(self.posCenterX, self.posCenterY - 10, self.posCenterX, self.posCenterY + 10);
        dc.drawLine(self.posCenterX - 10, self.posCenterY, self.posCenterX + 10, self.posCenterY);
        dc.drawRectangle(self.absOffsetX, self.absOffsetY, self.width, self.height);
    }

    (:release)
    function drawBorder(dc as Dc){}

}