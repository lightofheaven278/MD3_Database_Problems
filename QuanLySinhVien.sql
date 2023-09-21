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
Insert into DMSV(MaSV,HoSV,TenSV,Phai,NgaySinh,NoiSinh,MaKhoa,HocBong)
values('B03','Cao Minh','Chau','Nam','1994-11-25','Bình Định','AV',150000);
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
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('B03','05',1,6);
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
SELECT 
    MaSV, Diem
FROM
    KetQua
GROUP BY MaSV , Diem
HAVING Diem = (SELECT 
        MAX(Diem)
    FROM
        KetQua
    WHERE
        LanThi = 1 AND MaMH = 01);
SELECT 
    MAX(Diem)
FROM
    KetQua
WHERE
    LanThi = 1 AND MaMH = 01;
-- problem 41
SELECT 
    dmsv.TenSV, DMKhoa.TenKhoa, dmsv.age
FROM
    dmsv
        INNER JOIN
    DMKhoa ON dmsv.MaKhoa = DMKhoa.MaKhoa
WHERE
    DMKhoa.TenKhoa = 'Anh Văn'
        AND age = (SELECT 
            MAX(dmsv.age)
        FROM
            dmsv
        WHERE
            dmsv.MaKhoa = DMKhoa.MaKhoa);
-- problem 42 ///// need to review
SELECT 
    DMKhoa.TenKhoa, CountStudent.SubCount
FROM
    DMKhoa
        INNER JOIN
    (SELECT 
        MaKhoa, COUNT(MaKhoa) AS SubCount
    FROM
        dmsv
    GROUP BY MaKhoa) AS CountStudent ON DMKhoa.MaKhoa = CountStudent.MaKhoa
WHERE
    CountStudent.SubCount = (SELECT 
            MAX(CountStudent.SubCount)
        FROM
            (SELECT 
                MaKhoa, COUNT(MaKhoa) AS SubCount
            FROM
                dmsv
            GROUP BY MaKhoa) AS CountStudent);
-- problem 43
SELECT 
    DMKhoa.TenKhoa, CountStudent.SubCount
FROM
    DMKhoa
        INNER JOIN
    (SELECT 
        MaKhoa, COUNT(MaKhoa) AS SubCount
    FROM
        dmsv
    WHERE
        Phai = 'Nữ'
    GROUP BY MaKhoa) AS CountStudent ON DMKhoa.MaKhoa = CountStudent.MaKhoa
WHERE
    CountStudent.SubCount = (SELECT 
            MAX(CountStudent.SubCount)
        FROM
            (SELECT 
                MaKhoa, COUNT(MaKhoa) AS SubCount
            FROM
                dmsv
            WHERE
                Phai = 'Nữ'
            GROUP BY MaKhoa) AS CountStudent);
-- problem 44
SELECT 
    DMMH.TenMH, CountTestFail.ExamTimes
FROM
    DMMH
        INNER JOIN
    (SELECT DISTINCT
        MaMH, COUNT(LanThi) AS ExamTimes
    FROM
        ketqua
    WHERE
        MaMH IS NOT NULL AND LanTHi = 2
    GROUP BY MaMH) AS CountTestFail ON DMMH.MaMH = CountTestFail.MaMH
WHERE
    CountTestFail.ExamTimes = (SELECT 
            MAX(CountTestFail.ExamTimes)
        FROM
            (SELECT DISTINCT
                MaMH, COUNT(LanThi) AS ExamTimes
            FROM
                ketqua
            WHERE
                MaMH IS NOT NULL AND LanTHi = 2
            GROUP BY MaMH) AS CountTestFail);
-- problem 45
SELECT 
    NotAV.MaSV, dmsv.TenSV, dmsv.MaKhoa, NotAV.Diem_AV
FROM
    (SELECT 
        dmsv.MaSV AS MaSV,
            ketqua.MaMH AS MaMH,
            ketqua.Diem AS Diem_AV
    FROM
        dmsv
    INNER JOIN DMKhoa ON dmsv.MaKhoa = DMKhoa.MaKhoa
    INNER JOIN ketqua ON dmsv.MaSV = ketqua.MaSV
    WHERE
        DMKhoa.MaKhoa <> 'AV'
            AND ketqua.MaMH = '05') AS NotAV
        INNER JOIN
    (SELECT 
        dmsv.MaSV AS MaSV, ketqua.MaMH AS MaMH, ketqua.Diem AS Diem
    FROM
        dmsv
    INNER JOIN DMKhoa ON dmsv.MaKhoa = DMKhoa.MaKhoa
    INNER JOIN ketqua ON dmsv.MaSV = ketqua.MaSV
    WHERE
        DMKhoa.MaKhoa = 'AV'
            AND ketqua.MaMH = '05') AS AV ON NotAV.MaMH = AV.MaMH
        INNER JOIN
    dmsv ON NotAV.MaSV = dmsv.MaSV
