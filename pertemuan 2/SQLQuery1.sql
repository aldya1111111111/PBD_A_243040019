--Buat Database TokoRetailDB
CREATE DATABASE TokoRetailDB;

--Gunakan DB TokoRetailDB
USE TokoRetailDB;

--Tabel Kategori Produk
CREATE TABLE KategoriProduk(
	KategoriID INT IDENTITY(1,1) PRIMARY KEY,
	NamaKategori VARCHAR(100) NOT NULL UNIQUE
);

--Membuat TABLE Produk
CREATE TABLE Produk(
	ProdukID INT IDENTITY (1001,1) PRIMARY KEY,
	SKU VARCHAR(20) NOT NULL UNIQUE,
	NamaProduk VARCHAR(150) NOT NULL,
	Harga DECIMAL(10,2) NOT NULL,
	Stok INT NOT NULL,
	KategoriID INT NULL,

	--harganya gaboleh negatif
	CONSTRAINT CHK_HargaPositif CHECK (Harga >= 0),
	--stoknya gaboleh negatif
	CONSTRAINT CHK_StokPositif CHECK (Stok >= 0),
	--relasikan dengan tabel KategoriProduk melalui Kategori ID
	CONSTRAINT FK_Produk_Kategori
		FOREIGN KEY (KategoriID)
		REFERENCES KategoriProduk(KategoriID)
);

--memasukan data ke tabel KategoriProduk 
INSERT INTO KategoriProduk (NamaKategori)
VALUES 
('Elektronik');

INSERT INTO KategoriProduk (NamaKategori)
VALUES 
('Pakaian'),
('Buku');

--menampilkan tabel KategoriProduk
SELECT *
FROM KategoriProduk;

--menampilkan tabel NamaKategori
SELECT NamaKategori
FROM KategoriProduk;

--menambahkan tabel nama produk 
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES 
('ELEC-001', 'Laptop gaming', 15000000.00, 50, 2);

INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES 
('ELEC-002', 'HP Gaming', 50000000.00, 50, 1);

--menampilkan tabel produk 
SELECT *
FROM Produk;

--mengubah data stok laptop gaming menjadi 30
UPDATE Produk
SET Stok = 30
WHERE ProdukID = 1001;

--menguba data kategori id dari 2 menjadi 1
UPDATE Produk
SET KategoriID = 1
WHERE ProdukID = 1004;

--menghapus data hp gaming 
BEGIN TRANSACTION;
 
DELETE FROM Produk
WHERE ProdukID = 1004;

COMMIT TRANSACTION;

--menambahkan tabel nama produk 
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES 
('Baju-001', 'Kaos Putih', 50000.00, 30, 2);

INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES 
('Baju-002', 'Kaos Hitam', 50000.00, 30, 2);

--menghapus kaos putih
BEGIN TRAN;

DELETE FROM Produk
WHERE ProdukID = 1014

--mengembalikan yang terhapus
ROLLBACK TRANSACTION

COMMIT TRANSACTION;