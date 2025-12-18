USE KampusDB

--VIEW
--Menampilkan daftar ruang 
CREATE OR ALTER VIEW vw_Ruangan
AS 
SELECT
	KodeRuangan,
	Gedung, 
	Kapasitas
FROM Ruangan;

SELECT * FROM vw_Ruangan;

--View jumlsh mahasiswa per prodi
CREATE OR ALTER VIEW vw_JumlahMahasiswaPerProdi
AS
SELECT
	Prodi,
	COUNT(*) AS JumlahMahasiswa 
FROM Mahasiswa
GROUP BY Prodi;

SELECT * FROM vw_JumlahMahasiswaPerProdi

--View Menampilkan Mahasiswa dan Semester yang diambil
CREATE OR ALTER vw_Mahasiswa_KRS
AS
SELECT
	M.NamaMahasiswa,
	K.Semester
FROM Mahasiswa m
JOIN KRS k ON m.MahasiswaID = K.MahasiswaID;


--STORED PROCEDUR
--Menampilkan semua Mahasiswa
SELECT * FROM vw_Mahasiswa_KRS;

--SP Menambah Mahasiswa Baru
CREATE OR ALTER PROCEDURE sp_TambahMahasiswa
--VARIABEL YANG DI BUTUHKAN
@Nama VARCHAR(100),
@Prodi VARCHAR(50),
@Angkatan INT
AS
BEGIN
	INSERT INTO Mahasiswa (NamaMahasiswa, Prodi, Angkatan)
	VALUES (@Nama, @Prodi, @Angkatan);
END;

--Pemanggilan spnya
EXEC sp_TambahMahasiswa
'Nobita', 'Informatika', 2005;

EXEC sp_TambahMahasiswa
		@Nama = 'suneo',
		@Angkatan = 2023,
		@Prodi = 'Teknik Industri',

--Cek apakah sudah tertambah atau belom
SELECT * FROM Mahasiswa

--TRIGER
--Triger cegah nilai kosong
CREATE OR ALTER TRIGGER trg_CekNilai
ON Nilai --dilakukan di tabel nilai
AFTER INSERT --dilakuin setelah insert
AS
BEGIN
	IF EXISTS (
		SELECT * FROM inserted
		WHERE NilaiAkhir IS NULL
	)
	BEGIN 
	--pesan : nilai tidak boleh kosong 
	--level error : 16 (error karena imput user)
	--state: 1 (penanda error di masseg)
	RAISERROR('Nilai tidak boleh kosong', 16,1)
	ROLLBACK;
	END
END;

--tes trigger
INSERT INTO nilai(MahasiswaID, NilaiAkhir)
VALUES (5, NULL);

--UDF
--fungsi konversi nilai
CREATE OR ALTER FUNCTION fn_IndeksNilai(@Nilai INT)
RETURNS CHAR(1)
AS
BEGIN
	RETURN
	CASE
		WHEN @Nilai >= 85 THEN 'A'
			WHEN @Nilai >= 70 THEN 'B'
				WHEN @Nilai >= 55 THEN 'C'
					WHEN @Nilai >= 40 THEN 'D'
					ELSE 'E'
				END
			END;

SELECT dbo.fn_IndeksNilai(30);

--funngsi cek lulusan atau tidak
CREATE OR ALTER FUNCTION fn_StatusLulus(@Nilai CHAR(2))
RETURNS VARCHAR(20)
AS
BEGIN
	RETURN
	CASE
		WHEN @Nilai IN ('A','B','c')THEN 'LULUS'
		END
	END;

SELECT dbo.fn_StatusLulus('A'); 