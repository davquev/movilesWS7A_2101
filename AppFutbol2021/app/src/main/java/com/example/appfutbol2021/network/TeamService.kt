package com.example.appfutbol2021.network

import com.example.appfutbol2021.models.ApiRespondeHeader
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Header

interface TeamService {
    @GET("2")
    fun getTeams(@Header("x-rapidapi-key")apikey: String): Call<ApiRespondeHeader>
}