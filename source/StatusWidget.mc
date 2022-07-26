import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.System;

class StatusWidget extends EEWidget {

    function initialize(geometry as EEGeometry, depiction as EEDepiction) {
        EEWidget.initialize(geometry, depiction);
    }

    function onUpdate(dc as Dc) as Void {
        dc.setClip(self.absOffsetX, self.absOffsetY, self.width, self.height);
        dc.clear();
        var statusString = "";
        if(System.getDeviceSettings().connectionAvailable){
            statusString = statusString + "D ";
        }
        dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
        dc.drawText(self.posCenterX, self.posCenterY, self.depiction.iconFont, statusString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);  
        self.drawBorder(dc);
        dc.clearClip();
    }

}