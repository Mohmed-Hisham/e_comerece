# 📋 Backend Requirements for SMS/Email Verification System (.NET Core)

---

## 🎯 **Overview**

We need to add a **dual verification method** feature to our e-commerce mobile app (Flutter). Users should be able to choose between receiving OTP codes via **SMS** (Firebase) or **Email** (Server-side) for:

1. **Signup** - New account registration
2. **Login** - Step one authentication  
3. **Forgot Password** - Password reset flow

---

## 🔄 **How It Works**

```
┌─────────────────────────────────────────────────────────────┐
│                    User Flow Diagram                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  User clicks "Sign Up" or "Login" or "Forgot Password"     │
│                          ↓                                  │
│  App shows dialog: "Choose verification method"             │
│         ┌──────────┴──────────┐                            │
│         ↓                     ↓                            │
│      📱 SMS              📧 Email                          │
│         │                     │                            │
│         ↓                     ↓                            │
│  Firebase sends OTP     Backend sends OTP                  │
│  (handled by app)       (handled by server)                │
│         │                     │                            │
│         └──────────┬──────────┘                            │
│                    ↓                                        │
│         User enters OTP code                               │
│                    ↓                                        │
│  ┌─────────────────┴─────────────────┐                     │
│  │ If SMS: App verifies via Firebase │                     │
│  │ If Email: App verifies via API    │                     │
│  └───────────────────────────────────┘                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 📝 **API Changes Required**

### **1. Add `verification_method` Parameter**

All authentication endpoints should accept a new optional parameter:

```csharp
public class AuthRequestDto
{
    // Existing fields...
    public string Email { get; set; }
    public string Phone { get; set; }
    public string Password { get; set; }
    public string Name { get; set; }
    public string Code { get; set; }
    
    // NEW FIELD - Add this
    /// <summary>
    /// Verification method: "email" or "sms"
    /// Default: "email"
    /// </summary>
    public string VerificationMethod { get; set; } = "email";
}
```

---

### **2. Endpoints to Modify**

| Endpoint | Current Behavior | New Behavior |
|----------|------------------|--------------|
| `POST /auth/signup` | Always sends email OTP | Check `verification_method`, send email OTP only if `"email"` |
| `POST /auth/login-step-one` | Always sends email OTP | Check `verification_method`, send email OTP only if `"email"` |
| `POST /forgetpassword/checkemail` | Always sends email OTP | Check `verification_method`, send email OTP only if `"email"` |
| `POST /auth/resend` | Always sends email OTP | Check `verification_method`, send email OTP only if `"email"` |

---

### **3. Logic Implementation**

```csharp
// Example: SignupController.cs

[HttpPost("signup")]
public async Task<IActionResult> Signup([FromBody] SignupRequestDto request)
{
    // Validate request...
    
    // Generate OTP code
    var otpCode = GenerateOtpCode(); // e.g., "12345"
    
    // Save OTP to database (for email verification later)
    await SaveOtpToDatabase(request.Email, otpCode, request.VerificationMethod);
    
    // Check verification method
    if (request.VerificationMethod?.ToLower() == "email")
    {
        // Send OTP via Email (existing logic)
        await _emailService.SendOtpEmail(request.Email, otpCode);
        
        return Ok(new 
        { 
            status = "success",
            message = "Verification code sent to your email",
            data = new { /* user data if needed */ }
        });
    }
    else if (request.VerificationMethod?.ToLower() == "sms")
    {
        // DON'T send anything - Firebase will handle SMS
        // Just save user data and OTP for potential fallback
        
        return Ok(new 
        { 
            status = "success",
            message = "Please verify via SMS",
            data = new { /* user data if needed */ }
        });
    }
    
    // Default to email
    await _emailService.SendOtpEmail(request.Email, otpCode);
    return Ok(new { status = "success", message = "Verification code sent" });
}
```

---

### **4. Forgot Password Endpoint**

```csharp
// ForgetPasswordController.cs

