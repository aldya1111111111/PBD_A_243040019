USE KampusDB 

--SUBQUERY
--Menampilkan daosen yang mengajar di mata kuliah bais data
SELECT NamaDosen
FROM Dosen
WHERE DosenID = (
	SELECT DosenID
	FROM MataKuliah
	WHERE NamaMK = 'Basis Data'
);
 --Menampilkan mahasiawa yang menampilkan nilai A
 SELECT NamaMahasiswa
 FROM Mahasiswa
 WHERE MahasiswaID IN (
	SELECT MahasiswaID
	FROM Nilai
	WHERE NilaiAkhir = 'A'
);

--Menampilkan Daftar prodi yang Mahasiswanya >2
SELECT Prodi, TotalMhs
FROM (
	SELECT Prodi, COUNT(*) AS TotalMhs
	FROM Mahasiswa
	GROUP BY Prodi
)AS HitungMhs
WHERE TotalMhs >2;

--Menampilkan mata kuliah (NamaMK) yang diajar oleh dari prodi informatika
SELECT NamaMK
FROM Matakuliah
WHERE DosenID IN (
	SELECT DosenID
	FROM Dosen
	WHERE Prodi = 'Informatika'
);

--CTE
--CTE Untuk daftar mahasiswa informatika 
WITH MhsIF AS (
	SELECT * 
	FROM Mahasiswa
	WHERE Prodi = 'informatika'
)
SELECT NamaMahasiswa, Angkatan
FROM MhsIF

--CTE Untuk Menghitung jumlah mahasiswa per prodi
WITH JumlahPerProdi AS (
	SELECT Prodi, COUNT(*) AS TotalMahasiswa
	FROM Mahasiswa
	GROUP BY Prodi
)
SELECT *
FROM JumlahPerProdi;

--SET OPERATION
--UNION: Menggabungkan daftar nama dosen dan nama mahsiawa
SELECT NamaDosen AS Nama
FROM Dosen
UNION
SELECT NamaMahasiswa
FROM Mahasiswa;


--UNION ALL: Menggabungkan ruangan yang kapasitasnya >40 dan <40
SELECT KodeRuangan, Kapasitas
FROM Ruangan
WHERE Kapasitas > 40
UNION ALL
SELECT KodeRuangan, Kapasitas
FROM Ruangan
WHERE Kapasitas < 40

--INTERSECT: Mahasiswa yang ada di tabel KRS DAN tabel nilai
SELECT MahasiswaID
FROM KRS
SELECT MAhasiswaID
FROM Nilai

--EXCEPT: Mahasiswa yang terdapat di tabel KRS tapi belum memiliki nilai
SELECT MahasiswaID
FROM KRS
EXCEPT
SELECT MAhasiswaID
FROM Nilai

--ROLLUP: Rollup Jumlah Mahasiswa per prodi dan total keseluruhan
SELECT Prodi, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa 
GROUP BY ROLLUP(Prodi);

--CUBE: Jumlah Mahasiswa Berdasarkan prodi dan angkatan
SELECT Prodi, Angkatan, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY CUBE (Prodi, Angkatan) 

--GROUPING SETS
--Total mahasiswa berdasarkan prodi, angkatan, dan total keseluruhan
SELECT Prodi, Angkatan, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY GROUPING SETS(
	(Prodi), --Suntotal per prodi
	(Angkatan), --Suntotal perangkatan
	() --grend total/total mahasiswanya
);

--Window FUNCTION
--Menampilkan Mahasiswa + total Mahasiswa di Prodi yg sama 
SELECT
	NamaMahasiswa,
	Prodi, 
	COUNT(*) OVER (PARTITION BY Prodi) AS TotalMahasiswaPerProdi
FROM Mahasiswa
