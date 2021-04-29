package com.example.appsharedpref

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val sharedPreferences = SharedPreferences(this)

        btSave.setOnClickListener {
            val name = etUser.text.toString()

            sharedPreferences.save("name", name)
            Toast.makeText(this, "Usuario registrado", Toast.LENGTH_LONG).show()
        }

        btRetrieve.setOnClickListener {
            if(sharedPreferences.getValue("name") != null)
            {
                tvRetrieve.setText(sharedPreferences.getValue("name"))
            }
        }
    }
}