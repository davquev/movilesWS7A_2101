package com.example.mycontact2101

import androidx.room.RoomDatabase

abstract class AppDataBase: RoomDatabase() {
    abstract fun getData(): ContactDAO

    
}