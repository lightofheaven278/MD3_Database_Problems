Create Database QuanLyDiemSV CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci;
use QuanLyDiemSV;
/*=============DANH MUC KHOA==============*/
Create table DMKhoa(
	MaKhoa char(2) primary key,
	TenKhoa nvarchar(30)not null
);
/*==============DANH MUC SINH VIEN============*/
Create table DMSV(
MaSV char(3) not null primary key,
HoSV nvarchar(15) not null,
TenSV nvarchar(7)not null,
Phai nchar(7),
NgaySinh datetime not null,
NoiSinh nvarchar (20),
MaKhoa char(2),
HocBong float
);
/*===================MON HOC========================*/
create table DMMH(
MaMH char (2) not null,
TenMH nvarchar (25)not null,
SoTiet tinyint,
Constraint DMMH_MaMH_pk primary key(MaMH)
);
/*=====================KET QUA===================*/
Create table KetQua
(
MaSV char(3) not null,
MaMH char (2)not null ,
LanThi tinyint,
Diem decimal(4,2),
Constraint KetQua_MaSV_MaMH_LanThi_pk primary key (MaSV,MaMH,LanThi)
);
/*==========================TAO KHOA NGOAI==============================*/
Alter table dmsv
add Constraint DMKhoa_MaKhoa_fk foreign key (MaKhoa)
References DMKhoa (MaKhoa);
Alter table KetQua
add constraint KetQua_MaSV_fk foreign key (MaSV) references DMSV (MaSV);
Alter table KetQua
add constraint DMMH_MaMH_fk foreign key (MaMH) references DMMH (MaMH);
/*==================NHAP DU LIEU====================*/
/*==============NHAP DU LIEU DMMH=============*/
Insert into DMMH(MaMH,TenMH,SoTiet)
values('01','Cơ Sở Dữ Liệu',45);
Insert into DMMH(MaMH,TenMH,SoTiet)
values('02','Trí Tuệ Nhân Tạo',45);
Insert into DMMH(MaMH,TenMH,SoTiet)
values('03','Truyền Tin',45);
Insert into DMMH(MaMH,TenMH,SoTiet)
values('04','Đồ Họa',60);
Insert into DMMH(MaMH,TenMH,SoTiet)
values('05','Văn Phạm',60);
/*==============NHAP DU LIEU DMKHOA=============*/
Insert into DMKhoa(MaKhoa,TenKhoa)
values('AV','Anh Văn');
Insert into DMKhoa(MaKhoa,TenKhoa)
values('TH','Tin Học');
Insert into DMKhoa(MaKhoa,TenKhoa)
values('TR','Triết');
Insert into DMKhoa(MaKhoa,TenKhoa)
values('VL','Vật Lý');
/*==============NHAP DU LIEU DMSV=============*/
Insert into DMSV
values('A01','Nguyễn Thị','Hải','Nữ','1990-03-20','Hà Nội','TH',130000);
Insert into DMSV(MaSV,HoSV,TenSV,Phai,NgaySinh,NoiSinh,MaKhoa,HocBong)
values('A02','Trần Văn','Chính','Nam','1992-12-24','Bình Định','VL',150000);
Insert into DMSV(MaSV,HoSV,TenSV,Phai,NgaySinh,NoiSinh,MaKhoa,HocBong)
values('A03','Lê Thu Bạch','Yến','Nữ','1990-02-21','TP Hồ Chí Minh','TH',170000);
Insert into DMSV(MaSV,HoSV,TenSV,Phai,NgaySinh,NoiSinh,MaKhoa,HocBong)
values('A04','Trần Anh','Tuấn','Nam','1990-12-20','Hà Nội','AV',80000);
Insert into DMSV(MaSV,HoSV,TenSV,Phai,NgaySinh,NoiSinh,MaKhoa,HocBong)
values('B01','Trần Thanh','Mai','Nữ','1991-08-12','Hải Phòng','TR',0);
Insert into DMSV(MaSV,HoSV,TenSV,Phai,NgaySinh,NoiSinh,MaKhoa,HocBong)
values('B02','Trần Thị Thu','Thủy','Nữ','1991-01-02','TP Hồ Chí Minh','AV',0);
/*==============NHAP DU LIEU BANG KET QUA=============*/
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A01','01',1,3);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A01','01',2,6);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A01','02',2,6);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A01','03',1,5);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A02','01',1,4.5);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A02','01',2,7);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A02','03',1,10);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A02','05',1,9);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A03','01',1,2);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A03','01',2,5);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A03','03',1,2.5);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A03','03',2,4);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A04','05',2,10);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('B01','01',1,7);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('B01','03',1,2.5);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('B01','03',2,5);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('B02','02',1,6);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('B02','04',1,10);
/*==========================================*/
-- problem 1
SELECT 
    MaSV, CONCAT(HoSV, ' ', TenSV) AS Full_name, HocBong
