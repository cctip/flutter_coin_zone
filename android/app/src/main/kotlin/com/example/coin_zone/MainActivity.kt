package com.CoinZone.CoinZone

import android.os.Bundle
import androidx.lifecycle.lifecycleScope
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity(){
    val f = FireBaseApp(this,lifecycleScope)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        f.onCreate()
    }

    override fun onDestroy() {
        super.onDestroy()
        f.onDestroy()
    }
}
