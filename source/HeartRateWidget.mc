class HeartRateWidget extends ValueWithIconWidget{
    function initialize(geometry as EEGeometry, depiction as EEDepiction){
        ValueWithIconWidget.initialize(geometry, depiction, "H");
    }

    function calcIconColor(heartRate as Number){
        var color = Graphics.COLOR_WHITE;
        var hrZones = UserProfile.getProfile().getHeartRateZones(UserProfile.HR_ZONE_SPORT_GENERIC);
        if(heartRate > hrZones[1]){
            color = Graphics.COLOR_BLUE;
        }
        if(heartRate > hrZones[1]){
            color = Graphics.COLOR_GREEN;
        }
        if(heartRate > hrZones[1]){
            color = Graphics.COLOR_YELLOW;
        }
        if(heartRate > hrZones[1]){
            color = Graphics.COLOR_RED;
        }
        return color;
    }

    function onUpdate(dc as Dc) as Void {
        var heartRate = Activity.getActivityInfo().currentHeartRate;
        if(heartRate == null){
            ValueWithIconWidget.setIconColor(Graphics.COLOR_WHITE);
            ValueWithIconWidget.onUpdate(dc, "--");
        } else {
            var color = self.calcIconColor(heartRate);
            ValueWithIconWidget.setIconColor(color);
            var heartRateString = Lang.format("$1$", [heartRate]);
            ValueWithIconWidget.onUpdate(dc, heartRateString);
        }
    }
}