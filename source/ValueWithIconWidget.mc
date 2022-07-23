class AltitudeWidget extends ValueWithIconWidget{
    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, iconFont){
        ValueWithIconWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeXInPercent, iconFont, "A");
    }

    function onUpdate(dc as Dc) as Void {
        var altitude = Activity.getActivityInfo().altitude;
        if(altitude == null){
            ValueWithIconWidget.onUpdate(dc, "--");
        }else{
            var altitudeString = Lang.format("$1$", [altitude.format("%d")]);
            ValueWithIconWidget.onUpdate(dc, altitudeString);
        }
    }
}

class CaloriesWidget extends ValueWithIconWidget{
    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, iconFont){
        ValueWithIconWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeXInPercent, iconFont, "C");
    }

    function onUpdate(dc as Dc) as Void {
        var activityInfo = Toybox.ActivityMonitor.getInfo();
        if(activityInfo.calories == null){
            ValueWithIconWidget.onUpdate(dc, "--");
        }else{
            var caloriesString = Lang.format("$1$", [activityInfo.calories]);
            ValueWithIconWidget.onUpdate(dc, caloriesString);
        }
    }
}


class HeartRateWidget extends ValueWithIconWidget{
    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, iconFont){
        ValueWithIconWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeXInPercent, iconFont, "H");
    }

    function onUpdate(dc as Dc) as Void {
        var heartRate = Activity.getActivityInfo().currentHeartRate;
        if(heartRate == null){
            ValueWithIconWidget.onUpdate(dc, "--");
        } else {
            var heartRateString = Lang.format("$1$", [heartRate]);
            ValueWithIconWidget.onUpdate(dc, heartRateString);
        }
    }
}

class ValueWithIconWidget {
    private var myFont;
    private var backgroundColor_ = Graphics.COLOR_TRANSPARENT;
    private var posCenterX;
    private var posCenterY;
    private var width;
    private var height;
    private var absOffsetX;
    private var absOffsetY;
    private var posValueStart;
    private var iconChar;
    private var iconFont;

    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, iconFont, iconChar as String) {
        var deviceSettings = System.getDeviceSettings();
        var screenSize = deviceSettings.screenWidth;
        self.absOffsetX = offsetXInPercent  * screenSize / 100;
        self.absOffsetY = offsetYInPercent  * screenSize / 100;
        self.width =  drawSizeXInPercent * screenSize / 100;
        self.height = 10 * screenSize / 100;
        self.posValueStart = self.absOffsetX + 8 * screenSize / 100;
        self.posCenterY = self.absOffsetY  + self.height / 2;  
        self.iconChar = iconChar;     
        self.iconFont = iconFont; 
    }

    function onUpdate(dc as Dc, valueString as String) as Void {
        dc.setClip(self.absOffsetX, self.absOffsetY, self.width, self.height);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, self.backgroundColor_);
        dc.drawText(self.absOffsetX, self.posCenterY, self.iconFont, self.iconChar, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(self.posValueStart, self.posCenterY, Graphics.FONT_XTINY, valueString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
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
    function drawBorder(dc as Dc){}
     
}