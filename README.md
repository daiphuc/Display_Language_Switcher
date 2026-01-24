# Display Language Switcher for Windows 11
## Overview
Tool chuyển đổi ngôn ngữ Windows 11, hỗ trợ tất cả phiên bản:
- Home / Home Single Language
- Pro
- Enterprise
Script tự động cài đặt Language Pack và Feature on Demand (FOD).
---
## Directory Structure
.
├── DisplayLanguageSwitcher.cmd # Script chuyển đổi ngôn ngữ
├── W10_11LangPack/ # Tool tải gói ngôn ngữ
├── FOD/ # Feature on Demand (Basic language)
│ ├── 22H2/
│ ├── 23H2/
│ └── ...
└── LangPack/ # Language Pack (UI / Speech / OCR ...)
├── 22H2/
├── 23H2/
└── ...
---
## Usage
### 1. Download language packages
Chạy script trong thư mục `W10_11LangPack` để tải gói ngôn ngữ.
Tạo thư mục theo phiên bản Windows tương ứng, ví dụ:
FOD/23H2/
LangPack/23H2/
---
### 2. Required packages (recommended)
Để tối ưu thời gian triển khai, chỉ cần sử dụng 2 file sau:
**FOD (Basic language):**
Microsoft-Windows-LanguageFeatures-Basic-xxx-Package-xxx.cab
**Language Pack (UI language):**
Microsoft-Windows-Client-LanguagePack-Package_xxx.cab
Các gói ngôn ngữ khác (Speech, OCR, Handwriting, Text-to-Speech...)  
có thể tải trực tiếp trong Windows Settings sau khi chuyển đổi ngôn ngữ.
---
## Notes
- Tool hỗ trợ tự động cài đặt và chuyển đổi ngôn ngữ Windows 11.
- Phù hợp triển khai trong môi trường doanh nghiệp / IT deployment.
