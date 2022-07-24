import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Math;
using Toybox.SensorHistory;
using Toybox.System;

class QuadCycleWidget extends EEWidget {
    private var arcStartAngle_ = 270;
    private var penSize;
    private var maxRadius;
    private var innerCycleRadius;
    private var middleCycle1Radius;
    private var middleCycle2Radius;
    private var outerCycleRadius;
    private var posIcon1X;
    private var posIcon1Y;
    private var posIcon2X;
    private var posIcon2Y;
    private var posIcon3X;
    private var posIcon3Y;
    private var posIcon4X;
    private var posIcon4Y;
    private var iconFont;
    private var fontSize;

    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeInPercent as Number, iconFont) {
        EEWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeInPercent, drawSizeInPercent);
        self.penSize = 7;
        self.fontSize = Graphics.getFontHeight(iconFont);
        self.maxRadius = self.width / 2;
        self.innerCycleRadius = self.fontSize * 0.32 + self.penSize;
        self.middleCycle1Radius = self.innerCycleRadius + 1.4 * self.penSize ;
        self.middleCycle2Radius =  self.middleCycle1Radius + 1.4 * self.penSize;
        self.outerCycleRadius =  self.middleCycle2Radius + 1.4 * self.penSize;
        self.posIcon1X = self.posCenterX;
        self.posIcon1Y = self.posCenterY;
        self.posIcon2X = self.absOffsetX;
        self.posIcon2Y = self.absOffsetY;
        self.posIcon3X = self.absOffsetX;
        self.posIcon3Y = self.absOffsetY + self.height;
        self.posIcon4X = self.absOffsetX + self.width;
        self.posIcon4Y = self.absOffsetY + self.height;
        self.iconFont = iconFont;
        self.fontSize = 50;
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

    function extractNewestStressValue() as Number {
        if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getStressHistory)) {
            var stressIterator  = Toybox.SensorHistory.getStressHistory({});
            if(stressIterator  != null){
                var sample = stressIterator.next();
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

        dc.setPenWidth(self.penSize);

        dc.setColor(Graphics.COLOR_RED, self.backgroundColor_);
        dc.drawText(posIcon1X, posIcon1Y, self.iconFont, "P", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);
        var batteryValue = self.percentToArcStopValue(self.getBatteryValue());
        dc.drawArc(self.posCenterX ,self.posCenterY, self.innerCycleRadius, 0, arcStartAngle_, batteryValue);

        dc.setColor(Graphics.COLOR_BLUE, self.backgroundColor_);
        dc.drawText(posIcon4X, posIcon4Y - self.fontSize * 0.5, self.iconFont, "B", Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        var bodyBatteryValue = self.percentToArcStopValue(self.extractNewestBodyBatteryValue());
        dc.drawArc(self.posCenterX ,self.posCenterY, self.middleCycle2Radius, 0, arcStartAngle_, bodyBatteryValue);

        dc.setColor(Graphics.COLOR_GREEN, self.backgroundColor_);
        dc.drawText(posIcon3X, posIcon3Y - self.fontSize * 0.5, self.iconFont, "S", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        var stepProgress = self.percentToArcStopValue(self.getStepGoalStateInPercent());
        dc.drawArc(self.posCenterX ,self.posCenterY, self.outerCycleRadius , 0, arcStartAngle_, stepProgress);     

        dc.setColor(Graphics.COLOR_YELLOW, self.backgroundColor_);
        dc.drawText(posIcon2X, posIcon2Y + self.fontSize * 0.4, self.iconFont, "Q", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        var stressValue = self.percentToArcStopValue(self.extractNewestStressValue());
        dc.drawArc(self.posCenterX ,self.posCenterY, self.middleCycle1Radius , 0, arcStartAngle_, stressValue);     

        drawBorder(dc);
        dc.clearClip();
    }

}