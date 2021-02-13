@isTest
public class TestVerifyDate {

    @isTest
    public static void test1() {
        VerifyDate.verifyDateMethod(System.today(), System.today()+1);
        VerifyDate.verifyDateMethod(System.today()+1, System.today());
    }
}