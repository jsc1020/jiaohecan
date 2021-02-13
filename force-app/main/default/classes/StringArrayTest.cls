public class StringArrayTest {
    public static List<String> generateStringArray(Integer parm1) {
        
        List<String> strList = new List<String>();
        for (Integer n = 0; n < parm1; n++) {
            String strTem = 'Test ' + n;
            strList.add(strTem);
        }
        
        system.debug('strList:' + strList);
        
        return strList;
    }
}