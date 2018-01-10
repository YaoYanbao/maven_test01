package zhidisoft;

import com.zhidisoft.CstCustomer;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * @Author: Yao YanBao
 * @Description:
 * @Date: Create in 2017/11/14 14:56
 */
public class TestCustomer {
    private SessionFactory sessionFactory;
    private Session session;
    private Transaction transaction;

    @Before
    public void init() {
        Configuration configuration = new Configuration().configure();//创建配置对象
        sessionFactory = configuration.buildSessionFactory();//创建会话工厂
        session = sessionFactory.openSession();//开启会话
        transaction = session.beginTransaction();//开启事务
    }

    @After
    public void destory() {
        transaction.commit();//事务提交
        session.close();//关闭会话
        sessionFactory.close();//关闭会话工厂
    }

    @Test
    public void testGoods() {
        //生成对象
        CstCustomer customer01= new CstCustomer();
        customer01.setCustId(1003);
        customer01.setCustName("黎明");
        customer01.setCustIndustry("四大天王");
        //保存对象进数据库
        session.save(customer01);
    }
}