[HttpPost("checkemail")]
public async Task<IActionResult> CheckEmail([FromBody] ForgotPasswordRequestDto request)
{
    // Check if user exists
    var user = await _userService.GetByEmail(request.Email);
    if (user == null)
    {
        return NotFound(new { status = "error", message = "Account not found" });
    }
    
    // Generate OTP
    var otpCode = GenerateOtpCode();
    await SaveOtpToDatabase(request.Email, otpCode, request.VerificationMethod);
    
    if (request.VerificationMethod?.ToLower() == "email")
    {
        // Send via email
        await _emailService.SendPasswordResetOtp(request.Email, otpCode);
        
        return Ok(new 
        { 
            status = "success",
            message = "Reset code sent to your email"
        });
    }
    else if (request.VerificationMethod?.ToLower() == "sms")
    {
        // Don't send - app uses Firebase
        // But we need to return the phone number for the app to use
        
        return Ok(new 
        { 
            status = "success",
            message = "Please verify via SMS",
            data = new 
            { 
                phone = user.Phone // App needs this for Firebase SMS
            }
        });
    }
    
    return Ok(new { status = "success", message = "Verification code sent" });
}
```

---

### **5. Verify Code Endpoint (Important!)**

For **Email verification**, the flow stays the same - app calls your API to verify.

For **SMS verification**, there are **2 options**:

#### **Option A: Firebase-only verification (Recommended - Simpler)**

```csharp
// No changes needed to verifycode endpoint
// App verifies SMS code with Firebase directly
// After Firebase success, app calls a different endpoint to confirm

[HttpPost("confirm-phone-verification")]
public async Task<IActionResult> ConfirmPhoneVerification([FromBody] ConfirmPhoneDto request)
{
    // App calls this AFTER Firebase verification succeeds
    // You can trust it because Firebase already verified the phone
    
    // Mark user as verified
    await _userService.MarkPhoneVerified(request.Email);
    
    // Return auth token
    var token = GenerateJwtToken(user);
    
    return Ok(new 
    { 
        status = "success",
        data = new { token, user }
    });
}
```

#### **Option B: Store & verify OTP on server too (More secure but complex)**

```csharp
// Keep your existing verifycode endpoint
// It works for both email and SMS
// App sends the OTP code regardless of source
```

---

## 📊 **Database Changes (If Needed)**

You might want to track which method was used:

```csharp
public class OtpVerification
{
    public int Id { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public string Code { get; set; }
    public string Method { get; set; } // "email" or "sms"
    public DateTime ExpiresAt { get; set; }
    public bool IsUsed { get; set; }
    public DateTime CreatedAt { get; set; }
}
```

---

## 📱 **Request/Response Examples**

### Signup with Email:

```json
// Request
POST /auth/signup
{
    "name": "Ahmed",
    "email": "ahmed@example.com",
    "phone": "+201234567890",
    "password": "123456",
    "verification_method": "email"
}

// Response
{
    "status": "success",
    "message": "Verification code sent to your email"
}
```

### Signup with SMS:

```json
// Request
POST /auth/signup
{
    "name": "Ahmed", 
    "email": "ahmed@example.com",
    "phone": "+201234567890",
    "password": "123456",
    "verification_method": "sms"
}

// Response
{
    "status": "success",
    "message": "Please verify via SMS"
}
```

### Forgot Password with SMS:

```json
// Request
POST /forgetpassword/checkemail
{
    "email": "ahmed@example.com",
    "verification_method": "sms"
}

// Response
{
    "status": "success",
    "message": "Please verify via SMS",
    "data": {
        "phone": "+201234567890"
    }
}
```

---

## ✅ **Summary Checklist**

- [ ] Add `verification_method` parameter to DTOs
- [ ] Modify `/auth/signup` - conditional email sending
- [ ] Modify `/auth/login-step-one` - conditional email sending  
- [ ] Modify `/forgetpassword/checkemail` - conditional + return phone
- [ ] Modify `/auth/resend` - conditional email sending
- [ ] (Optional) Add `/auth/confirm-phone-verification` endpoint
- [ ] (Optional) Add `Method` column to OTP table

---

## ⚠️ **Important Notes**

1. **SMS verification is handled by Firebase on the app side** - your server doesn't need to send SMS

2. **For SMS flow**: Your API just needs to:
   - NOT send email when `verification_method = "sms"`
   - Return phone number in forgot password flow
   - Trust the app when it confirms Firebase verification

3. **Keep existing email flow working** - `verification_method` defaults to `"email"`

4. **Phone number format**: Make sure phone is stored in international format (`+201234567890`)

---

## 📞 **Contact**

If you have any questions about the implementation, please reach out to the mobile development team.
