import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Math;
using Toybox.SensorHistory;
using Toybox.System;

class TimeWidget extends EEWidget {
    
    function initialize(geometry as EEGeometry, depiction as EEDepiction) {
        EEWidget.initialize(geometry, depiction);
    }

    function onUpdate(dc as Dc) as Void {
        self.onStartDrawing(dc);
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$", [clockTime.hour]);
        dc.setColor(Graphics.COLOR_GREEN, self.depiction.backgroundColor);
        dc.drawText(self.posCenterX - 15, self.posCenterY, self.depiction.clockFont, timeString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_RIGHT);
        dc.drawText(self.posCenterX, self.posCenterY, self.depiction.clockFont, ":", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
        timeString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        var minutesWidth = dc.getTextWidthInPixels(timeString, self.depiction.clockFont);
        dc.drawText(self.posCenterX + 15, self.posCenterY, self.depiction.clockFont, timeString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        timeString = Lang.format("$1$", [clockTime.sec.format("%02d")]);
        dc.drawText(self.posCenterX + 15 + minutesWidth, self.drawOffsetY + 18, Graphics.FONT_SMALL, timeString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        self.onFinishDrawing(dc);
    }

}