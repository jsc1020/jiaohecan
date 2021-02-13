/*******************************************************************************
*
* Description:  変更受付初期処理
* 
* created:      2018/11/13
* modified:     
*
********************************************************************************/
public class A_test1113{
    
    /**
    * 変更受付初期処理時、プロセスビルダーから呼び出すための方法
    * パラメーター
    * inParameters：プロセスビルダーから入力したパラメーターをクラスで一括で取得する、詳細は内部クラスで参照
    */
/**
    @InvocableMethod (label='ChangeRequest_Copy_Contact')
    public static void changeRequestCopyContact (List<Inparameter> inParameters) {
        List<FJ_ChangeRequest_Contact__c> changeRequestContactList= new List<FJ_ChangeRequest_Contact__c>();
        
        for(Inparameter ip:inParameters){
            Contact contactTem = ip.objContact;
            FJ_ChangeRequest_Contact__c changeRequestContactTem = ip.objChangeRequestContact;
            
            Set<String> fields = Schema.getGlobalDescribe().get('FJ_ChangeRequest_Contact__c').getDescribe().fields.getMap().keySet();
            
            for (String field : fields) {
                
                if(field.indexOf('__c') > -1 
                   && !(field == 'fj_Status__c' || field == 'fj_ChangeType__c' 
                        || field == 'fj_RefContact__c' || field == 'fj_RefChangeHistory_Contact__c')) {
                            system.debug('field：' + field);
                            if (field == 'fj_Email__c') {
                                changeRequestContactTem.put('fj_Email__c',contactTem.get('Email'));
                            } else if (field == 'fj_Title__c') {
                                changeRequestContactTem.put('fj_Title__c',contactTem.get('Title'));
                            } else if (field == 'fj_Department__c') {
                                changeRequestContactTem.put('fj_Department__c',contactTem.get('Department'));
                            } else if (field == 'fj_ActiveFlg__c') {
                                if (changeRequestContactTem.fj_ChangeType__c == '04' && changeRequestContactTem.fj_ActiveFlg__c) {
                                    changeRequestContactTem.put('fj_ActiveFlg__c', False);
                                }
                            }else {
                                changeRequestContactTem.put(field,contactTem.get(field));
                            }
                        }
            }
            
            system.debug('取引先責任者変更受付データ：' + changeRequestContactTem);
            
            // 項目を更新した取引先責任者変更受付データを更新用リストに追加する
            changeRequestContactList.add(changeRequestContactTem);
        }
        
        system.debug('更新用リスト：' + changeRequestContactList);
        
        // 変更受付一括更新
        if(changeRequestContactList.size() > 0){
            update changeRequestContactList;
        }
    }
    **/
    
    /**
    // INパラメータ情報(内部クラス)
    public class Inparameter{        
        // 取引先責任者変更受付
        @InvocableVariable
        public FJ_ChangeRequest_Contact__c objChangeRequestContact;
        
        // 取引先責任者
        @InvocableVariable
        public Contact objContact;        
        
        // 構造方法
        public Inparameter(){}
        public Inparameter(FJ_ChangeRequest_Contact__c objChangeRequestContact,
                           Contact objContact){
                               this.objChangeRequestContact = objChangeRequestContact;
                               this.objContact = objContact;
                           }
    }
    **/
}