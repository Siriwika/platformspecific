package com.example.platformspecific

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


import android.util.Log
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

/**
 *
 */
class MainActivity : FlutterActivity() {

    private val channel = "samples.flutter.dev/platforms"
    private val tag = "MainActivity"

    // Access a Cloud Firestore instance from your Activity
    private val db = Firebase.firestore

    /**
     *
     */
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, _ ->
            if (call.method == "getUserData") {
                db.collection("User")
                    .get()
                    .addOnSuccessListener { result ->
                        for (document in result) {
                            Log.d(tag, "${document.id} => ${document.data}")
                        }
                    }
                    .addOnFailureListener { exception ->
                        Log.w(tag, "Error getting documents.", exception)
                    }


            }

        }
    }

}
