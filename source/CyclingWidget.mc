class CyclingWidget extends EEWidget {
    private var cycleDistance = 0 ;
    private var duration = 0;
    private var sessionCount = 0;


    function initialize(geometry as EEGeometry, depiction as EEDepiction){
        EEWidget.initialize(geometry, depiction);
    }

    function fetchData() as Void {
        var userActivityIterator = UserProfile.getUserActivityHistory();
        var sample = userActivityIterator.next();

        self.cycleDistance = 0 ;
        self.duration = 0;
        self.sessionCount = 0;
        while (sample != null) {    
            if(sample.type == 2 && sample.distance != null) {
               self.sessionCount++;
               self.cycleDistance += sample.distance;
                if(sample.duration != null){
                        self.duration += sample.duration.value();
                }
            }
            sample = userActivityIterator.next();
        }

    }

    function onUpdate(dc as Dc) as Void {
        self.onStartDrawing(dc);
        var distanceString = Lang.format("$1$ km", [cycleDistance / 1000 ]);
        var durationString = Lang.format("$1$ min", [duration / 60 ]);
        var sessionCountString = Lang.format("$1$", [sessionCount]);
        dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
        dc.drawText(self.drawOffsetX + 0.2 * self.width, self.posCenterY, self.depiction.iconFont, "R", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT); 
        dc.drawText(self.drawOffsetX + 0.45 * self.width, self.drawOffsetY + 0.25 * self.height, Graphics.FONT_XTINY, distanceString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT); 
        dc.drawText(self.drawOffsetX + 0.45 * self.width, self.drawOffsetY + 0.75 * self.height, Graphics.FONT_XTINY, durationString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT); 
        dc.drawText(self.drawOffsetX, self.posCenterY, Graphics.FONT_XTINY, sessionCountString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT); 
        self.onFinishDrawing(dc);
    }
}
