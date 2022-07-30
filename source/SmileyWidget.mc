class SmileyWidget extends EEWidget {

    function initialize(geometry as EEGeometry, depiction as EEDepiction) {
        EEWidget.initialize(geometry, depiction);
    }

    function onUpdate(dc as Dc) as Void {
        self.onStartDrawing(dc);
        var penWidth = 5;
        dc.setPenWidth(penWidth);
        dc.setColor(Graphics.COLOR_YELLOW, self.depiction.backgroundColor);
        dc.drawCircle(self.drawOffsetX + self.width / 2, self.drawOffsetY + self.height / 2, self.height / 2 - penWidth);
        dc.drawArc(self.drawOffsetX + self.width / 2, self.drawOffsetY + self.height / 2, self.height / 4, Graphics.ARC_COUNTER_CLOCKWISE, 270 - 60, 270 + 60);
        dc.drawCircle(self.drawOffsetX + self.width * 0.35, self.drawOffsetY + self.height * 0.35, self.height / 15);
        dc.drawCircle(self.drawOffsetX + self.width * 0.65, self.drawOffsetY + self.height * 0.35, self.height / 15);
        self.onFinishDrawing(dc);
    }
        
}