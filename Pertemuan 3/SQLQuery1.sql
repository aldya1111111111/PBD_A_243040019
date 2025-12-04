--menapilkan semua data pada tabel produk 
SELECT *
FROM Production.Product;

--menampilkan name, productNumber, dan listprice 
SELECT Name, ProductNumber, ListPrice
FROM Production.Product;

--menampilkan data menggunakan alias kolom 
SELECT Name As [Nama Barang], Listprice AS 'Harga Jual'
FROM Production.Product;

--manampilkan hargabaru = ListPrice * 1.1
SELECT Name, Listprice, (ListPrice * 1.1) AS HargaBaru
FROM Production.Product;

--menampilkan data dengan menggabungkan strinng
SELECT Name + '(' + ProductNumber + ')' AS ProductLengkap
FROM Production.Product;

--Filterisasi data 
--menampilkan produk yang berwarna 'red'
SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color = 'red';

--menampilkan produk yang Listprice nya lebih dari 1000
SELECT Name, ListPrice
FROM  Production.Product
WHERE ListPrice < 1000;

--menampilkan produk yang berwarna black dan list price nya lebih dari 200
SELECT Name, Color, ListPrice 
FROM Production.Product
WHERE Color = 'black' AND ListPrice > 500;

--menapilkan produk yang berwarna red, blue, atau black 
SELECT Name, Color
FROM Production.Product
WHERE  Color IN ('red', 'blue', 'black');

--menampilkan  produk yang namanya mengandung kata 'road'
SELECT Name, ProductNumber
FROM  Production.Product
WHERE Name LIKE '%Road%';

--agregasi dan pengelompokan 
--menghitung total baris
SELECT COUNT (*) AS TotalProduk
FROM Production.Product;

--menampilkan warna produk dan jumlahnya 
SELECT Color, COUNT(*) AS JumlahProduk
FROM Production.Product
GROUP BY Color;

--menampilkan produkID, jumlah orderQty, dan rata rata  UnitPrice 
SELECT ProductID, SUM(OrderQty) AS Totalterjual, AVG(UnitPrice) AS RataRataHarga 
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

SELECT*
FROM Sales.SalesOrderDetail

--menampilkan data dengan grouping lebih dari satu kolom
SELECT Color, Size, COUNT(*) AS Jumlah 
FROM Production.Product
GROUP BY Color, Size;

SELECT*
FROM Production.Product

--filter hasil agregasi
--menampilkan warna product yang jumlahnya lebih dari 20
SELECT Color, COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color
HAVING COUNT(*) >2;

--menampilkan warna produk yang ListPrice nya  >500 dan jumlahnya itu > 10
SELECT Color, COUNT(*) AS Jumlah
FROM Production.Product
WHERE ListPrice > 500
GROUP BY Color
HAVING COUNT(*) < 10;

--menampilkkan ProductID yang jumlah OrderQTynya lebih dari 100
SELECT ProductID, SUM (OrderQty) AS RataRataBeli
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 10;

--menampilkan SpesialOfferID yang rata rata OrderQty nya kurang dari 2
SELECT SpecialOfferID, AVG(OrderQty) AS RataRataBeli
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID
HAVING AVG(OrderQty) > 2;

--menampilkan warna yang ListPrice nya lebih dari 3000 menggunakan MAX 
SELECT Color
FROM Production.Product
GROUP BY Color 
HAVING MAX (ListPrice) > 3000;

--advanced select dan order by 
--menampilkan JobTitle tanpa duplikat 
SELECT DISTINCT  JobTitle 
FROM HumanResources.Employee;

SELECT JobTitle
FROM HumanResources.Employee;

--menampilkan 5 produk termahal (termahal DESC, termurah ASC)
SELECT TOP 5 Name, ListPrice 
FROM Production.Product
ORDER BY ListPrice DESC;

--offset fetch 
SELECT Name, ListPrice 
FROM Production.Product
ORDER BY ListPrice DESC 
OFFSET 2 ROWS
FETCH NEXT 4 ROWS ONLY;

SELECT Name, ListPrice 
FROM Production.Product
ORDER BY ListPrice DESC

SELECT TOP 3 Color, SUM(ListPrice) AS TotalNilaiStok
FROM Production.Product
WHERE ListPrice > 0
GROUP BY Color
ORDER BY TotalNilaiStok DESC;


--TUGAS MANDIRI

-- 1.
SELECT ProductID,SUM(LineTotal) AS TotalUang -- menampilkan ProductID & LineTotal AS TotalUang dan setiap kelompok produk, SQL melakukan SUM(LineTotal).
FROM Sales.SalesOrderDetail -- SQL mengambil semua data dari kolom SalesOrderDetail.
GROUP BY ProductID; -- Mengelompok kan baris berdasarkan ProductID.

-- 2. 
SELECT ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan ProductID dan total uang, lalu menghitung total per produk dari baris yang sudah lolos filter.
FROM Sales.SalesOrderDetail -- Ambil semua data dari SalesOrderDetail.
WHERE OrderQty >= 2 -- SQL menyaring baris � hanya transaksi dengan OrderQty minimal 2 yang diproses.
GROUP BY ProductID; -- Setelah disaring, data dikelompokkan berdasarkan ProductID.

-- 3.
SELECT ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan total uang dari tiap produk.
FROM Sales.SalesOrderDetail -- Mengambil data dari SalesOrderDetail.
WHERE OrderQty >= 2 -- Filter: hanya transaksi dengan jumlah beli minimal 2.
GROUP BY ProductID; -- Mengelompokkan berdasarkan ProductID (tahap inti dari nomor 3).


-- 4.
SELECT ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan ProductID & total pendapatan.
FROM Sales.SalesOrderDetail -- Mengambil data dari tabel SalesOrderDetail.
WHERE OrderQty >= 2 -- Filter awal: hanya transaksi OrderQty >= 2.
GROUP BY ProductID -- SQL mengelompokkan baris berdasarkan ProductID.
HAVING SUM(LineTotal) > 50000; -- Filter hasil agregasi: hanya produk dengan total > 50.000.


-- 5.
SELECT ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan ProductID & total pendapatan.
FROM Sales.SalesOrderDetail -- Sumber data SalesOrderDetail.
WHERE OrderQty >= 2 -- Filter baris sebelum pengelompokan.
GROUP BY ProductID -- Kelompokkan per produk.
HAVING SUM(LineTotal) > 50000 -- Filter hasil agregasi.
ORDER BY TotalUang DESC; -- Mengurutkan dari pendapatan terbesar ke terkecil.


-- 6.
SELECT TOP 10 ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan 10 produk dengan pendapatan tertinggi.
FROM Sales.SalesOrderDetail -- Mengambil semua data transaksi.
WHERE OrderQty >= 2 -- Filter transaksi dengan OrderQty minimal 2.
GROUP BY ProductID -- Mengelompokkan baris berdasarkan ProductID.
HAVING SUM(LineTotal) > 50000 -- Hanya produk dengan total uang > 50.000.
ORDER BY TotalUang DESC; -- Urutkan dari total pendapatan tertinggi.