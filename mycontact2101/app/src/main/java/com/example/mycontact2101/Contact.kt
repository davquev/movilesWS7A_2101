package com.example.mycontact2101

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
class Contact (
    @PrimaryKey(autoGenerate = true)
    val id: Int,

    @ColumnInfo
    val name: String,

    @ColumnInfo
    val telephone: String
)