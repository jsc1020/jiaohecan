/**
 * 連携バッチ(共通)
 * 
 */
public class RBTCommon {
    // 差分コード（0:追加/更新）
    public static String SABUNCODE_UPSERT = '0';
    
    // 差分コード（1:削除）
    public static String SABUNCODE_DELETE = '1';
    
    // 反映ステータス（0:未処理）
    public static String HANEISTATUS_NO = '0';
    
    // 反映ステータス（1:処理済）
    public static String HANEISTATUS_YES = '1';
    
    // 改行
    public static String CRLF = '\r\n';
    
    // SFIDとエラーメッセージ
    public static String SPLIT = '|';
    
    /**
     * 概要：カステム項目取得
     * @parameter Schema.SObjectType
     */
    public static List<String> getCustomFieldNameList(Schema.SObjectType sObjectType) {
        // 対象オブジェクトのカスタム項目を取得する
        List< String >  customFieldNameList = new List<String>();
        
        Map< String, Schema.sObjectField > sObjectFieldMap = sObjectType.getDescribe().fields.getMap();
        System.debug('sObjectFieldMap Start');
         System.debug(sObjectFieldMap);
         System.debug('sObjectFieldMap End');
        for(String fieldName : sObjectFieldMap.keySet()){
            if(fieldName.endswith('__c')){
                customFieldNameList.add(fieldName);
            }
        }
        //Schema.SoapType
        //Schema.RecordTypeInfo
        
        return customFieldNameList;
    }
    
    /**
     * 概要：カステム項目取得
     * @parameter オブジェクトの文字列
     */
    public static List<String> getCustomFieldNameList(String sobjName) {
        // 対象オブジェクトのタイプを取得する
        Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(sobjName);
        
        // 対象オブジェクトのカスタム項目を取得する
        return getCustomFieldNameList(sObjectType);
    }
    
    /**
     * 概要：関連レコードにエラーメッセージ出力（汎用）
     * @parameter sObject ログ出力対象レコード
     * @parameter String エラーメッセージ
     */
    public static void outPutToRecord (sObject so, String errorMessage) {
        // 対象レコードにメッセージを設定する
        so.put('ErrorMessage__c', errorMessage);
    }
    
    /**
     * 概要：関連レコードにエラーメッセージ出力（DBエラー）
     * @parameter sObject ログ出力対象レコード
     * @parameter List<Database.Error> Databaseエラーリスト
     */
    public static void outPutToRecord (sObject so, List<Database.Error> dbErrorList) {
        // エラーメッセージリスト
        List<String> errorMessageList = new List<String>();
        for (Database.Error err : dbErrorList) {
            errorMessageList.add(err.getMessage());
        }
        
        // 各エラーメッセージを改行する
        outPutToRecord(so, String.join(errorMessageList, RBTCommon.CRLF));
    }
    
    /**
     * 概要：バッチログにエラーメッセージ出力（汎用）
     * @parameter BatchLog__c バッチログ
     * @parameter String エラーメッセージ
     */
    public static void outPutToBatchLog (BatchLog__c batchLog, String errorMessage) {
        // 改行有無判定
        String strCRLF = '';
        
        // 既存メッセージ有無判定
        if (String.isEmpty(batchLog.ErrorMessage__c)) {
            batchLog.ErrorMessage__c = '';
        } else {
            strCRLF = RBTCommon.CRLF;
        }
        
        // バッチログにメッセージ情報を設定する（maxLength以上の場合、末尾に「...」を出力する）
        Integer intLength = BatchLog__c.ErrorMessage__c.getDescribe().getLength();
        batchLog.ErrorMessage__c += strCRLF+ errorMessage;
        batchLog.ErrorMessage__c = batchLog.ErrorMessage__c.abbreviate(intLength);
    }
    
    /**
     * 概要：バッチログにエラーメッセージ出力（チェックエラー）
     * @parameter BatchLog__c バッチログ
     * @parameter String エラーメッセージ
     * @parameter String 関連レコードId
     */
    public static void outPutToBatchLog (BatchLog__c batchLog, String errorMessage, String sfId) {
        // 関連レコードとエラーメッセージの結合
        errorMessage = sfId + RBTCommon.SPLIT + errorMessage;
        
        // バッチログに出力する
        outPutToBatchLog(batchLog, errorMessage);
    }
    
    /**
     * 概要：バッチログにエラーメッセージ出力（DBエラー）
     * @parameter BatchLog__c バッチログ
     * @parameter String エラーメッセージ
     * @parameter String 関連レコードId
     */
    public static void outPutToBatchLog (BatchLog__c batchLog, List<Database.Error> dbErrorList, String sfId) {
        // DBエラーメッセージを取得する
        String errorMessage = '';
        for (Database.Error err : dbErrorList) {
            errorMessage += err.getMessage();
        }
        
        // バッチログに出力する
        outPutToBatchLog(batchLog, errorMessage, sfId);
    }
    
    /**
     * 概要：バッチログの初期化処理
     * @parameter BatchLog__c バッチログインスタンス
     * @parameter String 処理名
     */
    public static void initBatchLog (BatchLog__c batchLog, String processName) {
        // 処理名
        batchLog.ProcessName__c = processName;
        
        // 日付
        batchLog.ProcessDate__c = system.today();
        
        // 開始時刻
        batchLog.ProcessStartTime__c = system.now();
        
        // 対象件数
        batchLog.TargetCnt__c = 0;
        
        // 成功
        batchLog.SuccessCnt__c = 0;
        
        // 失敗
        batchLog.ErrorCnt__c = 0;
    }
}