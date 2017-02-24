package edu.gvsu.cis.campbjos.homework3;

import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.TextView;

import java.math.BigDecimal;

import edu.gvsu.cis.campbjos.homework3.widget.CoordinateLinearLayout;

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

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        toolbar.setTitle("Geo Locator");

        sourceCoordinates = (CoordinateLinearLayout) findViewById(R.id.sourceCoordinates);
        destinationCoordinates = (CoordinateLinearLayout) findViewById(R.id.destinationCoordinates);


        bindResultText();
        bindButtons();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.item_settings:
                openSettings();
                break;
            default:
                break;
        }

        return super.onOptionsItemSelected(item);
    }

    private void openSettings() {
//        Intent intent = new Intent(MainActivity.this, SettingsActivity.class);
//        startActivityForResult();
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

        float distance = round(source.distanceTo(destination)) / 1000.0f;
        float bearing = source.bearingTo(destination);

        bearingText.setText(getString(R.string.degrees, bearing));
        distanceText.setText(getString(R.string.kilometers, distance));
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
        bearingText.setText(getString(R.string.degrees, 0f));
        distanceText.setText(getString(R.string.kilometers, 0f));
    }

    private void hideKeyboard() {
        InputMethodManager manager = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        if (getWindow().getDecorView() != null) {
            manager.hideSoftInputFromWindow(getWindow().getDecorView().getWindowToken(), 0);
        }
    }
}
