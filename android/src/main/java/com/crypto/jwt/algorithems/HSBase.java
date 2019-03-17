package com.crypto.jwt.algorithems;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.security.InvalidKeyException;
import java.util.Arrays;
import java.util.List;

public class HSBase {

  private static final List<String> HSAlgorithms = Arrays.asList("HS256", "HS384", "HS512");

  public static boolean verify(String token, String key, String signature, String algorithm) throws NoSuchAlgorithmException, InvalidKeyException, UnsupportedEncodingException {
    if (!HSAlgorithms.contains(algorithm)) {
      String msg = String.format("The %s is not supported, it should be HSBase algorithms", algorithm);
      throw new RuntimeException(msg);
    }

    byte[] contentBytes = token.getBytes("UTF_8");
    byte[] secretKeyBytes = key.getBytes("UTF_8");
    String algName = HMACSHAlgAName(algorithm);

    return Signature.verifySignature(algName, secretKeyBytes, contentBytes, signature);
  }

  private static String HMACSHAlgAName(String jwtAlgName) {
    switch (jwtAlgName) {
      case "HS256":
        return "HmacSHA256";
      case "HS384":
        return "HmacSHA384";
      case "HS512":
        return "HmacSHA512";
      default:
        return null;
    }
  }
}