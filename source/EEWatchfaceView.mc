import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Math;
using Toybox.SensorHistory;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.UserProfile;

class EEWatchfaceView extends WatchUi.WatchFace {
    private var quadCycleWidget;
    private var timeWidget;
    private var dateWidget;
    private var caloriesWidget;
    private var heartRateWidget;
    private var altitudeWidget;
    private var cyclingWidget;
    private var statusWidget;
    private var callCount = 0;
    private var updateRate = 8;

    function initialize() {
        WatchFace.initialize();
        var depiction = new EEDepiction();
        depiction.iconFont = WatchUi.loadResource(Rez.Fonts.Icons);
        depiction.clockFont = WatchUi.loadResource(Rez.Fonts.ClockFont);
        depiction.backgroundColor = Graphics.COLOR_TRANSPARENT;
        self.quadCycleWidget = new QuadCycleWidget(new EEGeometry(55, 5, 35, 35), depiction);
        self.timeWidget = new TimeWidget(new EEGeometry(5, 60, 90, 25), depiction);
        self.dateWidget = new DateWidget(new EEGeometry(25, 85, 50, 10), depiction);
        self.caloriesWidget = new CaloriesWidget(new EEGeometry(15, 50, 25, 10), depiction);
        self.heartRateWidget = new HeartRateWidget(new EEGeometry(65, 50, 20, 10), depiction);
        self.altitudeWidget = new AltitudeWidget(new EEGeometry(40, 50, 25, 10), depiction);
        self.cyclingWidget = new CyclingWidget(new EEGeometry(5, 25, 50, 15), depiction);
        self.statusWidget = new StatusWidget(new EEGeometry(20, 10, 30, 10), depiction);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {}

    function drawAllWidgets(dc as Dc) as Void {
        self.timeWidget.onUpdate(dc);
        self.dateWidget.onUpdate(dc);
        self.quadCycleWidget.onUpdate(dc);
        self.caloriesWidget.onUpdate(dc);
        self.heartRateWidget.onUpdate(dc);
        self.altitudeWidget.onUpdate(dc);
        self.cyclingWidget.onUpdate(dc);
        self.statusWidget.onUpdate(dc);
    }

    function fetchData() as Void {
        self.quadCycleWidget.fetchData();
        self.cyclingWidget.fetchData();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        if(self.callCount % self.updateRate == 0){
            self.fetchData();
        }
        self.drawAllWidgets(dc);
        self.callCount++;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {}

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
        self.callCount = 0;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {}

}
