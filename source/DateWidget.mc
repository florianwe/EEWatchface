import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.SensorHistory;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

class DateWidget extends EEWidget {

    function initialize(geometry as EEGeometry, depiction as EEDepiction) {
        EEWidget.initialize(geometry, depiction);
    }

    function onUpdate(dc as Dc) as Void {
        self.onStartDrawing(dc);
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$ $2$ $3$", [today.day, today.month,today.year]);
        dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
        dc.drawText(self.posCenterX, self.posCenterY, Graphics.FONT_XTINY, dateString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);  
        self.onFinishDrawing(dc);
    }
        
}