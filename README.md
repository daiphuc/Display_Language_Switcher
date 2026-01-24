- Chức năng: chuyển đổi ngôn ngữ windows 11 áp dụng tất cả phiên bản cả Home Single Language / Pro / Enterprise
- Cấu trúc folder:
W10_11LangPack (Tool tải gói ngôn ngữ) 
DisplayLanguageSwitcher.cmd
FOD (chứa file ngôn ngữ chính)
    |_ 22H2
    |_ 23H2
    |_ ......
LangPack: (chứa file ngôn ngữ cho menu /  speech ....) 
    |_ 22H2
    |_ 23H2
    |_ ......
- Hướng dẫn:
  + Dùng script  trong folder "W10_11LangPack" tải ngôn ngữ về, tạo folder version windows tương ứng với gói ngôn ngữ như trên.
  + Để tối ưu thời gian triển khai chỉ nên dùng 2 file Microsoft-Windows-LanguageFeatures-Basic-xxx-Package-xxx.cab (FOD) và Microsoft-Windows-Client-LanguagePack-Package_xxx.cab (LangPack) các gói còn lại sau khi đổi chuyển ngôn ngữ thì vô trong cài đặt windows/languagle để tải cho nhanh.
  
