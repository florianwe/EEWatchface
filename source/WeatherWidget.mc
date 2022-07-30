import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.SensorHistory;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

class WeatherWidget extends EEWidget {
    var weatherForToday = null;
    var weatherForTomorrow = null;

    function initialize(geometry as EEGeometry, depiction as EEDepiction) {
        EEWidget.initialize(geometry, depiction);
    }

    function fetchData() as Void {
        self.weatherForToday = getWeatherForToday();
        self.weatherForTomorrow = getWeatherForTomorrow();
    }

    function getWeatherForToday() as Weather.DailyForecast {
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var forecasts = Weather.getDailyForecast();
        System.println(Lang.format("td $1$ $2$ $3$", [today.day, today.month, today.year]));       
        for (var i= 0; i< forecasts.size(); i++){
            var forecastMoment = Gregorian.info(forecasts[i].forecastTime, Time.FORMAT_SHORT);
            if(forecastMoment.year == today.year && forecastMoment.month == today.month && forecastMoment.day == today.day){
                System.println("today");
                return forecasts[i];
            }
        }
        return null;
    }

    function getWeatherForTomorrow() as Weather.DailyForecast {
        var tmp = Time.now();
        tmp = tmp.add(new Time.Duration(60*60*24));
        var tomorrow = Gregorian.info(tmp, Time.FORMAT_SHORT);
        var forecasts = Weather.getDailyForecast();
        for (var i= 0; i< forecasts.size(); i++){
            var forecastMoment = Gregorian.info(forecasts[i].forecastTime, Time.FORMAT_SHORT);
            if(forecastMoment.year == tomorrow.year && forecastMoment.month == tomorrow.month && forecastMoment.day == tomorrow.day){
                return forecasts[i];
            }
        }
        return null;
    }

    function drawForcast(dc as Dc, xStart as Number, xStop as Number, forcast) as Void {
        if(self.weatherForToday != null){
            dc.setColor(Graphics.COLOR_WHITE, self.depiction.backgroundColor);
            var temperatureText = Lang.format("$1$°/$2$°", [forcast.lowTemperature, forcast.highTemperature]);
            var precipitationChanceText = Lang.format("$1$%", [forcast.precipitationChance]);
            var weekdayString = Gregorian.info(forcast.forecastTime, Time.FORMAT_LONG).day_of_week;
            dc.drawText(xStop - 5, self.drawOffsetY + self.height - Graphics.getFontHeight(self.depiction.smallTextFont), self.depiction.smallTextFont, temperatureText, Graphics.TEXT_JUSTIFY_RIGHT);
            dc.drawText(xStop - 5, self.drawOffsetY + self.height - 2 * Graphics.getFontHeight(self.depiction.smallTextFont), self.depiction.smallTextFont, precipitationChanceText, Graphics.TEXT_JUSTIFY_RIGHT);
            dc.drawText(xStop - 5, self.drawOffsetY + self.height - 3 * Graphics.getFontHeight(self.depiction.smallTextFont), self.depiction.smallTextFont, weekdayString, Graphics.TEXT_JUSTIFY_RIGHT);
            dc.drawText(xStart + 0.35 * (xStop - xStart), self.drawOffsetY + 0.4 * self.height, self.depiction.smallTextFont, forcast.condition, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    function onUpdate(dc as Dc) as Void {
        self.onStartDrawing(dc);
        self.drawForcast(dc, self.drawOffsetX, self.drawOffsetX + self.width / 2, self.weatherForToday);
        self.drawForcast(dc, self.drawOffsetX + self.width / 2, self.drawOffsetX + self.width, self.weatherForTomorrow);
        dc.drawLine(self.drawOffsetX + self.width / 2, self.drawOffsetY, self.drawOffsetX + self.width / 2, self.drawOffsetY + self.height);
        dc.drawLine(self.drawOffsetX , self.drawOffsetY + self.height, self.drawOffsetX + self.width, self.drawOffsetY + self.height);
        dc.drawLine(self.drawOffsetX + self.width, self.drawOffsetY, self.drawOffsetX + self.width, self.drawOffsetY + self.height);
        self.onFinishDrawing(dc);
    }
        
}