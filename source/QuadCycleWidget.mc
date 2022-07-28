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
    private var fontSize;
    private var stepGoalState = 0;
    private var batteryState = 0;
    private var batteryStateLetter = "P";
    private var bodyBatteryState = 0;
    private var stressState = 0;

    function initialize(geometry as EEGeometry, depiction as EEDepiction) {
        EEWidget.initialize(geometry, depiction);
        self.penSize = 7;
        self.fontSize = Graphics.getFontHeight(self.depiction.iconFont);
        self.maxRadius = self.width / 2;
        self.innerCycleRadius = self.fontSize * 0.32 + self.penSize;
        self.middleCycle1Radius = self.innerCycleRadius + 1.4 * self.penSize ;
        self.middleCycle2Radius =  self.middleCycle1Radius + 1.4 * self.penSize;
        self.outerCycleRadius =  self.middleCycle2Radius + 1.4 * self.penSize;
        self.posIcon1X = self.posCenterX;
        self.posIcon1Y = self.posCenterY;
        self.posIcon2X = self.drawOffsetX;
        self.posIcon2Y = self.drawOffsetY;
        self.posIcon3X = self.drawOffsetX;
        self.posIcon3Y = self.drawOffsetY + self.height;
        self.posIcon4X = self.drawOffsetX + self.width;
        self.posIcon4Y = self.drawOffsetY + self.height;
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
        self.batteryStateLetter = "P";
        if(stats.battery < 85){
            self.batteryStateLetter = "O";
        }
        if(stats.battery < 50){
            self.batteryStateLetter = "N";
        }
        if(stats.battery < 25){
            self.batteryStateLetter = "M";
        }
        if(stats.battery < 10){
            self.batteryStateLetter = "L";
        }
        return stats.battery;
    }

    function getStepGoalStateInPercent() as Number {
        var activityInfo = Toybox.ActivityMonitor.getInfo();
        return 100 * activityInfo.steps / activityInfo.stepGoal;
    }

    function fetchData() as Void {
        self.stepGoalState = getStepGoalStateInPercent();
        self.batteryState = getBatteryValue();
        self.bodyBatteryState = extractNewestBodyBatteryValue();
        self.stressState = extractNewestStressValue();
    }

    function onUpdate(dc as Dc) as Void {
        self.onStartDrawing(dc);
        self.doDraw(dc);
        self.onFinishDrawing(dc);
    }

    function doDraw(dc as Dc) as Void {
        dc.setPenWidth(self.penSize);
        dc.setColor(Graphics.COLOR_RED, self.depiction.backgroundColor);
        dc.drawText(posIcon1X, posIcon1Y, self.depiction.iconFont, self.batteryStateLetter, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);
        var batteryValue = self.percentToArcStopValue(self.batteryState);
        dc.drawArc(self.posCenterX ,self.posCenterY, self.innerCycleRadius, 0, arcStartAngle_, batteryValue);

        dc.setColor(Graphics.COLOR_BLUE, self.depiction.backgroundColor);
        dc.drawText(posIcon4X, posIcon4Y - self.fontSize * 0.5, self.depiction.iconFont, "B", Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        var bodyBatteryValue = self.percentToArcStopValue(self.bodyBatteryState);
        dc.drawArc(self.posCenterX ,self.posCenterY, self.middleCycle2Radius, 0, arcStartAngle_, bodyBatteryValue);

        dc.setColor(Graphics.COLOR_YELLOW, self.depiction.backgroundColor);
        dc.drawText(posIcon2X, posIcon2Y + self.fontSize * 0.4, self.depiction.iconFont, "Q", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        var stressValue = self.percentToArcStopValue(self.stressState);
        dc.drawArc(self.posCenterX ,self.posCenterY, self.middleCycle1Radius , 0, arcStartAngle_, stressValue);

        dc.setColor(Graphics.COLOR_GREEN, self.depiction.backgroundColor);
        dc.drawText(posIcon3X, posIcon3Y - self.fontSize * 0.5, self.depiction.iconFont, "S", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        var stepProgress = self.percentToArcStopValue(self.stepGoalState);
        dc.drawArc(self.posCenterX ,self.posCenterY, self.outerCycleRadius , 0, arcStartAngle_, stepProgress);
        if (self.stepGoalState > 100){
            stepProgress = self.percentToArcStopValue(self.stepGoalState - 100);
            dc.setColor(Graphics.COLOR_DK_GREEN, self.depiction.backgroundColor);
            dc.drawArc(self.posCenterX ,self.posCenterY, self.outerCycleRadius , 0, arcStartAngle_, stepProgress);
        }
    }

}