FROM
    dmsv
ORDER BY Masv;
-- problem 2
SELECT 
    MaSV, CONCAT(HoSV, ' ', TenSV) AS Full_name, Phai, NgaySinh
FROM
    dmsv
ORDER BY Phai;
-- problem 3
SELECT 
    CONCAT(HoSV, ' ', TenSV) AS Full_name, NgaySinh, HocBong
FROM
    dmsv
ORDER BY NgaySinh ASC , HocBong DESC;
-- problem 4
SELECT 
    MaMH, TenMH, SoTiet
FROM
    DMMH
WHERE
    TenMH LIKE 'T%';
-- problem 5
SELECT 
    CONCAT(HoSV, ' ', TenSV) AS Full_name, NgaySinh, Phai
FROM
    dmsv
WHERE
    CONCAT(HoSV, ' ', TenSV) LIKE '%I';
-- problem 6
SELECT 
    MaKhoa, TenKhoa
FROM
    DMKHOA
WHERE
    TenKhoa LIKE '_N%';
-- problem 7
SELECT 
    CONCAT(HoSV, ' ', TenSV) AS Full_name
FROM
    dmsv
WHERE
    HoSV LIKE '%THI%';
-- problem 8
SELECT 
    MaSV, CONCAT(HoSV, ' ', TenSV) AS Full_name, MaKhoa, HocBong
FROM
    dmsv
WHERE
    HocBong > 100000
ORDER BY MaKhoa DESC;
-- problem 9
SELECT 
    CONCAT(HoSV, ' ', TenSV) AS Full_name, MaKhoa, HocBong
FROM
    dmsv
WHERE
    HocBong > 150000 AND NoiSinh = 'Hà Nội';
-- problem 10
SELECT 
    CONCAT(HoSV, ' ', TenSV) AS Full_name, dmsv.MaKhoa, Phai
FROM
    dmsv
        INNER JOIN
    DMKhoa ON dmsv.MaKhoa = DMKhoa.MaKhoa
WHERE
    DMKhoa.TenKhoa = 'Anh văn'
        OR DMKhoa.TenKhoa = 'Vật lý';
-- problem 11
SELECT 
    MaSV, NgaySinh, NoiSinh, HocBong
FROM
    dmsv
WHERE
    NgaySinh BETWEEN '1991-01-01' AND '1992-06-05';
-- problem 12
SELECT 
    MaSV, NgaySinh, Phai, MaKhoa
FROM
    dmsv
WHERE
    HocBong BETWEEN 80000 AND 150000;
-- problem 13
SELECT 
    MaMH, TenMH, SoTiet
FROM
    DMMH
WHERE
    SoTiet BETWEEN 30 AND 45;
-- problem 14
SELECT 
    MaSV, CONCAT(HoSV, ' ', TenSV) AS Full_name, TenKhoa, Phai
