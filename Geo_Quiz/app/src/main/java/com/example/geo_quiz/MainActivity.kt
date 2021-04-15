package com.example.geo_quiz

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    lateinit var questions: ArrayList<Question>
    var position = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        loadQuestions()
        setupViews()
    }

    fun loadQuestions() {
        questions = ArrayList()
        var question = Question("Es Lima capital de Ecuador", false)
        questions.add(question)

        question = Question("Es Lima capital de Perú", true)
        questions.add(question)

        question = Question("Es La Paz capital de Bolivia", true)
        questions.add(question)

        question = Question("Es Cancun capital de Bolivia", false)
        questions.add(question)

        question = Question("Es Brasil capital de Ecuador", false)
        questions.add(question)

        question = Question("Es Paris capital de Francia", true)
        questions.add(question)
    }

    fun setupViews() {
        //val btYes = findViewById<Button>(R.id.btYes)

        showSentence()

        btYes.setOnClickListener {
            if (questions[position].answer){
                Toast.makeText(this, "Correcto",Toast.LENGTH_LONG).show()
            }
            else{
                Toast.makeText(this, "Incorrecto",Toast.LENGTH_LONG).show()
            }
        }

        btNo.setOnClickListener {
            if (!questions[position].answer){
                Toast.makeText(this, "Correcto",Toast.LENGTH_LONG).show()
            }
            else{
                Toast.makeText(this, "Incorrecto",Toast.LENGTH_LONG).show()
            }
        }

        btNext.setOnClickListener {
            position++
            showSentence()
        }
    }

    fun showSentence() {
        tvSentence.text = questions[position].sentence
    }
}