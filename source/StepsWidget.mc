class StepsWidget extends EEWidget {

    function initialize(geometry as EEGeometry, depiction as EEDepiction) {
        EEWidget.initialize(geometry, depiction);
    }

    function onUpdate(dc as Dc) as Void {
        self.onStartDrawing(dc);
        var steps = Toybox.ActivityMonitor.getInfo().steps;
        var stepsString = Lang.format("$1$", [steps]);
        dc.setColor(Graphics.COLOR_GREEN, self.depiction.backgroundColor);
        dc.drawText(self.drawOffsetX, self.posCenterY, self.depiction.smallTextFont, stepsString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);  
        self.onFinishDrawing(dc);
    }
        
}