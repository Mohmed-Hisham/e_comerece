# Google Login API Guide (Direct Auth)

This endpoint allows users to sign in using their Google Account directly, without Firebase Auth.

## Endpoint Details
*   **URL:** `/api/v1/Auth/google-login`
*   **Method:** `POST`
*   **Content-Type:** `application/json`

## Workflow for Frontend
1.  **Google Sign-In button:** User clicks "Sign in with Google" on the app.
2.  **Get ID Token:** The mobile app (using Google Sign-In SDK) requests the user's **ID Token** (not Access Token) from Google.
3.  **Call Backend:** Send this `googleToken` to the API.

## Request Body

```json
{
  "googleToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6Ij..." // The long JWT ID Token from Google
}
```

## Response

### ✅ Success (200 OK)
The server validates the token with Google directly.
- **New User:** Account is auto-created.
- **Existing User:** Logged in immediately.

```json
{
    "success": true,
    "message": "Google Login successful",
    "data": {
        "name": "Mohamed Hisham",
        "email": "mh@example.com",
        "role": "User",
        "accessToken": "eyJhbGciOiJIUzI1NiIs..." // Backend JWT needed for other APIs
    },
    "errors": null
}
```

### ❌ Failure Cases

**1. Invalid Token:**
```json
{
    "success": false,
    "message": "Google Authentication Failed: JWT signature verification failed.",
    "data": null,
    "errors": null
}
```

## Flutter Implementation Example

You do **NOT** need to sign in to Firebase. Just get the token from Google and send it to our API.

```dart
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> loginWithGoogle() async {
  try {
    // 1. Trigger Google Sign In
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    
    if (googleUser == null) return; // User canceled

    // 2. Get the Auth Details (ID Token)
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final String? idToken = googleAuth.idToken;

    if (idToken == null) {
      print("Failed to get ID Token");
      return;
    }

    // 3. Send to Backend API
    final response = await http.post(
      Uri.parse('https://your-api.com/api/v1/Auth/google-login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'googleToken': idToken
      }),
    );

    print("Response: ${response.body}");

  } catch (error) {
    print("Google Sign In Error: $error");
  }
}
```