FROM
    dmsv
        INNER JOIN
    DMKhoa ON dmsv.MaKhoa = DMKhoa.MaKhoa
WHERE
    Phai = 'Nam'
        AND (TenKhoa = 'Anh văn'
        OR TenKhoa = 'Tin hoc');

-- problem 15
SELECT 
    MaSV, CONCAT(HoSV, ' ', TenSV) AS Full_name, Phai
FROM
    dmsv
WHERE
    CONCAT(HoSV, ' ', TenSV) LIKE '%N%'
        AND Phai = 'Nữ';
-- problem 16
SELECT 
    HoSv, TenSV, NoiSinh, NgaySinh
FROM
    dmsv
WHERE
    NoiSinh = 'Hà Nội'
        AND MONTH(NgaySinh) = 2;
-- problem 17
alter table dmsv add age int;
UPDATE dmsv 
SET 
    age = YEAR(CURRENT_DATE()) - YEAR(NgaySinh)
WHERE
    MaSV IS NOT NULL;
SELECT 
    CONCAT(HoSV, ' ', TenSV) AS Full_name, age, HocBong
FROM
    dmsv
WHERE
    age > 20;
-- problem 18
SELECT 
    CONCAT(HoSV, ' ', TenSV) AS Full_name, Phai, NgaySinh
FROM
    dmsv
WHERE
    age > 20 AND age < 25;
-- problem 19
SELECT 
    CONCAT(HoSV, ' ', TenSV) AS Full_name, Phai, NgaySinh
FROM
    dmsv
WHERE
    (MONTH(NgaySinh) >= 1
        AND MONTH(NgaySinh) <= 3)
        AND YEAR(NgaySinh) = 1990;
-- problem 20
alter table dmsv add ScholarRank varchar(20);
UPDATE dmsv 
SET 
    ScholarRank = 'High'
WHERE
    HocBong > 500000;
UPDATE dmsv 
SET 
    ScholarRank = 'Medium'
WHERE
    HocBong < 500000;
SELECT 
    MaSV, Phai, MaKhoa, ScholarRank
FROM
    dmsv;
-- problem 21
SELECT 
    COUNT(MaSV) as NumberOfStudent
FROM
    dmsv;
-- problem 22
SELECT 
    'Total number of students' AS Desctiption,
    COUNT(MaSV) AS NumberOfStudents
FROM
    dmsv 
UNION SELECT 
    'Total number of female students' AS Desctiption,
    COUNT(MaSV) AS NumberOfStudents
FROM
    dmsv
WHERE
    Phai = 'Nữ';
-- problem 23
SELECT 
    MaKhoa, COUNT(MaSV) AS StudentsOfEachDepartment
FROM
    dmsv
GROUP BY MaKhoa;
-- problem 24
SELECT 
    DMMH.TenMH, COUNT(DISTINCT dmsv.MaSV) AS NumberOfStudent
FROM
    KetQua
        INNER JOIN
    DMMH ON KetQua.MaMH = DMMH.MaMH
        INNER JOIN
    dmsv ON KetQua.MaSV = dmsv.MaSV
GROUP BY DMMH.TenMH;
-- problem 25
SELECT 
    COUNT(DISTINCT KetQua.MaMH) AS TotalSubject
FROM
    KetQua;
-- problem 26
SELECT 
    MaKhoa, SUM(HocBong) AS SumOfScholar
FROM
    dmsv
GROUP BY MaKhoa;
-- problem 27
SELECT 
    MaKhoa, MAX(HocBong) AS MaxOfScholar
FROM
    dmsv
GROUP BY MaKhoa;
-- problem 28
SELECT 
    MaKhoa,
    CASE
        WHEN Phai = 'Nam' THEN COUNT(MaSV)
    END AS NumberOfMale,
    CASE
        WHEN Phai = 'Nữ' THEN COUNT(MaSV)
    END AS NumberOfFemale
FROM
    dmsv
