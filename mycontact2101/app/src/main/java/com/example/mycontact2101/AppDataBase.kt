package com.example.mycontact2101

import android.content.Context
import androidx.room.Room
import androidx.room.RoomDatabase

abstract class AppDataBase: RoomDatabase() {
    abstract fun getDao(): ContactDAO
    companion object{
        private var INSTANCE: AppDataBase? = null

        fun getInstance(context: Context): AppDataBase{
            if (INSTANCE == null){
                INSTANCE = Room.databaseBuilder(context, AppDataBase::class.java, "app.db").build()
            }

            return INSTANCE as AppDataBase
        }
    }
}