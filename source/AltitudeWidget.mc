class AltitudeWidget extends ValueWithIconWidget{
    function initialize(geometry as EEGeometry, depiction as EEDepiction){
        ValueWithIconWidget.initialize(geometry, depiction, "A");
    }

    function onUpdate(dc as Dc) as Void {
        var altitude = Activity.getActivityInfo().altitude;
        if(altitude == null){
            ValueWithIconWidget.onUpdate(dc, "--");
        }else{
            var altitudeString = Lang.format("$1$", [altitude.format("%d")]);
            ValueWithIconWidget.onUpdate(dc, altitudeString);
        }
    }
}