GROUP BY MaKhoa , Phai;
-- problem 29
SELECT 
    age, COUNT(MaSV)
FROM
    dmsv
GROUP BY age;
-- problem 30
SELECT year(NgaySinh) as YearOfBirth, COUNT(MaSV) AS NumberOfStudents
FROM dmsv
GROUP BY YearOfBirth
HAVING COUNT(MaSV) = 2;
-- problem 31
SELECT year(NgaySinh) as YearOfBirth, COUNT(MaSV) AS NumberOfStudents
FROM dmsv
GROUP BY YearOfBirth
HAVING COUNT(MaSV) > 2;
-- problem 32
SELECT 
    KetQua.MaMH AS TookATestStudent,
    COUNT(DISTINCT MaSV) AS NumberOfStudents
FROM
    KetQua
GROUP BY KetQua.MaMH
HAVING COUNT(DISTINCT MaSV) > 3;
-- problem 33
SELECT 
    MaSV AS FailedTestStudent,
    COUNT(DISTINCT MaSV) AS NumberOfStudents
FROM
    KetQua
GROUP BY MaSV
HAVING COUNT(DISTINCT MaSV) > 2;
-- problem 34
SELECT 
    KetQua.MaSV, CONCAT(dmsv.HoSV, ' ', dmsv.TenSV) AS Fullname
FROM
    KetQua
        INNER JOIN
    dmsv ON KetQua.MaSV = dmsv.MaSV
WHERE
    LanThi = 1 AND Diem > 7.0;
-- problem 35
SELECT 
    KetQua.MaSV, CONCAT(dmsv.HoSV, ' ', dmsv.TenSV) AS Fullname
FROM
    KetQua
        INNER JOIN
    dmsv ON KetQua.MaSV = dmsv.MaSV
WHERE
    Lanthi = 2
GROUP BY KetQua.MaSV
HAVING COUNT(MaMH) >= 2;
-- problem 36
SELECT 
    dmsv.MaKhoa,
    DMKhoa.TenKhoa,
    COUNT(dmsv.MaSV) AS NumberOfMaleStudent
FROM
    dmsv
        INNER JOIN
    DMKhoa ON dmsv.MaKhoa = DMKhoa.MaKhoa
WHERE
    dmsv.Phai = 'Nam'
GROUP BY dmsv.MaKhoa
HAVING COUNT(dmsv.MaSV) > 2;
-- problem 37
SELECT 
    dmsv.MaKhoa,
    DMKhoa.TenKhoa,
    COUNT(dmsv.MaSV) AS NumberOfStudent
FROM
    dmsv
        INNER JOIN
    DMKhoa ON dmsv.MaKhoa = DMKhoa.MaKhoa
WHERE
    dmsv.HocBong BETWEEN 80000 AND 300000
GROUP BY dmsv.MaKhoa
HAVING COUNT(dmsv.MaSV) = 1;
-- problem 38
SELECT 
    'PassedStudent' AS Descr,
    COUNT(DISTINCT MaSV) AS NumberOfStudent
FROM
    KetQua
WHERE
    LanThi = 1 
UNION SELECT 
    'FailedStudent' AS Descr,
    COUNT(DISTINCT MaSV) AS NumberOfStudent
FROM
    KetQua
WHERE
    LanThi = 2;
-- problem 39
SELECT 
    CONCAT(dmsv.HoSV, ' ', dmsv.TenSV) AS Fullname, HocBong
FROM
    dmsv
WHERE
    HocBong = (SELECT 
            MAX(HocBong)
        FROM
            dmsv)
GROUP BY CONCAT(dmsv.HoSV, ' ', dmsv.TenSV) , HocBong;
-- problem 40
select MaSV, Diem
from KetQua
group by MaSV, Diem
having Diem = (select max(Diem) from KetQua where LanThi = 1 and MaMH = 01);
select max(Diem) from KetQua where LanThi = 1 and MaMH = 01