package com.federicoceriani.push_app;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;

// Nota, esta linea la agregue
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;

public class Application extends FlutterApplication implements PluginRegistrantCallback {
  @Override
  public void onCreate() {
    super.onCreate();
    FlutterFirebaseMessagingService.setPluginRegistrant(this);
  }

  @Override
  public void registerWith(PluginRegistry registry) {
    // GeneratedPluginRegistrant.registerWith(registry);
    FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
  }
}