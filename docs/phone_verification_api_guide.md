# Confirm Phone Verification API Guide

This endpoint is used to finalize the phone authentication process securelly. It should be called **after** the frontend has successfully verified the user's phone number via Firebase SDK.

## Endpoint Details
*   **URL:** `/api/v1/Auth/confirm-phone-verification`
*   **Method:** `POST`
*   **Content-Type:** `application/json`

## Workflow for Frontend
1.  **User Enters Phone:** User inputs phone number in the app.
2.  **Verify with Firebase:** App uses Firebase SDK to verify the phone number (sends SMS, user enters OTP).
3.  **Get ID Token:** Upon successful verification, the Firebase SDK returns a `UserCredential` object. You must extract the **ID Token** (JWT) from this user object.
    *   *Note:* This is **NOT** the SMS code. It is a long JWT string obtained via `user.getIdToken()`.
4.  **Call Backend:** Send the `phone` and this `firebaseToken` to this endpoint.

## Request Body

```json
{
  "phone": "+201007932894",        // The phone number verified
  "firebaseToken": "eyJhbGciOi..." // The Firebase ID Token (JWT)
}
```

## Response

### ✅ Success (200 OK)
The server validates the token with Firebase. If valid, it logs the user in and returns their implementation details + Access Token.

```json
{
    "success": true,
    "message": "Phone verified successfully",
    "data": {
        "name": "Mohamed Hisham",
        "email": "mh6285436@gmail.com",
        "phone": "01007932894",
        "fcmToken": "eI3WHy2pSfOECji8zV3RLF...",
        "role": "User",
        "accessToken": "eyJhbGciOiJIUzI1NiIs..." // Backend JWT for API Access
    },
    "errors": null
}
```

### ❌ Failure Cases (400 Bad Request)

**1. Missing or Empty Token:**
```json
{
    "success": false,
    "message": "Security Breach: Missing Verification Token.",
    "data": null,
    "errors": null
}
```

**2. Invalid/Expired Token (Spoofing Attempt):**
```json
{
    "success": false,
    "message": "Secure Verification Failed: Firebase ID token has incorrect \"aud\" (audience) claim...",
    "data": null,
    "errors": null
}
```

**3. User Not Found:**
```json
{
    "success": false,
    "message": "User not found",
    "data": null,
    "errors": null
}
```
