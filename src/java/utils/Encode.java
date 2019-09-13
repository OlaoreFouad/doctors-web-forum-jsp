/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.io.UnsupportedEncodingException;
import java.util.Base64;

/**
 *
 * @author hp
 */
public class Encode {
    
    public static String encode(String base) {
        String encodedString = null;
        try {
            encodedString = Base64.getEncoder().encodeToString(base.getBytes("utf-8"));
        } catch(UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        
        return encodedString;
    }
    
    public static String decode(String encodedString) {
        String decodedString = null;
        try {
            byte[] decBytes = Base64.getDecoder().decode(encodedString);
            decodedString = new String(decBytes, "utf-8");
        } catch(UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        
        return decodedString;
    }
    
}
