class EEGeometry {
    public var offsetXInPercent as Number; 
    public var offsetYInPercent as Number;
    public var drawSizeXInPercent as Number;
    public var drawSizeYInPercent as Number;

    function initialize(offsetXInPercent as Number, offsetYInPercent as Number, drawSizeXInPercent as Number, drawSizeYInPercent as Number){
        self.offsetXInPercent = offsetXInPercent;
        self.offsetYInPercent = offsetYInPercent;
        self.drawSizeXInPercent = drawSizeXInPercent;
        self.drawSizeYInPercent = drawSizeYInPercent;
    }    
}