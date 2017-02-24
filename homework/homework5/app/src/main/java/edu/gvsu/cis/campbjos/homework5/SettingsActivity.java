package edu.gvsu.cis.campbjos.homework5;

import android.content.Intent;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

import java.util.Arrays;
import java.util.List;

import static edu.gvsu.cis.campbjos.homework5.MainActivity.BEARING_UNITS;
import static edu.gvsu.cis.campbjos.homework5.MainActivity.DISTANCE_UNITS;
public class SettingsActivity extends AppCompatActivity {

    private Spinner spinnerBearing;
    private Spinner spinnerDistance;

    static final String SELECTED_BEARING = "selectedBearing";
    static final String SELECTED_DISTANCE = "selectedDistance";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_settings);

        Intent intent = getIntent();

        spinnerBearing = (Spinner) findViewById(R.id.spnrBearing);
        spinnerDistance = (Spinner) findViewById(R.id.spnrDistance);

        List<String> bearingUnits = Arrays.asList(getResources().getStringArray(R.array.bearingUnits));
        List<String> distanceUnits = Arrays.asList(getResources().getStringArray(R.array.distanceUnits));

        ArrayAdapter<String> adapterBearing = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, bearingUnits);
        ArrayAdapter<String> adapterDistance = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, distanceUnits);

        adapterBearing.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        adapterDistance.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        spinnerBearing.setAdapter(adapterBearing);
        spinnerDistance.setAdapter(adapterDistance);

        spinnerBearing.setSelection(bearingUnits.indexOf(intent.getStringExtra(SELECTED_BEARING)));
        spinnerDistance.setSelection(distanceUnits.indexOf(intent.getStringExtra(SELECTED_DISTANCE)));

        FloatingActionButton btnSave = (FloatingActionButton) findViewById(R.id.saveButton);
        btnSave.setOnClickListener(view -> save());

    }


    private void save() {
        Intent passingSave = new Intent();
        passingSave.putExtra(BEARING_UNITS, (String) spinnerBearing.getSelectedItem());
        passingSave.putExtra(DISTANCE_UNITS, (String) spinnerDistance.getSelectedItem());
        setResult(RESULT_OK, passingSave);
        finish();
    }

}
