import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.System;

class StatusWidget extends EEWidget {
    private var iconFont;

    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, drawSizeYInPercent as Number, iconFont) {
        EEWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeXInPercent, drawSizeYInPercent);
        self.iconFont = iconFont;
    }

    function onUpdate(dc as Dc) as Void {
        dc.setClip(self.absOffsetX, self.absOffsetY, self.width, self.height);
        dc.clear();
        var statusString = "";
        if(System.getDeviceSettings().connectionAvailable){
            statusString = statusString + "D ";
        }
        dc.setColor(Graphics.COLOR_WHITE, backgroundColor_);
        dc.drawText(self.posCenterX, self.posCenterY, self.iconFont, statusString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);  
        self.drawBorder(dc);
        dc.clearClip();
    }
        
}