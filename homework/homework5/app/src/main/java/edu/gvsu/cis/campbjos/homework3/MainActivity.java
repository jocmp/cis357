package edu.gvsu.cis.campbjos.homework3;

import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.TextView;

import java.math.BigDecimal;

import edu.gvsu.cis.campbjos.homework3.widget.CoordinateLinearLayout;

import static edu.gvsu.cis.campbjos.homework3.SettingsActivity.*;
import static java.math.RoundingMode.HALF_EVEN;

/**
 * @author Derrick Bentley
 * @author Josiah Campbell
 * @version Winter 2017
 */
public class MainActivity extends AppCompatActivity {

    private CoordinateLinearLayout sourceCoordinates;
    private CoordinateLinearLayout destinationCoordinates;

    private TextView bearingText;
    private TextView distanceText;

    static final String DISTANCE_UNITS = "distanceUnits";
    static final String BEARING_UNITS = "bearingUnits";
    static final int SETTINGS_RESULT_CODE = 15;

    private String selectedDistance;
    private String selectedBearing;

    public MainActivity() {
        super();
        selectedDistance = "Kilometers";
        selectedBearing = "Degrees";
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        sourceCoordinates = (CoordinateLinearLayout) findViewById(R.id.sourceCoordinates);
        destinationCoordinates = (CoordinateLinearLayout) findViewById(R.id.destinationCoordinates);

        bindResultText();
        bindButtons();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == R.id.action_settings) {
            Intent intent = new Intent(MainActivity.this, SettingsActivity.class);
            intent.putExtra(SELECTED_BEARING, selectedBearing);
            intent.putExtra(SELECTED_DISTANCE, selectedDistance);
            startActivityForResult(intent, SETTINGS_RESULT_CODE);
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK && requestCode == SETTINGS_RESULT_CODE) {
            selectedDistance = data.getStringExtra(DISTANCE_UNITS);
            selectedBearing = data.getStringExtra(BEARING_UNITS);
            calculate();
        }
    }

    private void bindResultText() {
        bearingText = (TextView) findViewById(R.id.bearingText);
        distanceText = (TextView) findViewById(R.id.distanceText);
        resetResults();
    }

    private void bindButtons() {
        Button clearAll = (Button) findViewById(R.id.clearAll);
        clearAll.setOnClickListener(view -> clearAll());

        Button calculate = (Button) findViewById(R.id.calculate);
        calculate.setOnClickListener(view -> calculate());
    }

    private void calculate() {
        hideKeyboard();

        Location source = sourceCoordinates.getLocation();
        Location destination = destinationCoordinates.getLocation();

        float distance = getDistanceBetween(source, destination);
        float bearing = getBearingBetween(source, destination);

        bearingText.setText(getString(R.string.formattedUnit, bearing, selectedBearing));
        distanceText.setText(getString(R.string.formattedUnit, distance, selectedDistance));
    }

    private float getBearingBetween(Location source, Location destination) {
        float bearingInDegrees = source.bearingTo(destination);
        if (selectedBearing.equals("Mils"))
            bearingInDegrees *= 17.777777777778f;
        return round(bearingInDegrees);
    }

    private float getDistanceBetween(Location source, Location destination) {
        float distanceInMeters = source.distanceTo(destination);
        float resultInSelectedUnit = distanceInMeters / 1000f;
        if (selectedDistance.equals("Miles"))
            resultInSelectedUnit *= 0.621371f;
        return round(resultInSelectedUnit);
    }

    private float round(float value) {
        return BigDecimal.valueOf(value).setScale(2, HALF_EVEN).floatValue();
    }

    private void clearAll() {
        hideKeyboard();

        sourceCoordinates.clearFields();
        destinationCoordinates.clearFields();

        resetResults();
    }

    private void resetResults() {
        bearingText.setText(getString(R.string.formattedUnit, 0f, selectedBearing));
        distanceText.setText(getString(R.string.formattedUnit, 0f, selectedDistance));
    }

    private void hideKeyboard() {
        InputMethodManager manager = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        if (getWindow().getDecorView() != null) {
            manager.hideSoftInputFromWindow(getWindow().getDecorView().getWindowToken(), 0);
        }
    }
}
