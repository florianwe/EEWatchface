class ValueWithIconWidget extends EEWidget {
    private var posValueStartX;
    private var iconChar;
    private var iconColor = Graphics.COLOR_WHITE;

    function initialize(geometry as EEGeometry, depiction as EEDepiction, iconChar as String) {
        EEWidget.initialize(geometry, depiction);
        var screenSize = System.getDeviceSettings().screenWidth;
        self.posValueStartX = self.drawOffsetX + 8 * screenSize / 100;
        self.iconChar = iconChar;     
    }

    function setIconColor(color as Graphics.ColorValue) as Void {
        self.iconColor = color;
    }

    function onUpdate(dc as Dc, valueString as String) as Void {
        self.onStartDrawing(dc);
        dc.setColor(self.iconColor, self.depiction.backgroundColor);
        dc.drawText(self.drawOffsetX, self.posCenterY, self.depiction.iconFont, self.iconChar, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
        dc.drawText(self.posValueStartX, self.posCenterY, Graphics.FONT_XTINY, valueString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        self.onFinishDrawing(dc);
    }

}