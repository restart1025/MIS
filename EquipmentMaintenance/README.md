## 系统原型网址：
http://phbmhb.axshare.com

##查询语句：
###根据设备名称查询保养记录：
SELECT 	et.type_name AS '设备类型',   
&emsp;&emsp;eq.name AS '设备名称',   
&emsp;&emsp;eq.maintenance_last_time AS '最近一次保养时间',   
&emsp;&emsp;mp.maintenance_content AS '保养内容',  
&emsp;&emsp;mr.type AS '保养类别',   
&emsp;&emsp;mr.main_time AS '保养时间',   
&emsp;&emsp;mc.material_name AS '消耗材料',  
&emsp;&emsp;mc.material_num AS '材料数量',  
&emsp;&emsp;mr.condition AS '完成情况',   
&emsp;&emsp;mr.comments AS '备注'     
FROM maintenance_record AS mr   
&emsp;	LEFT JOIN equipment AS eq ON mr.equipment_id = eq.id   
&emsp;	LEFT JOIN maintenance_project AS mp ON mr.project_id = mp.id   
&emsp;	LEFT JOIN consume_record AS cr ON mr.id = cr.record_id   
&emsp;	LEFT JOIN maintenance_consume AS mc ON cr.consume_id = mc.id   
&emsp;	LEFT JOIN equipment_type AS et ON eq.type = et.type_id   
WHERE eq.name='比重计01';  

###预警
SELECT IF(  
(SELECT DATEDIFF(curdate(),  
&emsp;&emsp;		(SELECT mr.main_time  
&emsp;&emsp;		FROM maintenance_record AS mr   
&emsp;&emsp;&emsp;			LEFT JOIN check_type AS ct ON ct.check_type = mr.type  
&emsp;&emsp;		WHERE equipment_id = 1   
&emsp;&emsp;		ORDER BY mr.main_time DESC   
&emsp;&emsp;		limit 1)  
&emsp;	) AS DiffDate)   
<=   
&emsp;	(SELECT ct.waring_day   
&emsp;	FROM maintenance_record AS mr   
&emsp;&emsp;			LEFT JOIN check_type AS ct ON ct.check_type = mr.type  
&emsp;&emsp;			LEFT JOIN equipment e ON e.id = mr.equipment_id   
&emsp;	WHERE equipment_id = 1 ORDER BY mr.main_time DESC limit 1)  
, 'true' ,'false') AS '是否需要预警';  
