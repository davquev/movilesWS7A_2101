package com.example.appfutbol2021.controller.activities

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.appfutbol2021.R
import com.example.appfutbol2021.adapter.TeamAdapter
import com.example.appfutbol2021.models.ApiRespondeHeader
import com.example.appfutbol2021.models.Team
import com.example.appfutbol2021.network.TeamService
import retrofit2.*
import retrofit2.converter.gson.GsonConverterFactory

class MainActivity : AppCompatActivity() {
    lateinit var teamRecyclerView: RecyclerView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        teamRecyclerView = findViewById(R.id.rvTeams)
        loadTeams(this)
    }

    private fun loadTeams(context: Context) {
        val retrofit = Retrofit.Builder()
            .baseUrl("https://api-football-v1.p.rapidapi.com/v2/teams/league/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()

        val teamService: TeamService
        teamService = retrofit.create(TeamService::class.java)
        val request = teamService.getTeams(
            "d229813befmsh4c1646ad132a0b5p1313fcjsn9afecaefc97e"
        )

        request.enqueue(object : Callback<ApiRespondeHeader>{
            override fun onResponse(
                call: Call<ApiRespondeHeader>,
                response: Response<ApiRespondeHeader>
            ) {
                val teams: List<Team> = response.body()!!.api.teams ?: ArrayList()
                teamRecyclerView.layoutManager = LinearLayoutManager(this@MainActivity)
                teamRecyclerView.adapter = TeamAdapter(teams, context)
            }

            override fun onFailure(call: Call<ApiRespondeHeader>, t: Throwable) {
                TODO("Not yet implemented")
            }

        })
    }
}