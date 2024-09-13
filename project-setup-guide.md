# Create ssh key

## Windows

### 1. Mở PowerShell
### 2. Tạo ssh key bằng lệnh

```powershell
ssh-keygen -t rsa

[//]: # (Không cần nhập passphase, thông tường file sẽ được lưu trữ ở ~/.ssh/id_rsa và ~/.ssh/id_rsa.pub)
```

### 3. Copy nội dung file ~/.ssh/id_rsa.pub
### 4. Đăng nhập vào github.com
### 5. Chọn Settings -> SSH and GPG keys -> New SSH key
### 6. Paste nội dung file ~/.ssh/id_rsa.pub vào ô key
### 7. Nhấn Add SSH key

