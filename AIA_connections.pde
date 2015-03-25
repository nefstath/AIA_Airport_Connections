import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.*;

//  Date: November 23th, 2014
//  Author: Nikolaos Efstathopoulos

UnfoldingMap map;
 
void setup() {
    size(800, 600, P2D);
//    you can pick what kind of map is to be used:
//    map = new UnfoldingMap(this);
//    map = new UnfoldingMap(this, new Microsoft.AerialProvider());
//    map = new UnfoldingMap(this, new MapBox.ControlRoomProvider());
    map = new UnfoldingMap(this, new Microsoft.RoadProvider());
    MapUtils.createDefaultEventDispatcher(this, map);

}

 
void draw() {
    map.draw();
    map.zoomAndPanTo(new Location(46.0f, 12.7f), 4);
    
    //sometimes it is helpful to include a way to visualise the coordinates
    Location coordLocation = map.getLocation(mouseX, mouseY);
    fill(#FA1B03);
    text(coordLocation.getLat() + ", " + coordLocation.getLon(), mouseX, mouseY);

    // work with the connections of Athens International Airport 
    Table table = loadTable("airports_od_pax.csv","header");
    for (TableRow row : table.findRows("LGAV", "O_ICAO")) {
    // for (TableRow row : table.rows()) {
    
    //TableRow row = table.getRow(2);  // Gets the third row (index 2)
    float O_lat = row.getFloat("O_latitude");
    float O_lon = row.getFloat("O_longtitude");
    float D_lat = row.getFloat("D_latitude");
    float D_lon = row.getFloat("D_longtitude");
    float Pax = row.getFloat("Pax");
    Location startLocation = new Location(O_lat, O_lon);
    Location endLocation = new Location(D_lat, D_lon);
    SimpleLinesMarker connectionMarker = new SimpleLinesMarker(startLocation, endLocation);
    if (Pax<100000) {
    connectionMarker.setColor(color(#F1FA03));
    connectionMarker.setStrokeColor(color(#F1FA03));
    connectionMarker.setStrokeWeight(1);
    } else if (Pax<500000) {
    connectionMarker.setColor(color(#FAC103));
    connectionMarker.setStrokeColor(color(#FAC103));
    connectionMarker.setStrokeWeight(2);
    } else if (Pax<1000000) {
    connectionMarker.setColor(color(#FA6E03));
    connectionMarker.setStrokeColor(color(#FA6E03));
    connectionMarker.setStrokeWeight(4);  
    } else {
    connectionMarker.setColor(color(#FA1B03));
    connectionMarker.setStrokeColor(color(#FA1B03));
    connectionMarker.setStrokeWeight(5);  
    }
    map.addMarkers(connectionMarker);
    
    }
}



