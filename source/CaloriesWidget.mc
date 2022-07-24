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