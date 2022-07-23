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

class EEWatchfaceView extends WatchUi.WatchFace {

    private var count;
    private var backgroundColor_ = Graphics.COLOR_BLACK;

    private var triCycleWidget;
    private var timeWidget;
    private var dateWidget;
    private var caloriesWidget;
    private var heartRateWidget;
    private var iconFont;

    function initialize() {
        WatchFace.initialize();
        self.iconFont = WatchUi.loadResource(Rez.Fonts.Icons); 
        self.triCycleWidget = new TriCycleWidget(65,20,20, self.iconFont);
        self.timeWidget = new TimeWidget(15, 60, 70, 25);
        self.dateWidget = new DateWidget(25, 85, 50, 10);
        self.caloriesWidget = new CaloriesWidget(25, 50, 25, self.iconFont);
        self.heartRateWidget = new HeartRateWidget(25, 40, 25, self.iconFont);
        self.count = 0;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        if(count == 0){
            dc.clear();
            self.timeWidget.onUpdate(dc);
            self.dateWidget.onUpdate(dc);
            self.triCycleWidget.onUpdate(dc);
            self.caloriesWidget.onUpdate(dc);
            self.heartRateWidget.onUpdate(dc);
            
        }       
        count = count + 1;
        if(count % 10 == 0){
            self.timeWidget.onUpdate(dc);
            self.dateWidget.onUpdate(dc);
            self.triCycleWidget.onUpdate(dc);
            self.caloriesWidget.onUpdate(dc);
            self.heartRateWidget.onUpdate(dc);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
