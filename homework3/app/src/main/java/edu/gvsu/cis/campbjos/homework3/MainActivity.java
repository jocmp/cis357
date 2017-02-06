package edu.gvsu.cis.campbjos.homework3;

import android.location.Location;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.Locale;

import edu.gvsu.cis.campbjos.homework3.widget.CoordinateLinearLayout;

import static java.lang.String.format;
import static java.math.RoundingMode.HALF_EVEN;
import static java.math.RoundingMode.HALF_UP;

public class MainActivity extends AppCompatActivity {


    private static final String BEARING_FORMAT = "%.2f degrees";
    private static final String DISTANCE_FORMAT = "%.2f kilometers";

    private CoordinateLinearLayout sourceCoordinates;
    private CoordinateLinearLayout destinationCoordinates;

    private TextView bearingText;
    private TextView distanceText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        toolbar.setTitle("Geo Locator");

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(view -> calculate());

        sourceCoordinates = (CoordinateLinearLayout) findViewById(R.id.sourceCoordinates);
        destinationCoordinates = (CoordinateLinearLayout) findViewById(R.id.destinationCoordinates);

        bearingText = (TextView) findViewById(R.id.bearingText);
        distanceText = (TextView) findViewById(R.id.distanceText);

        sourceCoordinates.prepopulate("43.077366", "-85.994053");
        destinationCoordinates.prepopulate("43.077303", "-85.993860");
        calculate();
    }

    private void calculate() {
        Location source = sourceCoordinates.getLocation();
        Location destination = destinationCoordinates.getLocation();

        float distance = round(source.distanceTo(destination)) / 1000.0f;
        float bearing = source.bearingTo(destination);

        bearingText.setText(format(Locale.getDefault(), BEARING_FORMAT, bearing));
        distanceText.setText(format(Locale.getDefault(), DISTANCE_FORMAT, distance));
    }

    private float round(double value) {
        return BigDecimal.valueOf(value).setScale(2, HALF_EVEN).floatValue();
    }
}
