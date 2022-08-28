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
    private var staticWidgetArray;
    private var dynamicWidgetArray;
    private var callCount = 0;
    private var updateRate = 10;
    private var useOffscreenBuffer = true;
    private var offscreenBuffer;
    private var offscreenBufferDc;

    function initialize() {
        WatchFace.initialize();
        var depiction = new EEDepiction();
        depiction.iconsFont = WatchUi.loadResource(Rez.Fonts.Icons);
        depiction.hugeTextFont = WatchUi.loadResource(Rez.Fonts.HugeText);
        depiction.smallTextFont = WatchUi.loadResource(Rez.Fonts.SmallText);
        depiction.backgroundColor = Graphics.COLOR_BLACK;
        self.staticWidgetArray = [
         new QuadCycleWidget(new EEGeometry(60, 15, 35, 35), depiction),
         new DateWidget(new EEGeometry(25, 85, 50, 10), depiction),
         new CaloriesWidget(new EEGeometry(10, 50, 25, 10), depiction),
         new AltitudeWidget(new EEGeometry(35, 50, 25, 10), depiction),
         new CyclingWidget(new EEGeometry(0, 0, 58, 25), depiction),
         new StatusWidget(new EEGeometry(80, 50, 20, 10), depiction),
         new StepsWidget(new EEGeometry(60, 7, 25, 10), depiction),
         new SmileyWidget(new EEGeometry(20, 25, 25, 25), depiction)
        ];
        self.dynamicWidgetArray = [
            new TimeWidget(new EEGeometry(5, 60, 90, 25), depiction),
            new HeartRateWidget(new EEGeometry(60, 50, 20, 10), depiction)
        ];
        if (Toybox.Graphics has :BufferedBitmap && useOffscreenBuffer) {
            self.offscreenBuffer = Toybox.Graphics.createBufferedBitmap({:width=>System.getDeviceSettings().screenWidth, :height=>System.getDeviceSettings().screenHeight} );
            self.offscreenBufferDc = self.offscreenBuffer.get().getDc();
            self.offscreenBufferDc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
            self.offscreenBufferDc.clear();
        }
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        if(self.useOffscreenBuffer){
            self.fetchData();
            self.drawStaticWidgets(self.offscreenBufferDc);
        }
    }

    function drawAllWidgets(dc as Dc) as Void {
        self.drawStaticWidgets(dc);
        self.drawDynamicWidgets(dc);
    }

    function drawDynamicWidgets(dc as Dc) as Void {
        for(var i = 0; i < self.dynamicWidgetArray.size(); i++){
            self.dynamicWidgetArray[i].onUpdate(dc);
        }
    }

    function drawStaticWidgets(dc as Dc) as Void {
        for(var i = 0; i < self.staticWidgetArray.size(); i++){
            self.staticWidgetArray[i].onUpdate(dc);
        }
    }

    function fetchData() as Void {
        for(var i = 0; i < self.staticWidgetArray.size(); i++){
            self.staticWidgetArray[i].fetchData();
        }
        for(var i = 0; i < self.dynamicWidgetArray.size(); i++){
            self.dynamicWidgetArray[i].fetchData();
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        if(useOffscreenBuffer){
            self.drawDynamicWidgets(self.offscreenBufferDc);
            dc.drawBitmap(0, 0, self.offscreenBuffer);
        } else {
            if(self.callCount % self.updateRate == 0){
                self.fetchData();
            }
            self.drawAllWidgets(dc);
        }
        self.callCount++;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {}

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
        self.callCount = 0;
        if(self.useOffscreenBuffer){
            self.fetchData();
            self.drawStaticWidgets(self.offscreenBufferDc);
        }
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {}

}
