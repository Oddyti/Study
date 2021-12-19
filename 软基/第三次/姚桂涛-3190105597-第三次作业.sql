
Create table stu (
    学号 int,
    姓名 varchar(8),  
    性别 varchar(4),  
    电子邮箱 varchar(50)  
);
  
ALTER TABLE stu ADD 专业 varchar(10);
ALTER TABLE stu DROP COLUMN 性别;
INSERT INTO stu VALUES (31700001, '唐三藏', 'datangsanzang@zju.edu.cn', '工信');
INSERT INTO stu VALUES (31600002, '猪八戒','tianpenglaozhu@zju.edu.cn', '工信');
INSERT INTO stu VALUES (31500004, '白龙马', 'xihaisantaizi@zju.edu.cn', '金融');
UPDATE stu SET 专业 = '工信' WHERE 学号 LIKE '315%';
DELETE from stu WHERE 姓名 LIKE '猪%' AND 专业 = '工信';
SELECT 姓名 FROM stu WHERE 专业 = '工信';