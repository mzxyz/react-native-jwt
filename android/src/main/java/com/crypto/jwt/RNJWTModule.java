package com.crypto.jwt;

import com.crypto.jwt.algorithems.HSBase;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;

public class RNJWTModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNJWTModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNJWT";
  }

  @ReactMethod
  public void verify(String token, String key, String signature, String algorithm, Promise promise) {
    try {
      boolean verified = HSBase.verify(token, key, signature, algorithm);
      promise.resolve(verified);
    } catch (Exception e) {
      promise.reject("validate mnemonic phrase failed", e);
    }
  }
}