package com.Rydon.Util;

import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

public class PasswordUtil {
    private static final String ENCRYPT_ALGO = "AES/GCM/NoPadding";
    private static final int TAG_LENGTH_BIT = 128;
    private static final int IV_LENGTH_BYTE = 12;
    private static final int SALT_LENGTH_BYTE = 16;
    private static final Charset UTF_8 = StandardCharsets.UTF_8;
    private static final Logger LOGGER = Logger.getLogger(PasswordUtil.class.getName());

    public static byte[] getRandomNonce(int numBytes) {
        byte[] nonce = new byte[numBytes];
        new SecureRandom().nextBytes(nonce);
        return nonce;
    }

    public static SecretKey getAESKey(int keysize) throws NoSuchAlgorithmException {
        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
        keyGen.init(keysize, SecureRandom.getInstanceStrong());
        return keyGen.generateKey();
    }

    public static SecretKey getAESKeyFromPassword(char[] password, byte[] salt) {
        try {
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            KeySpec spec = new PBEKeySpec(password, salt, 65536, 256);
            SecretKey secret = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
            return secret;
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            LOGGER.log(Level.SEVERE, "Error generating AES key from password: " + ex.getMessage(), ex);
            return null;
        }
    }

    public static String encrypt(String username, String password) {
        if (username == null || password == null) {
            LOGGER.severe("Username or password is null");
            return null;
        }
        try {
            byte[] salt = getRandomNonce(SALT_LENGTH_BYTE);
            byte[] iv = getRandomNonce(IV_LENGTH_BYTE);
            SecretKey aesKeyFromPassword = getAESKeyFromPassword(username.toCharArray(), salt);
            if (aesKeyFromPassword == null) {
                LOGGER.severe("Failed to generate AES key for username: " + username);
                return null;
            }

            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            cipher.init(Cipher.ENCRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));
            byte[] cipherText = cipher.doFinal(password.getBytes(UTF_8));
            byte[] cipherTextWithIvSalt = ByteBuffer.allocate(iv.length + salt.length + cipherText.length)
                    .put(iv)
                    .put(salt)
                    .put(cipherText)
                    .array();
            String encoded = Base64.getEncoder().encodeToString(cipherTextWithIvSalt);
            LOGGER.info("Encrypted password for username: " + username + ", encoded length: " + encoded.length());
            return encoded;
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Encryption failed for username: " + username + ", error: " + ex.getMessage(), ex);
            return null;
        }
    }

    public static String decrypt(String encryptedPassword, String username) {
        if (encryptedPassword == null || username == null) {
            LOGGER.severe("Encrypted password or username is null");
            return null;
        }
        try {
            byte[] decode;
            try {
                decode = Base64.getDecoder().decode(encryptedPassword.getBytes(UTF_8));
            } catch (IllegalArgumentException ex) {
                LOGGER.severe("Invalid Base64 encoding for encrypted password: " + encryptedPassword);
                return null;
            }

            ByteBuffer bb = ByteBuffer.wrap(decode);
            if (bb.remaining() < IV_LENGTH_BYTE + SALT_LENGTH_BYTE) {
                LOGGER.severe("Encrypted password too short, expected at least " + (IV_LENGTH_BYTE + SALT_LENGTH_BYTE) + " bytes");
                return null;
            }

            byte[] iv = new byte[IV_LENGTH_BYTE];
            bb.get(iv);
            byte[] salt = new byte[SALT_LENGTH_BYTE];
            bb.get(salt);
            byte[] cipherText = new byte[bb.remaining()];
            bb.get(cipherText);

            SecretKey aesKeyFromPassword = getAESKeyFromPassword(username.toCharArray(), salt);
            if (aesKeyFromPassword == null) {
                LOGGER.severe("Failed to generate AES key for username: " + username);
                return null;
            }

            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            cipher.init(Cipher.DECRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));
            byte[] plainText = cipher.doFinal(cipherText);
            String decrypted = new String(plainText, UTF_8);
            LOGGER.info("Successfully decrypted password for username: " + username);
            return decrypted;
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Decryption failed for username: " + username + ", error: " + ex.getMessage(), ex);
            return null;
        }
    }
}