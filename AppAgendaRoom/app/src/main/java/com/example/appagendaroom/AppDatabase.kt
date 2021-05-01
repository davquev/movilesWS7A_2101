package com.example.appagendaroom

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(entities = arrayOf(Contact::class),version = 1)
abstract class AppDatabase: RoomDatabase() {
    abstract fun getDao(): ContactDAO

    companion object{
        private var INSTANCE: AppDatabase? = null

        fun getInstance(context: Context): AppDatabase{
            if (INSTANCE == null)
            {
                INSTANCE = Room
                    .databaseBuilder(context, AppDatabase::class.java, "miagenda.db")
                    .allowMainThreadQueries()
                    .build()
            }
            return INSTANCE as AppDatabase
        }
    }

}