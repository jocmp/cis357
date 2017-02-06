package edu.gvsu.cis.campbjos.traxyapp_android;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.Switch;
import android.widget.TextView;

import static java.lang.String.format;


public class MainActivity extends AppCompatActivity {

    public static final String COUNTER_EXTRA = "counter";

    private Switch clearSwitch;

    private int currentCount;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        TextView counterText = (TextView) findViewById(R.id.counter_text);
        Button startButton = (Button) findViewById(R.id.start_new);
        clearSwitch = (Switch) findViewById(R.id.clear);


        Bundle extras = getIntent().getExtras();

        if (extras != null) {
            currentCount = extras.getInt(COUNTER_EXTRA);
        }

        counterText.setText(format("%s", currentCount));

        startButton.setOnClickListener((view) -> startNextActivity());
    }

    private void startNextActivity() {
        Intent intent = new Intent(this, MainActivity.class);

        int nextCount = currentCount + 1;

        if (clearSwitch.isChecked()) {
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
            nextCount = 0;
        }
        intent.putExtra(COUNTER_EXTRA, nextCount);

        startActivity(intent);
    }
}
