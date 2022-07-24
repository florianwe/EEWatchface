class ValueWithIconWidget extends EEWidget {
    private var posValueStart;
    private var iconChar;
    private var iconFont;

    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, iconFont, iconChar as String) {
        EEWidget.initialize(offsetXInPercent, offsetYInPercent, drawSizeXInPercent, 10);
        var screenSize = System.getDeviceSettings().screenWidth;
        self.posValueStart = self.absOffsetX + 8 * screenSize / 100;
        self.iconChar = iconChar;     
        self.iconFont = iconFont; 
    }

    function onUpdate(dc as Dc, valueString as String) as Void {
        dc.setClip(self.absOffsetX, self.absOffsetY, self.width, self.height);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, self.backgroundColor_);
        dc.drawText(self.absOffsetX, self.posCenterY, self.iconFont, self.iconChar, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(self.posValueStart, self.posCenterY, Graphics.FONT_XTINY, valueString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        self.drawBorder(dc);
        dc.clearClip();
    }
    
}