WHERE
    NotAV.Diem_AV > AV.Diem;
-- problem 46
SELECT 
    TenSV, NoiSinh
FROM
    dmsv
WHERE
    NoiSinh = (SELECT 
            NoiSinh
        FROM
            dmsv
        WHERE
            TenSV = 'Hải')
        AND TenSV <> 'Hải';
-- problem 47
SELECT 
    dmsv.MaSV, dmsv.TenSV, dmsv.HocBong
FROM
    dmsv
WHERE
    dmsv.HocBong > (SELECT 
            MAX(HBAV.HocBong)
        FROM
            (SELECT 
                MaSV, HocBong
            FROM
                dmsv
            WHERE
                MaKhoa = 'AV') AS HBAV);
-- problem 48
SELECT 
    dmsv.MaSV, dmsv.TenSV, dmsv.HocBong
FROM
    dmsv
WHERE
    dmsv.HocBong > (SELECT 
            MAX(HBAV.HocBong)
        FROM
            (SELECT 
                MaSV, HocBong
            FROM
                dmsv
            WHERE
                MaKhoa = 'AV') AS HBAV);
-- problem 49
SELECT DISTINCT
    SecondTime.MaSV,
    CONCAT(dmsv.HoSV, ' ', dmsv.TenSV) AS Fullname,
    SecondTime.Diem
FROM
    (SELECT 
        MaSV, MaMH, Diem
    FROM
        ketqua
    WHERE
        MaMH = '01' AND LanThi = 2) AS SecondTime
        INNER JOIN
    (SELECT 
        MaSV, MaMh, Diem
    FROM
        ketqua
    WHERE
        MaMH = '01' AND LanThi = 1) AS OneTime ON SecondTime.MaMH = OneTime.MaMH
        INNER JOIN
    dmsv ON SecondTime.MaSV = dmsv.MaSV
        INNER JOIN
    ketqua ON SecondTime.MaSV = ketqua.MaSV
WHERE
    SecondTime.MaSV <> OneTime.MaSV
        AND SecondTime.Diem >= (SELECT 
            MAX(OneTime.Diem)
        FROM
            (SELECT 
                MaSV, MaMh, Diem
            FROM
                ketqua
            WHERE
                MaMH = '01' AND LanThi = 1) AS OneTime);
-- problem 50
SELECT DISTINCT
    dmsv.MaSV, ketqua.MaMH, dmsv.TenSV
FROM
    dmsv
        INNER JOIN
    ketqua ON dmsv.MaSV = ketqua.MaSV
        INNER JOIN
    (SELECT DISTINCT
        ketqua.MaMH, MAX(Diem) AS MaxPoint
    FROM
        ketqua
    INNER JOIN dmsv ON ketqua.MaSV = dmsv.MaSV
    GROUP BY ketqua.MaMH) AS kq ON ketqua.MaMH = kq.MaMH
        AND ketqua.Diem = kq.MaxPoint;
-- problem 51
Insert into DMKhoa(MaKhoa,TenKhoa)
values('GP','Geography');
SELECT 
    MaKhoa, TenKhoa
FROM
    DMKhoa
WHERE
    MaKhoa NOT IN (SELECT DISTINCT
            MaKhoa
        FROM
            dmsv
        WHERE
            MaSV IS NOT NULL);
-- problem 52
SELECT 
    dmsv.MaSV, dmsv.TenSV
FROM
    dmsv
WHERE
    dmsv.MaSV NOT IN (SELECT 
            MaSV
        FROM
            ketqua
        WHERE
            MaMH = '01');
-- problem 53
SELECT 
    SecondTry.MaSV
FROM
    (SELECT DISTINCT
        MaSV
    FROM
        ketqua
    WHERE
        LanThi = 2) AS SecondTry
WHERE
    MaSV NOT IN (SELECT DISTINCT
            MaSV
        FROM
            ketqua
        WHERE
            LanThi = 1);
-- problem 54
SELECT 
    MaSV, TenSV
FROM
    dmsv
WHERE
    MaKhoa = 'AV'
        AND MaSV NOT IN (SELECT 
            MaSV
        FROM
            ketqua
        WHERE
            MaSV IS NOT NULL);
-- problem 55
SELECT 
    MaSV, TenSV
FROM
    dmsv
WHERE
    MaKhoa = 'AV'
        AND MaSV NOT IN (SELECT 
            MaSV
        FROM
            ketqua
        WHERE
            MaMH = '05');
