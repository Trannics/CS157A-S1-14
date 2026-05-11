import java.security.MessageDigest;
import java.security.SecureRandom;

public class PasswordUtil {

    private static final SecureRandom RANDOM = new SecureRandom();

    // Returns "<salt_hex>:<sha256_hex>" ready to store in Password_Hash.
    public static String hash(String password) throws Exception {
        byte[] salt = new byte[16];
        RANDOM.nextBytes(salt);
        String saltHex = toHex(salt);
        return saltHex + ":" + sha256(saltHex + password);
    }

    // Works for both hashed ("salt:hash") and legacy plaintext values.
    public static boolean verify(String password, String stored) throws Exception {
        if (stored == null) return false;
        int colon = stored.indexOf(':');
        if (colon < 0) {
            // Legacy plaintext — simple equality
            return stored.equals(password);
        }
        String saltHex = stored.substring(0, colon);
        String expected = stored.substring(colon + 1);
        return sha256(saltHex + password).equals(expected);
    }

    private static String sha256(String input) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        return toHex(md.digest(input.getBytes("UTF-8")));
    }

    private static String toHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder(bytes.length * 2);
        for (byte b : bytes) sb.append(String.format("%02x", b));
        return sb.toString();
    }
}
