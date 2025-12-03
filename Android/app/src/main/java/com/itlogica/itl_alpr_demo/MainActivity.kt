package com.itlogica.itl_alpr_demo

import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import com.itlogica.automotive.sdk.preview.CameraActivity
import com.itlogica.automotive.sdk.preview.ScanResultCache

class MainActivity : AppCompatActivity() {
    private lateinit var cameraResultLauncher: ActivityResultLauncher<Intent>
    private lateinit var sharedPreferences: SharedPreferences

    override fun onCreate(savedInstanceState: Bundle?) {
        setContentView(R.layout.activity_main)
        super.onCreate(savedInstanceState)
        sharedPreferences = getSharedPreferences("app_settings", MODE_PRIVATE)

        // Register for the camera launcher
        cameraResultLauncher = registerForActivityResult(
            ActivityResultContracts.StartActivityForResult()
        ) { result ->
            if (result.resultCode == RESULT_OK) {
                // Process the recognition results
                val state = ScanResultCache.recognizedState
                val no = ScanResultCache.recognizedNo
                val msg = if (!state.isNullOrEmpty() || !no.isNullOrEmpty()) {
                    "Result: ${state.orEmpty()} ${no.orEmpty()}"
                } else {
                    "Please register again"
                }
                Toast.makeText(this, msg, Toast.LENGTH_LONG).show()
                ScanResultCache.recognizedState = null
                ScanResultCache.recognizedNo = null
            }
        }
    }


    fun openCameraPreview(view: View) {
        val intent = Intent(this, CameraActivity::class.java)
        cameraResultLauncher.launch(intent)
    }
}