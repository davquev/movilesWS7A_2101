package com.example.appcamara

import android.Manifest
import android.content.pm.PackageManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    private val CAMERA_REQUEST_CODE=0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        btPermiso.setOnClickListener {
            checkCameraPermission()
        }
    }

    private fun checkCameraPermission() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA)
            != PackageManager.PERMISSION_GRANTED)
        {
            //permiso denegado
            requestCameraPermission()
        }
        else
        {
            Toast.makeText(this, "Ya se cuenta con permiso a la camara",
                Toast.LENGTH_LONG).show()
    }
    }

    private fun requestCameraPermission() {
        if (ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission.CAMERA))
        {
            Toast.makeText(this, "El usuario rechazo el permiso. Habilitelo manual",
                Toast.LENGTH_LONG).show()
        }
        else
        {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.CAMERA), CAMERA_REQUEST_CODE)
        }
    }

    //Vamos a sobrescribir la funcion onRequestPermissionResult() --> "escuchar"
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when (requestCode){
            CAMERA_REQUEST_CODE ->{
                if((grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED))
                {
                    Toast.makeText(this, "Se habilitó el acceso a la camara",
                        Toast.LENGTH_LONG).show()

                    //aqui ponemos el codigo q haga uso de la CAMARA
                }
                else{
                    Toast.makeText(this, "Permiso negado",
                        Toast.LENGTH_LONG).show()
                }
                return
            }

        }
    }
}