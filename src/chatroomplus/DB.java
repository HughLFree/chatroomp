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
			Class<?> theClass = Class.forName(driver);//�������mysql��jdbc������ע�ᵽDriveManager  
			conn = DriverManager.getConnection(url,user,password);//���˺��������ӵ����ݿ�
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("mysql����δ�ҵ����븴��java�ļ���libĿ¼");
			e.printStackTrace();
		} catch (SQLException e) { //��������汾���� �˺����벻�� ���糬ʱ������ȥ����mysql -nt
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return conn;
	}
	public static List<List> queryList(String sql,Object ...values){
		Connection conn=null;  
		PreparedStatement pstmt=null;
		List<List> ret = new LinkedList();//ĩβ����
		System.out.println("execute sql:"+sql); //���������
		try{  
			conn=getConnection();
			pstmt = conn.prepareStatement(sql);
			for(int i=0;i < values.length;i++){
				pstmt.setObject(i+1, values[i]);//��1��ʼ ���ò���
			}
			ResultSet rs = pstmt.executeQuery();//ִ�в�ѯ�����ؽ����
			ResultSetMetaData rsmt = pstmt.getMetaData(); //��ý����Ԫ���ݶ��� 
			int cloNum =rsmt.getColumnCount();//�����������
			while(rs.next()){  //��ѯ���Ľ���� Ĭ��ָ��λ�������׼�¼֮ǰ
				//����ֵ����ָ������ƶ���ֻ���λ���Ƿ������Ч��¼
				List row =new Vector(cloNum);  //�����е�������ʼ��listʵ��
				for(int i=1;i<=cloNum;i++){
					row.add(rs.getObject(i));//Ϊ��ͨ���ԣ���object���ͻ�ȡ
				}
				ret.add(row);//�����ܱ�
			}
			System.out.println("return:"+ret.size());//�ܱ������
		}catch(SQLException e){
			e.printStackTrace();
		}
		DB.close(pstmt);  //���ݿ�������ͷ���Դ ���Ĺⲻ��ʹ��
		DB.close(conn);
		return ret;
	}
	public static int executeUpdate(String sql,Object ...values){
		Connection conn=null;  //
		PreparedStatement pstmt=null;
		int ret =-1;
		System.out.println("execute sql:"+sql);
		try{//���ݿ����в���  ���п��ܳ����쳣
			conn=getConnection();//������ݿ�����
			pstmt = conn.prepareStatement(sql);//Ԥ����sql
			for(int i=0;i < values.length;i++){
				pstmt.setObject(i+1, values[i]);//��1��ʼ
			}
			ret = pstmt.executeUpdate();//����һ���� ����ı�����У�Ӱ��ļ�¼����
			System.out.println("return:"+ret);
		}catch(SQLException e){
			e.printStackTrace(); //��ӡ��������ջ
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
		//���÷������
		if(toClose==null) return;
		Class theClass=toClose.getClass();//�õ���������
		try {
			Method close = theClass.getMethod("close");//�ҵ�������colse�ķ���
			close.invoke(toClose);//��ĳ��������close����
			//���� �ı䷽������ʱҪ�÷���ȷ����Щ�������Դ������ĸ�����
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
