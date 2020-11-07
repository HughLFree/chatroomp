package chatroomplus;


import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5 {
    public static String getMD5(String plainText, int length) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");//��ȡMD5ʵ��
            md.update(plainText.getBytes());//�˴�����Ҫ���ܵ�byte����ֵ
            byte[] digest = md.digest();//�˴��õ�����md5���ܺ��byte����ֵ

            /*
               �±ߵ���������Լ���ӵ�һЩ����С���ܣ���ס���ǧ����Ū���ң�
                   �����ڽ��ܵ�ʱ����ᷢ��ֵ���Եģ���������ע���ʱ����ܷ�ʽ��һ�֣�
                �����ǵ�¼��ʱ���ǲ��ǻ���Ҫ������������Ȼ������ݿ�Ľ��бȶԣ�����
            ������Ƿ��֣���������԰������Ǵ򲻵�Ԥ��Ч������ʱ�����Ҫ��һ�£����Ƿ�
             �иĶ�ǰ��ļ��ܷ�ʽ��   
            */
            int i;
            StringBuilder sb = new StringBuilder();
            for (int offset = 0; offset < digest.length; offset++) {
                i = digest[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    sb.append(0);
                sb.append(Integer.toHexString(i));//ͨ��Integer.toHexString������ֵ��Ϊ16����
            }
            return sb.toString().substring(0, length);//���±�0��ʼ��lengthĿ���ǽ�ȡ���ٳ��ȵ�ֵ
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}