package zhidisoft;

/**
 * @Author: Yao YanBao
 * @Description:
 * @Date: Create in 2017/12/6 14:17
 */
public class Singleten {

    /**
     * 饿汉模式，
     */
    private static Singleten instance = new Singleten();
    private Singleten(){}
    private static Singleten getInstance(){
        return instance;
    }

}
