import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Math;
using Toybox.SensorHistory;
using Toybox.System;

class TimeWidget extends EEWidget {
    private var clockFont;
    
    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, drawSizeYInPercent as Number) {
        EEWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeXInPercent, drawSizeYInPercent);
        self.clockFont = WatchUi.loadResource(Rez.Fonts.ClockFont);
    }

    function onUpdate(dc as Dc) as Void {
        dc.setClip(self.absOffsetX, self.absOffsetY, self.width, self.height);
        dc.clear();
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$", [clockTime.hour]);
        dc.setColor(Graphics.COLOR_GREEN, backgroundColor_);
        dc.drawText(self.posCenterX - 15, self.posCenterY, self.clockFont, timeString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_RIGHT);
        dc.drawText(self.posCenterX, self.posCenterY, self.clockFont, ":", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_WHITE, backgroundColor_);
        timeString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        var minutesWidth = dc.getTextWidthInPixels(timeString, self.clockFont);
        dc.drawText(self.posCenterX + 15, self.posCenterY, self.clockFont, timeString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        timeString = Lang.format("$1$", [clockTime.sec.format("%02d")]);
        dc.drawText(self.posCenterX + 15 + minutesWidth, self.absOffsetY + 18, Graphics.FONT_SMALL, timeString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        self.drawBorder(dc);
        dc.clearClip();
    }

}