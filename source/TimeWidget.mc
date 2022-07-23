import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Math;
using Toybox.SensorHistory;
using Toybox.System;



class TimeWidget {
    private var myFont;
    private var backgroundColor_ = Graphics.COLOR_BLACK;
    private var posCenterX;
    private var posCenterY;
    private var width;
    private var height;
    private var absOffsetX;
    private var absOffsetY;

    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, drawSizeYInPercent as Number) {
        var deviceSettings = System.getDeviceSettings();
        var screenSize = deviceSettings.screenWidth;
        self.absOffsetX = offsetXInPercent  * screenSize / 100;
        self.absOffsetY = offsetYInPercent  * screenSize / 100;
        self.width = drawSizeXInPercent * screenSize / 100;
        self.height = drawSizeYInPercent * screenSize / 100;
        self.posCenterX = self.absOffsetX  + self.width / 2;
        self.posCenterY = self.absOffsetY  + self.height / 2;        
        self.myFont = WatchUi.loadResource(Rez.Fonts.testFont1);    
    }

    function onUpdate(dc as Dc) as Void {
        dc.setClip(self.absOffsetX, self.absOffsetY, self.width, self.height);
        dc.clear();
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        dc.setColor(Graphics.COLOR_GREEN, backgroundColor_);
        dc.drawText(self.posCenterX,self.posCenterY, self.myFont,timeString,Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);  
        self.drawBorder(dc);
        dc.clearClip();
    }

    (:debug)
    function drawBorder(dc as Dc){
        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, backgroundColor_);
        dc.drawRectangle(self.absOffsetX, self.absOffsetY, self.width, self.height);
    }

    (:release)
    function drawBorder(dc as Dc){
    }
}