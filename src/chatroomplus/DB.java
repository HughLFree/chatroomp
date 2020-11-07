package chatroomplus;



import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.*;

public class DB {
	private static final String driver ="com.mysql.jdbc.Driver";
	private static final String password="";
	private static final String url="jdbc:mysql://localhost:3306/chatroom?useUnicode=true&characterEncoding=UTF-8";
	private static final String user="root";

	public static Connection getConnection(){
		Connection conn=null;
		try {
			Class<?> theClass = Class.forName(driver);//反射加载mysql的jdbc驱动，注册到DriveManager  
			conn = DriverManager.getConnection(url,user,password);//用账号密码连接到数据库
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("mysql驱动未找到，请复制java文件到lib目录");
			e.printStackTrace();
		} catch (SQLException e) { //驱动程序版本不对 账号密码不对 网络超时（忘记去启动mysql -nt
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return conn;
	}
	public static List<List> queryList(String sql,Object ...values){
		Connection conn=null;  
		PreparedStatement pstmt=null;
		List<List> ret = new LinkedList();//末尾增加
		System.out.println("execute sql:"+sql); //出错方便调试
		try{  
			conn=getConnection();
			pstmt = conn.prepareStatement(sql);
			for(int i=0;i < values.length;i++){
				pstmt.setObject(i+1, values[i]);//从1开始 设置参数
			}
			ResultSet rs = pstmt.executeQuery();//执行查询，返回结果集
			ResultSetMetaData rsmt = pstmt.getMetaData(); //获得结果集元数据对象 
			int cloNum =rsmt.getColumnCount();//结果集的列数
			while(rs.next()){  //查询到的结果集 默认指针位置是在首记录之前
				//返回值表明指针向后移动后，只想的位置是否存在有效记录
				List row =new Vector(cloNum);  //根据列的数量初始化list实现
				for(int i=1;i<=cloNum;i++){
					row.add(rs.getObject(i));//为了通用性，以object类型获取
				}
				ret.add(row);//加入总表
			}
			System.out.println("return:"+ret.size());//总表多少行
		}catch(SQLException e){
			e.printStackTrace();
		}
		DB.close(pstmt);  //数据库操作后释放资源 消耗光不能使用
		DB.close(conn);
		return ret;
	}
	public static int executeUpdate(String sql,Object ...values){
		Connection conn=null;  //
		PreparedStatement pstmt=null;
		int ret =-1;
		System.out.println("execute sql:"+sql);
		try{//数据库所有操作  都有可能出现异常
			conn=getConnection();//获得数据库连接
			pstmt = conn.prepareStatement(sql);//预编译sql
			for(int i=0;i < values.length;i++){
				pstmt.setObject(i+1, values[i]);//从1开始
			}
			ret = pstmt.executeUpdate();//返回一个数 代表改变多少行（影响的记录行数
			System.out.println("return:"+ret);
		}catch(SQLException e){
			e.printStackTrace(); //打印函数调用栈
		}
		DB.close(pstmt);
		DB.close(conn);
		return ret;
	}
	public static void main(String [] args){
		int ret=0;
	//	String sql ="insert into tb_user(name,email,password) values(?,?,?)";
	//	ret=executeUpdate(sql,"test","test@789","789");
	//	System.out.println(ret);
		String select ="select * from user";
		List<List> data=queryList(select);
		for(List list :data){
			for(Object object :list){
				System.out.print(object+" ");
			}
			System.out.println();
		}
	}
	public static void close(Object toClose){
		//利用反射机制
		if(toClose==null) return;
		Class theClass=toClose.getClass();//得到参数的类
		try {
			Method close = theClass.getMethod("close");//找到这个类叫colse的方法
			close.invoke(toClose);//对某个对象做close方法
			//规律 改变方法属性时要用方法确定这些方法属性从属于哪个对象
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
