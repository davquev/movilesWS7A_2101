package com.example.appfutbol2021.models

import com.google.gson.annotations.SerializedName

class ApiResponseDetails (
    @SerializedName("results")
    var results: Int,
    @SerializedName("teams")
    var teams: List<Team>
        )