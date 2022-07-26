class EEWidget {
    protected var width;
    protected var height;
    protected var absOffsetX;
    protected var absOffsetY;
    protected var posCenterX;
    protected var posCenterY;
    protected var depiction;

    function initialize(geometry as EEGeometry, depiction as EEDepiction) {
        var screenSize = System.getDeviceSettings().screenWidth;
        self.depiction = depiction;
        self.absOffsetX = geometry.offsetXInPercent  * screenSize / 100;
        self.absOffsetY = geometry.offsetYInPercent  * screenSize / 100;
        self.width = geometry.drawSizeXInPercent * screenSize / 100;
        self.height = geometry.drawSizeYInPercent * screenSize / 100;
        self.posCenterX = self.absOffsetX  + self.width / 2;
        self.posCenterY = self.absOffsetY  + self.height / 2;        
    }

    (:debug)
    function drawBorder(dc as Dc){
        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
        dc.drawLine(self.posCenterX, self.posCenterY - 10, self.posCenterX, self.posCenterY + 10);
        dc.drawLine(self.posCenterX - 10, self.posCenterY, self.posCenterX + 10, self.posCenterY);
        dc.drawRectangle(self.absOffsetX, self.absOffsetY, self.width, self.height);
    }

    (:release)
    function drawBorder(dc as Dc){}

}