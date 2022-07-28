using Toybox.Time;
using Toybox.Time.Gregorian;

class CyclingWidget extends EEWidget {
    private var distanceCurrentMonth = 0 ;
    private var distanceCurrentYear = 0;

    function initialize(geometry as EEGeometry, depiction as EEDepiction){
        EEWidget.initialize(geometry, depiction);
    }

    function fetchData() as Void {
        var userActivityIterator = UserProfile.getUserActivityHistory();
        var sample = userActivityIterator.next();
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        
        self.distanceCurrentMonth = 0 ;
        self.distanceCurrentYear = 0;
        while (sample != null) {    
            if(sample.type == 2 && sample.distance != null && sample.startTime != null) {
                var activityMoment = new Time.Moment(sample.startTime.value());
                activityMoment = activityMoment.add(new Time.Duration(631065600));// add Garmin Time offset
                var activityTime = Gregorian.info(activityMoment, Time.FORMAT_SHORT); 
                System.println(Lang.format("$1$ $2$", [activityTime.month, today.month]));
                System.println(Lang.format("$1$ $2$", [self.distanceCurrentMonth, self.distanceCurrentYear]));
                if(activityTime.year == today.year){
                    self.distanceCurrentYear += sample.distance;
                    if(activityTime.month == today.month){
                        self.distanceCurrentMonth += sample.distance;
                    }
                }
            }
            sample = userActivityIterator.next();
        }
    }

    function onUpdate(dc as Dc) as Void {
        self.onStartDrawing(dc);
        var distanceCurrentMonthString = Lang.format("$1$ km", [self.distanceCurrentMonth / 1000]);
        var distanceCurrentYearString = Lang.format("$1$ km", [self.distanceCurrentYear / 1000]);

        dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
        dc.drawText(self.drawOffsetX + 0.90 *self.width, self.drawOffsetY + 0.20 * self.height, self.depiction.iconFont, "R", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_RIGHT); 
        dc.drawText(self.drawOffsetX + 0.50 * self.width, self.drawOffsetY + 0.50 * self.height, self.depiction.smallTextFont, "M:", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_RIGHT); 
        dc.drawText(self.drawOffsetX + 0.98 * self.width, self.drawOffsetY + 0.50 * self.height, self.depiction.smallTextFont, distanceCurrentMonthString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_RIGHT); 
        dc.drawText(self.drawOffsetX + 0.50 * self.width, self.drawOffsetY + 0.80 * self.height, self.depiction.smallTextFont, "Y:", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_RIGHT); 
        dc.drawText(self.drawOffsetX + 0.98 * self.width, self.drawOffsetY + 0.80 * self.height, self.depiction.smallTextFont, distanceCurrentYearString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_RIGHT); 
        self.drawBorder(dc);
        self.onFinishDrawing(dc);
    }
}
