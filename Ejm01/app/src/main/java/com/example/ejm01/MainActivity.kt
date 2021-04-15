package com.example.ejm01

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.EditText

const val EXTRA_MESS = "com.example.ejm01.message"

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun sendMessage(view: View)
    {
        val editText = findViewById<EditText>(R.id.etEmail)
        val message = editText.text.toString()

        val intent = Intent(this, DisplayMessageAct::class.java).apply{
            putExtra(EXTRA_MESS, message)
        }

        startActivity(intent)
    }
}