class CyclingWidget extends EEWidget {
    private var iconFont;

    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, drawSizeYInPercent as Number, iconFont){
        EEWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeXInPercent, drawSizeYInPercent);
        self.iconFont = iconFont;
    }

    function onUpdate(dc as Dc) as Void {
        dc.setClip(self.absOffsetX, self.absOffsetY, self.width, self.height);
        dc.clear();
        var userActivityIterator = UserProfile.getUserActivityHistory();
        var sample = userActivityIterator.next();

        var cycleDistance = 0 ;
        var duration = 0;
        var sessionCount = 0;
        while (sample != null) {   
            if(sample.duration != null){
                System.println("miau");
            }        
            if(sample.type == 2 && sample.distance != null) {
               sessionCount = sessionCount + 1;
               cycleDistance = cycleDistance + sample.distance;
                if(sample.duration != null){
                        duration = duration + sample.duration.value();
               }
            }
            sample = userActivityIterator.next();
        }
        var distanceString = Lang.format("$1$ km", [cycleDistance / 1000 ]);
        var durationString = Lang.format("$1$ min", [duration / 60 ]);
        var sessionCountString = Lang.format("$1$", [sessionCount]);
        dc.setColor(Graphics.COLOR_WHITE, backgroundColor_);
        dc.drawText(self.absOffsetX + 0.2 * self.width, self.posCenterY, self.iconFont, "R", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT); 
        dc.drawText(self.absOffsetX + 0.45 * self.width, self.absOffsetY + 0.25 * self.height, Graphics.FONT_XTINY, distanceString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT); 
        dc.drawText(self.absOffsetX + 0.45 * self.width, self.absOffsetY + 0.75 * self.height, Graphics.FONT_XTINY, durationString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT); 
        dc.drawText(self.absOffsetX, self.posCenterY, Graphics.FONT_XTINY, sessionCountString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT); 
        drawBorder(dc);
        dc.clearClip();
    }
}
