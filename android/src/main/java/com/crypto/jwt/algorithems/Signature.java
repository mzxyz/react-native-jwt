package com.crypto.jwt.algorithems;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.security.NoSuchAlgorithmException;
import java.security.InvalidKeyException;
import android.util.Base64;

public class Signature {
    public static boolean verifySignature(String algorithm, byte[] secretBytes, byte[] contentBytes, String signature) throws NoSuchAlgorithmException, InvalidKeyException {
      String currentSignature = createSignature(algorithm, secretBytes, contentBytes);
      return (signature.equals(currentSignature));
    }

    public static String createSignature(String algorithm, byte[] secretBytes, byte[] contentBytes) throws NoSuchAlgorithmException, InvalidKeyException {
      Mac mac = Mac.getInstance(algorithm);
      mac.init(new SecretKeySpec(secretBytes, algorithm));
      byte[] signature =  mac.doFinal(contentBytes);

      return Base64.encodeToString(signature, Base64.URL_SAFE | Base64.NO_PADDING | Base64.NO_WRAP);
    }
}