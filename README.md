# FinalProjectKelompok9

## Deskripsi Proyek

FinalProjectKelompok9 adalah project akhir dari program Studi Independen Bersertifikat MSIB Batch 6 yang diadakan oleh Kampus Merdeka di Metrodata Academy, Data Engineer With SQL Approach. Project ini membangun Employee Management System (EMS) database untuk membantu perusahaan dalam mencatat informasi karyawan secara terstruktur dan efisien. EMS database dibangun menggunakan SQL Server

## Struktur Proyek

Proyek ini terdiri dari beberapa folder dan file penting:

- **Query Final Project Kel 9/**: Berisi berbagai query SQL yang mencakup:
  - Inisiasi database (Creat Database, Create Tabel, dan Add Constraint)
  - Insert data untuk semua table
  - Stored procedures 
  - Functions-function 
  - Views dari semua table 
  - Trigger 

- **Dokumentasi Final Project Kel 9.xlsx**: Berisi detail lengkap tentang proyek, termasuk:
  - Overview EMS Database 
  - Requirement 
  - Supporting Document 
  - Database Diagram 
  - Data dictionary
  - Screenshoot Result from SQL Query

## Prasyarat

Sebelum memulai, pastikan Anda memiliki hal-hal berikut:

- SQL Server terinstal di perangkat 
- SQL Server Management Studio (SSMS) atau alat klien SQL lainnya
- Pemahaman dasar tentang SQL

## Instalasi

1. **Clone repositori:**
   ```sh
   git clone https://github.com/annisacahyanisurya/FinalProjectKelompok9.git
   cd FinalProjectKelompok9

## Penggunaan

### Menjalankan Stored Procedures

Proyek ini berisi beberapa stored procedures yang dapat digunakan untuk berbagai operasi manajemen karyawan. Berikut adalah contoh cara menjalankan stored procedures dari folder `Query Final Project Kel 9`:

1. **usp_add_country**: Untuk menambahkan data negara ke dalam Tabel Countries. 
   ```sql
   EXEC dbo.usp_add_country('IND','Indonesia','3');

### Menggunakan User Defined Functions

Mencakup beberapa user defined functions yang mendukung agar stored procedures berjalan. Berikut adalah contoh cara menggunakan user defined functions:

1. **func_country_format**: Untuk memastikan bahwa value input atau nama negara tidak boleh mengandung karakter spesial. Function akan mengembalikan nilai 1 apabila sesuai dengan requirement dan akan mengembalikan nilai 0 apabila input value salah. 
 ```sql
   SELECT dbo.func_country_format('Indonesia');

### Melihat Data menggunakan Views

Views dapat digunakan untuk melihat data yang ada dalam format yang lebih terstruktur. Berikut adalah contoh cara menggunakan views

1. **vw_employee_details**: 






