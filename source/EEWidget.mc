class EEWidget {
    protected var width;
    protected var height;
    protected var drawOffsetX;
    protected var drawOffsetY;
    protected var posCenterX;
    protected var posCenterY;
    protected var depiction;
    
    //private var absOffsetX;
    //private var absOffsetY;

    function initialize(geometry as EEGeometry, depiction as EEDepiction) {
        var screenSize = System.getDeviceSettings().screenWidth;
        self.depiction = depiction;
        //self.absOffsetX = geometry.offsetXInPercent  * screenSize / 100;
        //self.absOffsetY = geometry.offsetYInPercent  * screenSize / 100;
        self.drawOffsetX = geometry.offsetXInPercent  * screenSize / 100;
        self.drawOffsetY = geometry.offsetYInPercent  * screenSize / 100;
        self.width = geometry.drawSizeXInPercent * screenSize / 100;
        self.height = geometry.drawSizeYInPercent * screenSize / 100;
        self.posCenterX = self.drawOffsetX  + self.width / 2;
        self.posCenterY = self.drawOffsetY  + self.height / 2;
    }

    (:release)
    function onStartDrawing(dc as Dc){
        dc.setClip(self.drawOffsetX, self.drawOffsetY, self.width, self.height);
        dc.clear();
    }

    (:release)
    function onFinishDrawing(dc as Dc){
        dc.clearClip();
    }

    function fetchData() as Void {}

    function drawBorder(dc as Dc){
        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
        dc.drawRectangle(self.drawOffsetX, self.drawOffsetY, self.width, self.height);
    }

    (:debug)
    function onStartDrawing(dc as Dc){
        dc.setClip(self.drawOffsetX, self.drawOffsetY, self.width, self.height);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
    }

    (:debug)
    function onFinishDrawing(dc as Dc){
        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
        dc.drawLine(self.posCenterX, self.posCenterY - 10, self.posCenterX, self.posCenterY + 10);
        dc.drawLine(self.posCenterX - 10, self.posCenterY, self.posCenterX + 10, self.posCenterY);
        drawBorder(dc);
        dc.clearClip();
    }

}