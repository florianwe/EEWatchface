class SmileyWidget extends EEWidget {

    var variant = 0;
    var currentColor = Graphics.COLOR_YELLOW;
    var colorArray = [Graphics.COLOR_BLUE, Graphics.COLOR_YELLOW, Graphics.COLOR_GREEN, Graphics.COLOR_RED, Graphics.COLOR_ORANGE];

    function initialize(geometry as EEGeometry, depiction as EEDepiction) {
        EEWidget.initialize(geometry, depiction);
    }

    function fetchData() as Void {
        self.variant = Math.rand() % 2;
        self.currentColor = self.colorArray[Math.rand() % self.colorArray.size()];
    }

    function onUpdate(dc as Dc) as Void {
        self.onStartDrawing(dc);
        switch(self.variant){
            case 0:
                self.drawDesign1(dc);
                break;
            case 1:
                self.drawDesign2(dc);
                break;
            default:
                self.drawDesign1(dc);
                break;
        }
        self.onFinishDrawing(dc);
    }


    function drawDesign1(dc as Dc) as Void{
        var penWidth = 5;
        dc.setPenWidth(penWidth);
        dc.setColor(self.currentColor, self.depiction.backgroundColor);
        dc.drawCircle(self.drawOffsetX + self.width / 2, self.drawOffsetY + self.height / 2, self.height / 2 - penWidth);
        dc.drawArc(self.drawOffsetX + self.width / 2, self.drawOffsetY + self.height / 2, self.height / 4, Graphics.ARC_COUNTER_CLOCKWISE, 270 - 60, 270 + 60);
        dc.drawCircle(self.drawOffsetX + self.width * 0.35, self.drawOffsetY + self.height * 0.35, self.height / 15);
        dc.drawCircle(self.drawOffsetX + self.width * 0.65, self.drawOffsetY + self.height * 0.35, self.height / 15);
    }

    function drawDesign2(dc as Dc) as Void{
        var penWidth = 5;
        dc.setPenWidth(penWidth);
        dc.setColor(self.currentColor, self.depiction.backgroundColor);
        dc.fillCircle(self.drawOffsetX + self.width / 2, self.drawOffsetY + self.height / 2, self.height / 2 - penWidth);
        dc.setColor(Graphics.COLOR_BLACK, self.depiction.backgroundColor);
        dc.drawArc(self.drawOffsetX + self.width / 2, self.drawOffsetY + self.height / 2, self.height / 4, Graphics.ARC_COUNTER_CLOCKWISE, 270 - 60, 270 + 60);
        dc.drawCircle(self.drawOffsetX + self.width * 0.35, self.drawOffsetY + self.height * 0.35, self.height / 15);
        dc.drawCircle(self.drawOffsetX + self.width * 0.65, self.drawOffsetY + self.height * 0.35, self.height / 15);
    }
        
}