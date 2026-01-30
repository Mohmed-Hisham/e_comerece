# Reset Password API Guide

This API now supports "Smart Detection" for resetting passwords via either Email or Phone.

## Endpoint Details
*   **URL:** `/api/v1/Auth/resetpassword`
*   **Method:** `POST`
*   **Content-Type:** `application/json`

## Workflow for Frontend

### Case 1: Resetting via Email
1. Call `forgotpassword` with the Email.
2. User receives a 6-digit OTP in their email.
3. Call `resetpassword` with:
    * `identifier`: The User's Email.
    * `code`: The OTP received.
    * `newPassword`: The new password.

### Case 2: Resetting via Phone
1. Call `forgotpassword` with the Phone number. 
2. Use Firebase SDK in the app to verify the phone number.
3. Obtain the **Firebase ID Token** from Firebase.
4. Call `resetpassword` with:
    * `identifier`: The User's Phone number.
    * `firebaseToken`: The ID Token from Firebase.
    * `newPassword`: The new password.

## Request Body Example

### Email Reset
```json
{
  "identifier": "user@example.com",
  "code": "123456",
  "newPassword": "SecurePassword123"
}
```

### Phone Reset
```json
{
  "identifier": "+201007932894",
  "firebaseToken": "eyJhbGciOi...",
  "newPassword": "SecurePassword123"
}
```

## Response

### ✅ Success (200 OK)
```json
{
    "success": true,
    "message": "Password reset successfully",
    "data": "Success",
    "errors": null
}
```

### ❌ Failure Cases
- **Invalid Code:** If resetting via email and the OTP is wrong.
- **Verification Failed:** If resetting via phone and the Firebase token is invalid/expired.
- **User Not Found:** If the identifier doesn't match any user.
