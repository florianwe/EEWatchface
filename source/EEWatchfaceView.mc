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

    private var count;
    private var backgroundColor_ = Graphics.COLOR_BLACK;
    private var quadCycleWidget;
    private var timeWidget;
    private var dateWidget;
    private var caloriesWidget;
    private var heartRateWidget;
    private var altitudeWidget;
    private var cyclingWidget;
    private var iconFont;
    private var offscreenBuffer;
    private var useScreenBuffer;

    function initialize() {
        WatchFace.initialize();
        self.iconFont = WatchUi.loadResource(Rez.Fonts.Icons); 
        self.quadCycleWidget = new QuadCycleWidget(55, 5, 35, self.iconFont);
        self.timeWidget = new TimeWidget(5, 60, 90, 25);
        self.dateWidget = new DateWidget(25, 85, 50, 10);
        self.caloriesWidget = new CaloriesWidget(15, 50, 25, self.iconFont);
        self.heartRateWidget = new HeartRateWidget(65, 50, 20, self.iconFont);
        self.altitudeWidget = new AltitudeWidget(40, 50, 25, self.iconFont);
        self.cyclingWidget = new CyclingWidget(5, 25, 50, 15, self.iconFont);
        self.count = 0;
        self.useScreenBuffer = false;   
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        if (Toybox.Graphics has :BufferedBitmap) {

            self.offscreenBuffer = Graphics.createBufferedBitmap({
                :width => dc.getWidth(),
                :height => dc.getHeight()
            });
        } else {
            self.offscreenBuffer = null;
        }
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {}

    function updateAllWidgets(dc as Dc) as Void {
        self.timeWidget.onUpdate(dc);
        self.dateWidget.onUpdate(dc);
        self.quadCycleWidget.onUpdate(dc);
        self.caloriesWidget.onUpdate(dc);
        self.heartRateWidget.onUpdate(dc);
        self.altitudeWidget.onUpdate(dc);
        self.cyclingWidget.onUpdate(dc);
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        var targetDc = dc;
        if(self.offscreenBuffer != null && self.useScreenBuffer){
            targetDc = self.offscreenBuffer.get().getDc();
        }
        targetDc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);


        if(count == 0){
            targetDc.clear();
            updateAllWidgets(targetDc);
        }       
        count = count + 1;
        var refreshrate = 5;
        if(!self.useScreenBuffer){
            refreshrate = 1;
        }
        if(count % refreshrate == 0){
            updateAllWidgets(targetDc);
        }

        if(self.offscreenBuffer != null && self.useScreenBuffer){
            dc.drawBitmap(0, 0, self.offscreenBuffer);
        }
             
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {}

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {}

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {}

}
