class CaloriesWidget extends ValueWithIconWidget{
    function initialize(geometry as EEGeometry, depiction as EEDepiction){
        ValueWithIconWidget.initialize(geometry, depiction, "C");
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