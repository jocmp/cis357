package edu.gvsu.cis.campbjos.traxy;

import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

import java.util.regex.Pattern;

public class LoginActivity extends AppCompatActivity {

    private static final Pattern EMAIL_REGEX;

    static {
        EMAIL_REGEX = Pattern.compile("[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}", Pattern.CASE_INSENSITIVE);
    }

    private EditText emailText;
    private EditText passwordText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        emailText = (EditText) findViewById(R.id.emailText);
        passwordText = (EditText) findViewById(R.id.passwordText);

        Button signIn = (Button) findViewById(R.id.signIn);

        signIn.setOnClickListener(view -> {
            if (isValidEmail() && isValidPassword()) {
                Snackbar.make(emailText, R.string.successful_login, Snackbar.LENGTH_SHORT).show();
            }
        });
    }


    private boolean isValidEmail() {
        return EMAIL_REGEX.matcher(emailText.getText().toString()).find();
    }

    private boolean isValidPassword() {
        return passwordText.length() > 5;
    }
}
