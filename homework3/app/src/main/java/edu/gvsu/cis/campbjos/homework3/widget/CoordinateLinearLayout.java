package edu.gvsu.cis.campbjos.homework3.widget;

import android.content.Context;
import android.location.Location;
import android.util.AttributeSet;
import android.util.Pair;
import android.view.LayoutInflater;
import android.widget.EditText;
import android.widget.LinearLayout;

import edu.gvsu.cis.campbjos.homework3.R;

public class CoordinateLinearLayout extends LinearLayout {

    private EditText latitudeText;
    private EditText longitudeText;

    public CoordinateLinearLayout(Context context) {
        this(context, null);
    }

    public CoordinateLinearLayout(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public CoordinateLinearLayout(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        LayoutInflater.from(context).inflate(R.layout.location_view, this);

        latitudeText = (EditText) findViewById(R.id.latitude);
        longitudeText = (EditText) findViewById(R.id.longitude);
    }

    public void prepopulate(String lat, String lon) {
        latitudeText.setText(lat);
        longitudeText.setText(lon);
    }

    public Location getLocation() {
        double latitude = Location.convert(latitudeText.getText().toString());
        double longitude = Location.convert(longitudeText.getText().toString());

        Location location = new Location("");
        location.setLatitude(latitude);
        location.setLongitude(longitude);

        return location;
    }
}
