# SoalShift_Modul1_F06

## Soal 1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah
dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah
nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh
file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari
jumat pada bulan Februari.
</br>Hint: Base64, Hexdump
### Penyelesaian
Hal pertama yang harus dilakukan adalah
</br>` unzip nature.zip `
</br>setelah itu setiap file yang terdapat di dalam folder nature di dekripsi dengan menggunakan base64 dan xxd untuk me reverse perintah yang ada, seperti dibawah ini
</br>` base 64 -d $name | xxd -r > nature/pictures"$x".jpg`
</br>Untuk waktu yang ditentukan, kita dapat menggunakan crontab. Karena terdapat 2 kemungkinan, yaitu 14 Februari atau hari jumat pada bulan Februari, maka kita buat 2 crontab untuk ini, `14 14 14 2 *` dan `14 14 * 2 5`
</br>[source code soal 1](soal1.sh)
## Soal 2
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:
</br>a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
</br>b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.
</br>c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.
### Penyelesaian
Pada soal ini, hal-hal yang perlu digunakan adalah
..* awk, karena hal ini berhubungan dengan sebuah data yang akan diambil informasinya, oleh karena itu dibutuhkan awk untuk menyelesaikannya
..* FS (Field Separator), dengan menggunakan field separator, kita dapat membedakan tiap kolom berdasarkan yang dibutuhkan, dimana pada soal ini menggunakan ","
..* array\[\], karena dibutuhkan array untuk menyimpan total dari tiap quantity, antar negara, product line, maupun product pada file yang diberikan
..* sort, pada hal ini sort digunakan untuk mengurutkan quantity agar mendapatkan nilai terbesar pada file
</br>[source code soal 2](soal2.sh)
## Soal 3
Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:
</br>a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt
</br>b. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.
</br>c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.
</br>d. Password yang dihasilkan tidak boleh sama.
### Penyelesaian
Pada soal ini yang perlu kikta perhatikan adalah file harus terurut mulai dari "password1", "password2", dst. Oleh karena itu kita perlu membuat variabel yang menyimpan counter dari file. Setelah itu dengan menggunakan looping while untuk mengecek apabila ada password yang tidak terisi (misalkan terdapat password1, password3 tapi tidak ada password2 karena telah dihapus sebelumnya), dan apabila ada maka kita menggenerate password baru pada urutan yang tidak terisi. Pada penggunaan random generator, kita menggunakan `/dev/urandom` dengan isinya terdiri atas a-z, A-Z, dan 0-9. Untuk membatasi random generator tersebut, kita menggunakan `head` dengan jumlah karakternya 12 (`c12`).
</br>[source code soal 3](soal3.sh)
## Soal 4
Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-
bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string
manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:
</br>a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan ukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki rutan ke 12+2 = 14.
</br>b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke mpat belas, dan seterusnya.
</br>c. setelah huruf z akan kembali ke huruf a
</br>d. Backup file syslog setiap jam.
</br>e. dan buatkan juga bash script untuk dekripsinya.
### Penyelesaian
Pada soal, kita mengubah urutan huruf a-z dan A-Z berdasarkan jam kita menjalankan script, dari sini kita mengambil jam dengan menggunakan
</br>`date \"+%H\"`
</br>lalu untuk perubahan hurufnya, kita menggunakan `tr` untuk mengubah tata aturan pada urutan a-z dan A-Z menjadi aturan baru yaitu
</br> `a+$jam s/d z, a s/d a+$jam-1` dan `A+$jam s/d Z, A s/d A+$jam-1`
</br>dimana kita memanfaatkan ASCII dalam menambahkan nilainya.
</br>Sedangkan untuk bagian dekripsinya, hal yang peling penting adalah mengubah nilai dari `$jam` pada hal di atas menjadi `26-$jam`.
</br>Untuk dilakukan setiap jam, maka dapat kita gunakan crontab `@hourly`.
</br>[source code soal 4](soal4.sh)
</br>[source code dekripsi soal 4](soal4dec.sh)
## Soal 5
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:
</br>a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, erta buatlah pencarian stringnya tidak bersifat case sensitive,sehingga huruf kapital atau tidak, tidak menjadi masalah.
</br>b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.
</br>c. Masukkan record tadi ke dalam file logs yang berada pada direktori/home/user/modul1.
</br>d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh13:02, 13:08, 13:14, dst.
### Penyelesaian
Pada soal no.5 yang perlu kita gunakan adalah `awk` dengan menggunakan `\\..\\` untuk menentukan kata apa yang perlu dicari dan menambahkan "!" didepannya untuk kata yang tidak dicari, lalu agar tidak Case-Sensitive (a dan A disamakan) kita tambahkan `grep -i` untuk meng-ignore case nya apakah *uppercase* atau *lowercase*. Untuk mengatur baris yang akan ditunjukkan, kita dapat menggunakan `NF` atau *number of field*.
</br>Untuk pengerjaan setiap 6 menit dari menit 2 s/d 30, dapat kita gunakan crontab `2-30/6 * * * *`
</br>[source code soal 5](soal5.sh)
## Crontab
Berikut adalah crontab dari soal no 1, 4 dan 5
</br>[Crontab dari soal 1,4,5](crontab.txt)
