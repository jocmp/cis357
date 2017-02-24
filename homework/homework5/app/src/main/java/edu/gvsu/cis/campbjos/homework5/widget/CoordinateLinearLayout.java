package edu.gvsu.cis.campbjos.homework5.widget;

import android.content.Context;
import android.location.Location;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.EditText;
import android.widget.LinearLayout;

import edu.gvsu.cis.campbjos.homework5.R;

/**
 * @author Derrick Bentley
 * @author Josiah Campbell
 * @version Winter 2017
 */
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
        LayoutInflater.from(context).inflate(R.layout.coordinate_view, this);

        latitudeText = (EditText) findViewById(R.id.latitude);
        longitudeText = (EditText) findViewById(R.id.longitude);
    }

    public void clearFields() {
        latitudeText.setText(null);
        longitudeText.setText(null);
    }

    public Location getLocation() {
        double latitude = convert(latitudeText);
        double longitude = convert(longitudeText);

        Location location = new Location("");

        location.setLatitude(latitude);
        location.setLongitude(longitude);

        return location;
    }

    private double convert(EditText editText) {
        if (editText.getText().length() <= 0) {
            return 0;
        }
        return Location.convert(editText.getText().toString());
    }

    public void setValues(String latitude, String longitude){
        this.latitudeText.setText(latitude);
        this.longitudeText.setText(longitude);
    }
}
