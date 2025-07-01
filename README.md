# TimeForge

[English Below - توضیحات فارسی در ابتدا]

---

![WebSift Logo](https://github.com/Argh94/TimeForge/blob/main/2.png)
---

## توضیحات فارسی

### معرفی
**TimeForge** یک اسکریپت Bash ساده و حرفه‌ای است که به شما امکان می‌دهد به راحتی یک مخزن (Repository) جدید در گیت‌هاب بسازید و اولین کامیت آن را با تاریخ دلخواه (بین سال‌های ۲۰۰۰ تا ۲۰۲۵) ثبت کنید. این ابزار مخصوص برنامه‌نویسان و توسعه‌دهندگانی طراحی شده که می‌خواهند تاریخچه سفارشی برای پروژه‌های خود ایجاد کنند یا برای اهداف تستی، آموزشی و... به تاریخ‌های دلخواه نیاز دارند.

---

### ویژگی‌ها

- نصب خودکار وابستگی‌ها (git و curl) برای سیستم‌عامل‌های مختلف (Linux، Termux، MacOS)
- رابط کاربری منویی و زیبای خط فرمان
- قابلیت انتخاب سال کامیت (۲۰۰۰ تا ۲۰۲۵)
- تنظیم هویت گیت (Git user.name و user.email) به طور خودکار
- امکان افزودن پیام سفارشی به README.md
- پاکسازی کامل داده‌های موقت پس از اتمام عملیات
- کاملاً رایگان و متن‌باز

---

### شروع سریع

#### اجرای مستقیم با Curl (بدون نیاز به کلون کردن مخزن)
```bash
bash <(curl -s https://raw.githubusercontent.com/argh94/TimeForge/main/script.sh)
```

#### یا کلون کردن مخزن و اجرای دستی
```bash
git clone https://github.com/argh94/TimeForge.git
cd TimeForge
chmod +x script.sh
bash ./script.sh
```

---

### راهنما و مراحل کار اسکریپت

1. **نصب وابستگی‌ها:**  
   اسکریپت به طور خودکار بررسی می‌کند که `git` و `curl` نصب باشند و در صورت نیاز آن‌ها را نصب می‌کند.

2. **نمایش منو:**  
   سه گزینه اصلی:
   - ساخت مخزن با تاریخ دلخواه
   - حذف اسکریپت و داده‌های مربوطه
   - خروج

3. **ساخت مخزن با تاریخ سفارشی:**  
   اطلاعات زیر را از شما می‌پرسد:
   - سال مورد نظر (۲۰۰۰ تا ۲۰۲۵)
   - توکن دسترسی گیت‌هاب (Personal Access Token)
   - نام کاربری گیت‌هاب
   - نام مخزن (Repository)

   سپس README.md را ایجاد کرده، اولین کامیت را با تاریخ انتخاب‌شده ثبت و به مخزن push می‌کند.

---

### نکات مهم

- قبل از استفاده، باید یک مخزن خالی در گیت‌هاب بسازید و توکن دسترسی با سطح دسترسی `repo` ایجاد کنید.
- اطلاعات توکن را ایمن نگه دارید و در اختیار دیگران قرار ندهید.
- اگر با خطا مواجه شدید، از اعتبارسنجی اطلاعات ورودی و سطح دسترسی توکن مطمئن شوید.

---

### ارتباط با نویسنده

- نویسنده: **Argh94**
- گیت‌هاب: [https://github.com/argh94/TimeForge](https://github.com/argh94/TimeForge)

---

## English Guide

### Introduction

**TimeForge** is a simple yet professional Bash script that helps you easily create a new GitHub repository and make the first commit with a custom date (between 2000 and 2025). Designed for developers and testers who need to customize their repository history for demo, educational, or testing purposes.

---

### Features

- Automatic installation of dependencies (`git` and `curl`) for various platforms (Linux, Termux, MacOS)
- Beautiful and user-friendly CLI menu
- Choose any commit year (2000–2025)
- Automatically sets Git identity (`user.name` and `user.email`)
- Option to add a custom message to `README.md`
- Cleans up all temporary data after execution
- Fully free and open-source

---

### Quick Start

#### Run Directly Using Curl (No Need to Clone)
```bash
bash <(curl -s https://raw.githubusercontent.com/argh94/TimeForge/main/script.sh)
```

#### Or Clone the Repository and Run Manually
```bash
git clone https://github.com/argh94/TimeForge.git
cd TimeForge
chmod +x script.sh
bash ./script.sh
```

---

### How Script Works

1. **Dependency Installation:**  
   The script checks if `git` and `curl` are installed, and installs them automatically if needed.

2. **Menu UI:**  
   Three main options:
   - Create a repository with a custom date
   - Delete the script and related data
   - Exit

3. **Create Repository with Custom Date:**  
   The script asks for:
   - Desired year (2000–2025)
   - GitHub Personal Access Token
   - Your GitHub username
   - Repository name

   Then it generates a `README.md`, commits it with the custom date, and pushes to your repository.

---

### Notes

- Before usage, create an empty repository on GitHub and generate a Personal Access Token with `repo` scope.
- Keep your token secure and do not share it.
- If you encounter errors, check your inputs and token permissions.

---

### Author

- Author: **Argh94**
- GitHub: [https://github.com/argh94/TimeForge](https://github.com/argh94/TimeForge)

---

**Enjoy using TimeForge!**
