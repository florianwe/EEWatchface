class AltitudeWidget extends ValueWithIconWidget{
    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, iconFont){
        ValueWithIconWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeXInPercent, iconFont, "A");
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