public class forTest20190318 {
    
    public static void testA () {
        
        Integer  x = 1;Integer y = 0;
        While(x < 10){
            y++;
            x++;
        } 
        system.debug('x'+ String.valueOf(x));
        system.debug('y'+ String.valueOf(y));
    }
    
    public void testB () {
        
        testA();
        //testA();
        
        Date d1 = Date.Today(), d2 = Date.Valueof('2018-01-01');
        List<string> s = new List<string> {' a ', 'b ', 'c'};
        Integer a=5, b=6, c, d = 7;
        Map<Id, Lead> lmap = new Map<id, Lead> ( [Select ID from Lead Limit 8]);

    }
    
    class innerA {
        
        public innerA () {
            
            forTest20190318 t = new forTest20190318();
            //t.testA();
            t.testB();
        }
    }
}