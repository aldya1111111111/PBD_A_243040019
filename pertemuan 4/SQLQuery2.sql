USE KampusDB;

--CROSS JOIN
--Menampilkan semua kombinasi Mahasiswa dan Matajuliah
SELECT NamaMahasiswa FROM Mahasiswa
SELECT NamaMK FROM Matakuliah

SELECT M.NamaMahasiswa, MK.NamaMK
FROM Mahasiswa AS M
CROSS JOIN Matakuliah AS MK;

--Menampilkan Semua Kombinasi Dosen dan Ruangan
SELECT NamaDosen FROM Dosen
SELECT KodeRuangan FROM Ruangan;

SELECT D.NamaDosen, R.KodeRuangan
FROM Dosen D
CROSS JOIN Ruangan R;

-- LEFT JOIN
-- Menambahkan Semua mahasiswa, termasuk yang belum ambil KRS
SELECT M.NamaMahasiswa, K.MatakuliahID
FROM Mahasiswa M
LEFT JOIN KRS K ON M.MahasiswaID = K.MahasiswaID;

--Menanpilkan Senua Matakuliah, Termasuk yang belum mempunyai jadwal
SELECT MK.NamaMK, j.Hari
FROM Matakuliah MK
LEFT JOIN JadwalKuliah J ON MK.MatakuliahID = J.MatakuliahID;

--RIGHT JOIN 
--Menapilkan semua jadwal, walaupun tidak ada matakuliah
SELECT MK.NamaMK, J.Hari
FROM Matakuliah MK
RIGHT JOIN JadwalKuliah J ON MK.MatakuliahID = J.MatakuliahID;

--Menampilkan Semua ruangan, apakah dipakai di jadwal atau tidak
SELECT R.KodeRuangan, J.Hari
FROM JadwalKuliah J
RIGHT JOIN Ruangan R ON J.RuanganID = R.RuanganID;

--INNER JOIN
--Menampilkan gabungan tabel mahasiswa + matakuliah melalui tabel KRS
SELECT M.NamaMahasiswa, MK.NamaMK
FROM KRS K
INNER JOIN Mahasiswa M ON K.MahasiswaID = M.MahasiswaID
INNER JOIN Matakuliah MK ON K.MataKuliahID = MK.MataKuliahID;

--Menampilkan matakuliah dan dosen pengampunya
SELECT MK.NamaMK, D.NamaDosen
FROM Matakuliah MK
JOIN Dosen D ON MK.DosenID = D.DosenID;

--Menampilkan Jadwal lengkap mata kuliah + Dosen + Rungan
SELECT MK.NamaMK,D.NamaDosen, R.KodeRuangan, J.Hari
FROM JadwalKuliah J
INNER JOIN MataKuliah MK ON J.MataKuliahID = MK.MataKuliahID
INNER JOIN Dosen D ON J.DosenID = D.DosenID
INNER JOIN Ruangan R ON J.RuanganID = R. RuanganID;

--Menampilkan Nama Mahasiswa, Nama Matakuliah, dan Nilai akhir
SELECT M.NamaMahasiswa, MK.NamaMK, N.NilaiAkhir
FROM Nilai N
INNER JOIN Mahasiswa M ON N.MahasiswaID = M.MahasiswaID
INNER JOIN MataKuliah MK ON N.MataKuliahID = MK.MataKuliahID;

--Menampilkan dosen dan Matakuliah yang diajar
SELECT  D.NamaDosen, MK.NamaMK
FROM Dosen D
INNER JOIN MataKuliah MK ON D.DosenID = MK.DosenID;

--DELF JOIN
--Mencari pasangan dari prodi yang sama
SELECT A.NamaMahasiswa AS Mahasiswa1,
		B.NamaMahasiswa AS Mahasiswa2,
		A.Prodi
FROM Mahasiswa A
INNER JOIN Mahasiswa B ON A.prodi = B.prodi
WHERE A.MahasiswaID < B.MahasiswaID; --Agar tidak ada pasangan yang sama

--LATIHAN
--1.Tampilkan nama mahasiswa (NamaMahasiswa) beserta prodi-nya (Prodi) dari tabel Mahasiswa,tetapi hanya mahasiswa yang memiliki nilai di tabel Nilai.

--2.Tampilkan nama dosen(NamaDosen) dan ruangan(KodeRuangan) tempat dosen tersebut mengajar

--3. Tampilkan daftar mahasiswa (NamaMahasiswa) yang mengambil suatu mata kuliah(NamaMK) beserta nama mata kuliah dan dosen pengampu-nya(NamaDosen)

--4. Tampilkan jadwal kuliah berisi nama mata kuliah(NamaMK), nama dosen(NamaDosen), dan hari kuliah(Hari) tetapi tidak perlu menampilkan ruangan.

--5. Tampilkan nilai mahasiswa(NilaiAkhir) lengkap dengan nama mahasiswa(NamaMahasiswa) nama mata kuliah (NamaMK) , nama dosen pengampu(NamaDosen) dan nilai akhirnya(NilaiAkhir) 