import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.SensorHistory;
using Toybox.System;

class SecondsWidget extends EEWidget {

    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, drawSizeYInPercent as Number) {
        EEWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeXInPercent, drawSizeYInPercent);
    }

    function onUpdate(dc as Dc) as Void {
        dc.setClip(self.absOffsetX, self.absOffsetY, self.width, self.height);
        dc.clear();
        var clockTime = System.getClockTime();
        var secondsString = Lang.format("$1$", [clockTime.sec]);
        dc.setColor(Graphics.COLOR_WHITE, backgroundColor_);
        dc.drawText(self.posCenterX, self.posCenterY, Graphics.FONT_XTINY, secondsString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);  
        self.drawBorder(dc);
        dc.clearClip();
    }
        
}