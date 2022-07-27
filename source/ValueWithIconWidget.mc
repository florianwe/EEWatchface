class ValueWithIconWidget extends EEWidget {
    private var posValueStart;
    private var iconChar;

    function initialize(geometry as EEGeometry, depiction as EEDepiction, iconChar as String) {
        EEWidget.initialize(geometry, depiction);
        var screenSize = System.getDeviceSettings().screenWidth;
        self.posValueStart = self.drawOffsetX + 8 * screenSize / 100;
        self.iconChar = iconChar;     
    }

    function onUpdate(dc as Dc, valueString as String) as Void {
        self.onStartDrawing(dc);
        dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
        dc.drawText(self.drawOffsetX, self.posCenterY, self.depiction.iconFont, self.iconChar, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(self.posValueStart, self.posCenterY, Graphics.FONT_XTINY, valueString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        self.onFinishDrawing(dc);
    }

}