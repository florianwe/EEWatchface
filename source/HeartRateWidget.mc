class HeartRateWidget extends ValueWithIconWidget{
    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, iconFont){
        ValueWithIconWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeXInPercent, iconFont, "H");
    }

    function onUpdate(dc as Dc) as Void {
        var heartRate = Activity.getActivityInfo().currentHeartRate;
        if(heartRate == null){
            ValueWithIconWidget.onUpdate(dc, "--");
        } else {
            var heartRateString = Lang.format("$1$", [heartRate]);
            ValueWithIconWidget.onUpdate(dc, heartRateString);
        }
    }
}