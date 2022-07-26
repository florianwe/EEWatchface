class HeartRateWidget extends ValueWithIconWidget{
    function initialize(geometry as EEGeometry, depiction as EEDepiction){
        ValueWithIconWidget.initialize(geometry, depiction, "H");
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