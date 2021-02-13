public class VerifyDate {
    
    public static Date verifyDateMethod (Date date1, Date date2) {
        
        if (date1 < date2) {
            return date2;
        }
        return date1;
    }
}