import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Math;
using Toybox.SensorHistory;
using Toybox.System;

class TriCycleWidget {
    private var backgroundColor_ = Graphics.COLOR_BLACK;
    private var arcStartAngle_ = 270;
    private var penSize;
    private var width;
    private var height;
    private var absOffsetX;
    private var absOffsetY;
    private var posCenterX;
    private var posCenterY;
    private var maxRadius;
    private var outerCycleRadius;
    private var middleCycleRadius;
    private var innerCycleRadius;
    private var posIcon1X;
    private var posIcon1Y;
    private var posIcon2X;
    private var posIcon2Y;
    private var posIcon3X;
    private var posIcon3Y;
    private var iconFont;

    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeInPercent as Number, iconFont) {
        var deviceSettings = System.getDeviceSettings();
        var screenSize = deviceSettings.screenWidth;
        self.penSize = 3;
        self.absOffsetX = offsetXInPercent  * screenSize / 100;
        self.absOffsetY = offsetYInPercent  * screenSize / 100;
        self.width = drawSizeInPercent * screenSize / 100;
        self.height = drawSizeInPercent * screenSize / 100;
        self.posCenterX = self.absOffsetX  + self.width / 2;
        self.posCenterY = self.absOffsetY  + self.height / 2;        
        self.maxRadius = drawSizeInPercent * screenSize / 200;
        self.outerCycleRadius = self.maxRadius - self.penSize;
        self.middleCycleRadius = self.maxRadius - 5 - self.penSize;
        self.innerCycleRadius = self.maxRadius - 10 - self.penSize;
        self.posIcon1X = posCenterX + innerCycleRadius / 2 * Toybox.Math.cos(Toybox.Math.PI * 0.5);
        self.posIcon1Y = posCenterY - innerCycleRadius / 2 * Toybox.Math.sin(Toybox.Math.PI * 0.5);
        self.posIcon2X = posCenterX + innerCycleRadius / 2 * Toybox.Math.cos(Toybox.Math.PI * 1.1667);
        self.posIcon2Y = posCenterY - innerCycleRadius / 2 * Toybox.Math.sin(Toybox.Math.PI * 1.1667);
        self.posIcon3X = posCenterX + innerCycleRadius / 2 * Toybox.Math.cos(Toybox.Math.PI * 1.8333);
        self.posIcon3Y = posCenterY - innerCycleRadius / 2 * Toybox.Math.sin(Toybox.Math.PI * 1.8333);
        self.iconFont = iconFont;
    }

    function percentToArcStopValue(percent as Number) as Number {
        if (percent == 0){
            return arcStartAngle_ + 1;
        }
        var arcStopAngle = arcStartAngle_ + percent * 3.6;
        if(arcStopAngle > 360){
            arcStopAngle = arcStopAngle - 360;
            if(arcStopAngle > arcStartAngle_){
                arcStopAngle = arcStartAngle_;
            }
        }      
        return arcStopAngle;
    }

    function extractNewestBodyBatteryValue() as Number {
        if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getBodyBatteryHistory)) {
            var bbIterator = Toybox.SensorHistory.getBodyBatteryHistory({});
            if(bbIterator != null){
                var sample = bbIterator.next();
                if(sample != null) {
                    return sample.data;
                }
            }
        }
        return 0;
    }

    function getBatteryValue() as Number {
        var stats = System.getSystemStats();
        return stats.battery;
    }

    function getStepGoalStateInPercent() as Number {
        var activityInfo = Toybox.ActivityMonitor.getInfo();
        return 100 * activityInfo.steps / activityInfo.stepGoal;
    }

    function onUpdate(dc as Dc) as Void {
        dc.setClip(self.absOffsetX, self.absOffsetY, self.width, self.height);
        dc.clear();

        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
        dc.drawText(posIcon1X, posIcon1Y, self.iconFont, "B", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        dc.drawText(posIcon2X, posIcon2Y, self.iconFont, "P", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        dc.drawText(posIcon3X, posIcon3Y, self.iconFont, "S", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);

        dc.setPenWidth(self.penSize);
        var bodyBatteryValue = self.percentToArcStopValue(self.extractNewestBodyBatteryValue());
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
        dc.drawArc(self.posCenterX ,self.posCenterY, self.middleCycleRadius, 0, arcStartAngle_, bodyBatteryValue);

        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        var batteryValue = self.percentToArcStopValue(self.getBatteryValue());
        dc.drawArc(self.posCenterX ,self.posCenterY, self.innerCycleRadius, 0, arcStartAngle_, batteryValue);

        var stepProgress = self.percentToArcStopValue(self.getStepGoalStateInPercent());
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        dc.drawArc(self.posCenterX ,self.posCenterY, self.outerCycleRadius , 0, arcStartAngle_, stepProgress);     

        drawBorder(dc);
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