-- problem 56
SELECT 
    MaSV
FROM
    ketqua
WHERE
    LanThi = 1
        AND MaSV NOT IN (SELECT 
            MaSV
        FROM
            ketqua
        WHERE
            LanThi = 2);
-- problem 57
SELECT 
    MaSV
FROM
    dmsv
WHERE
    MaKhoa = 'AV'
        AND MaSV IN (SELECT 
            MaSV
        FROM
            ketqua
        WHERE
            HocBong IS NOT NULL AND HocBong > 0
                AND LanThi = 1
                AND MaSV NOT IN (SELECT 
                    MaSV
                FROM
                    ketqua
                WHERE
                    LanThi = 2));
-- problem 58
SELECT 
    'Largest number of students who have scholarship' AS Decr,
    MaKhoa,
    COUNT(MaKhoa)
FROM
    dmsv
GROUP BY MaKhoa
HAVING COUNT(MaKhoa) = (SELECT 
        MAX(CountStudent.NumberOfStudent)
    FROM
        (SELECT 
            MaKhoa, COUNT(MaKhoa) AS NumberOfStudent
        FROM
            dmsv
        WHERE
            HocBong IS NOT NULL AND HocBong > 0
        GROUP BY MaKhoa) AS CountStudent) 
UNION SELECT 
    'Smallest number of students who have scholarship' AS Decr,
    MaKhoa,
    COUNT(MaKhoa)
FROM
    dmsv
GROUP BY MaKhoa
HAVING COUNT(MaKhoa) = (SELECT 
        MIN(CountStudent.NumberOfStudent)
    FROM
        (SELECT 
            MaKhoa, COUNT(MaKhoa) AS NumberOfStudent
        FROM
            dmsv
        WHERE
            HocBong IS NOT NULL AND HocBong > 0
        GROUP BY MaKhoa) AS CountStudent);
-- problem 59
SELECT 
    MaSV, COUNT(MaMH)
FROM
    ketqua
GROUP BY MaSV
HAVING COUNT(MaMH) = (SELECT 
        MAX(CountSubject.CS)
    FROM
        (SELECT 
            MaSV, COUNT(MaMH) AS CS
        FROM
            ketqua
        WHERE
            MaSV IS NOT NULL
        GROUP BY MaSV) AS CountSubject);
-- problem 60
Insert into DMSV(MaSV,HoSV,TenSV,Phai,NgaySinh,NoiSinh,MaKhoa,HocBong)
values('B04','Cao','Tung','Nam','1992-12-24','Bình Định','VL',150000);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('B04','01',1,10);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('B03','01',1,10);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('B02','01',1,10);
SELECT DISTINCT
    MaMH, CountTab.NumberOfStudent
FROM
    (SELECT DISTINCT
        MaMH, COUNT(DISTINCT MaSV) AS NumberOfStudent
    FROM
        ketqua
    GROUP BY MaMH) AS CountTab
GROUP BY MaMH
HAVING CountTab.NumberOfStudent = (SELECT 
        COUNT(dmsv.MaSV)
    FROM
        dmsv
    WHERE
        dmsv.MaSV IS NOT NULL);
-- problem 61
SELECT DISTINCT
    MaSV
FROM
    ketqua AS kq
WHERE
    MaSV != 'A02'
        AND MaMH IN (SELECT DISTINCT
            MaMH
        FROM
            ketqua
        WHERE
            MaSV = 'A02');
-- problem 62
select kq2.masv
from ketqua kq2
where kq2.masv not like 'A02'
	-- 3. Kiểm tra sinh viên học các môn trùng với các môn của sinh viên A02
    and kq2.mamh =
		-- 4. Lấy các môn học của A02 và so sánh các môn học của sinh viên tìm được
		(select distinct kq3.mamh from ketqua kq3 where kq3.masv='A02' and kq3.mamh=kq2.mamh)
group by kq2.masv
having count(distinct kq2.mamh) =
	(-- 1. Lấy ra được tổng số môn học của sinh viên A02
	select count(distinct kq1.mamh) from ketqua kq1 where kq1.masv = 'A02');
    
-- Chat GPT's answer
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A04','01',2,6);
Insert into KetQua(MaSV,MaMH,LanThi,Diem)
values('A04','03',2,7);
SELECT DISTINCT kq.MaSV
FROM ketqua kq
WHERE kq.MaSV <> 'A02'
AND NOT EXISTS (
    SELECT 1
    FROM ketqua kq2
    WHERE kq2.MaSV = 'A02'
    AND NOT EXISTS (
        SELECT 1
        FROM ketqua kq3
        WHERE kq3.MaSV = kq.MaSV
        AND kq3.MaMH = kq2.MaMH
    )
);