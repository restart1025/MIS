
### 查询用户test1可以查看的页面（Sys_menu）和对订单(order)页面中的操作权限(sys_button)
SELECT 	cp.PrivilegeMaster AS '角色类型',  
&emsp;&emsp;&emsp;&nbsp;cp.PrivilegeMasterKey AS '类型编号',  
&emsp;&emsp;&emsp;&nbsp;cp.PrivilegeAccess AS '对象类型',  
&emsp;&emsp;&emsp;&nbsp;cp.PrivilegeAccessKey AS '对象编号',  
&emsp;&emsp;&emsp;&nbsp;sm.MenuName AS '菜单名称',  
&emsp;&emsp;&emsp;&nbsp;sb.BtnName AS '按钮名称'  
&emsp;FROM cf_privilege AS cp   
&emsp;&emsp;LEFT JOIN sys_menu AS sm ON cp.PrivilegeAccessKey = sm.MenuID AND cp.PrivilegeAccess = 'Sys_Menu'  
&emsp;&emsp;LEFT JOIN sys_button AS sb ON cp.PrivilegeAccessKey = sb.BtnID AND cp.PrivilegeAccess = 'Sys_Button'  
&emsp;WHERE ((cp.PrivilegeMaster = 'CF_Role'   
&emsp;&emsp;&emsp;&emsp;&emsp;AND cp.PrivilegeMasterKey   
&emsp;&emsp;&emsp;&emsp;&emsp;IN (SELECT RoleID FROM cf_userrole AS cur   
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;LEFT JOIN cf_user AS cu ON cur.UserID = cu.UserID  WHERE cu.LoginName='test1' ))   
&emsp;&emsp;&emsp;&emsp;OR   
&emsp;&emsp;&emsp;&emsp;&emsp;(cp.PrivilegeMaster = 'CF_User'   
&emsp;&emsp;&emsp;&emsp;&emsp;AND cp.PrivilegeMasterKey = (SELECT UserID FROM cf_user WHERE LoginName = 'test1')))  
&emsp;&emsp;&emsp;&emsp;AND  
&emsp;&emsp;&emsp;&emsp;&emsp;cp.PrivilegeOperation = 'Permit'   
&emsp;&emsp;&emsp;&emsp;ORDER BY cp.PrivilegeAccess DESC;  

### 查询结果:
![](https://github.com/restart1025/MIS/blob/master/RBAC/RBAC.PNG)
