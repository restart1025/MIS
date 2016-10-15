## 系统原型网址：
http://phbmhb.axshare.com
##查询语句：
###根据设备名称查询保养记录：
SELECT 	et.type_name AS '设备类型',   
&emsp;&emsp;eq.name AS '设备名称',  
&emsp;&emsp;eq.maintenance_last_time AS '最近一次保养时间',   
&emsp;&emsp;mp.maintenance_content AS '保养内容',  
&emsp;&emsp;ma.type AS '保养类别',   
&emsp;&emsp;ma.time AS '保养时间',   
&emsp;&emsp;mc.material_name AS '消耗材料',  
&emsp;&emsp;mc.material_num AS '材料数量',  
&emsp;&emsp;mr.condition AS '完成情况',   
&emsp;&emsp;mr.comments AS '备注'     
FROM maintenance_record AS mr   
&emsp;LEFT JOIN equipment AS eq ON mr.equipment_id = eq.id   
&emsp;LEFT JOIN maintenance AS ma ON mr.maintenance_id = ma.id   
&emsp;LEFT JOIN maintenance_project AS mp ON mr.project_id = mp.id   
&emsp;LEFT JOIN consume_record AS cr ON mr.id = cr.record_id   
&emsp;LEFT JOIN maintenance_consume AS mc ON cr.consume_id = mc.id   
&emsp;LEFT JOIN equipment_type AS et ON eq.type = et.type_id   
WHERE eq.name='比重计01';  
