/**
 * 住所マスタ連携バッチ
 * 
 * 概要：中間テーブルから業務テーブルにデータをマッピングする
 */
global class BatchAddressMaster implements Database.Batchable<sObject>, Database.Stateful {
    // バッチサイズ
    public static final Integer BATCH_SIZE = 2000;
    
    // バッチ処理名
    @TestVisible
    private static final String BATCH_PROCESSNAME = '住所マスタ';
    
    // バッチログ
    private BatchLog__c batchLog = new BatchLog__c();

    /**
     * 概要：コンストラクタ
     */
    global BatchAddressMaster() {
        // バッチログの初期化処理
        RBTCommon.initBatchLog(this.batchLog, BATCH_PROCESSNAME);
        
        // バッチログ登録
        insert this.batchLog;
    }
    
    /**
     * 概要：バッチ開始処理
     * @parameter Database.BatchableContext
     */
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // バッチログ更新
        this.batchLog.ApexJobId__c = bc.getJobId();
        update this.batchLog;

        // 項目取得
        List<String> fieldNameList = RBTCommon.getCustomFieldNameList(RenkeiAddressMaster__c.SObjecttype);
        
        // 検索用変数設定
        String haneiStatus = RBTCommon.HANEISTATUS_NO; // 反映ステータス（0:未処理）
        
        // 検索用SOQL文作成
        String strQuery = '';
        strQuery = strQuery + ' SELECT ';
        strQuery = strQuery + String.join(fieldNameList, ','); // カステム項目
        strQuery = strQuery + ' FROM ';
        strQuery = strQuery + '     RenkeiAddressMaster__c '; // 連携住所マスタオブジェクト
        strQuery = strQuery + ' WHERE ';
        strQuery = strQuery + '     HaneiStatus__c = :haneiStatus'; // 反映ステータス

        // SOQL発行
        return Database.getQueryLocator(strQuery );
    }

    /**
     * 概要：バッチ業務処理
     * @parameter Database.BatchableContext
     * @parameter List<RenkeiAddressMaster__c>
     */
    global void execute(Database.BatchableContext bc, List<RenkeiAddressMaster__c> scope) {
        // savepoint定義
        Savepoint sp = Database.setSavepoint();
        
        try {
            // Map<連携キー, マッピングインスタンス>
            Map<String, MappingWapper> mapMappingWapper = new Map<String, MappingWapper>();
            
            // 追加更新対象格納リスト
            List<AddressMaster__c> upsertList = new List<AddressMaster__c>();
            
            // 削除対象キー格納リスト(連携キー)
            List<String> deleteKeyList = new List<String>();
            
            for (RenkeiAddressMaster__c item : scope) {
                // マッピング処理インスタンス作成
                MappingWapper mapping = new MappingWapper(item);
                
                // マッピングインスタンスMapを作成する（Map<連携キー,マッピングインスタンス>）
                mapMappingWapper.put(item.RenkeiKey__c, mapping);
                
                // チェックエラーの有無判定
                if (!mapping.haveCheckError) {
                    // 削除対象判定
                    if (mapping.isDelete) {
                        // 削除対象
                        deleteKeyList.add(item.RenkeiKey__c);
                    } else {
                        // 追加更新更新
                        upsertList.add(mapping.mappingTo);
                    }
                }
            }
            
            // 追加更新処理
            List<Database.UpsertResult> upsertResultList = Database.upsert(upsertList, AddressMaster__c.RenkeiKey__c, false);
            
            // 追加更新処理結果判定
            Integer indexUpsertResult = 0;
            for (Database.UpsertResult upsertResult : upsertResultList) {
                if (!upsertResult.isSuccess()) {
                    // エラーレコード取得
                    AddressMaster__c item = upsertList.get(indexUpsertResult);
                    
                    // レコードIDにより連携元レコードを特定する
                    MappingWapper wapper = mapMappingWapper.get(item.RenkeiKey__c);

                    // DML更新エラー設定
                    wapper.setDMLErrorMessage(upsertResult.getErrors());
                }
                
                // カウンター
                indexUpsertResult += 1;
            }
            
            // 削除対象取得
            List<AddressMaster__c> deleteList = [select Id, RenkeiKey__c from AddressMaster__c where RenkeiKey__c in :deleteKeyList];
            
            // 削除処理
            List<Database.DeleteResult> deleteResultList = Database.delete(deleteList, false);
            
            // 削除処理結果判定
            Integer indexDeleteResult = 0;
            for (Database.DeleteResult deleteResult : deleteResultList) {
                if (!deleteResult.isSuccess()) {
                    // エラーレコード取得
                    AddressMaster__c item = deleteList.get(indexDeleteResult);
                    
                    // レコードIDにより連携元レコードを特定する
                    MappingWapper wapper = mapMappingWapper.get(item.RenkeiKey__c);
                    
                    // DML更新エラー設定
                    wapper.setDMLErrorMessage(deleteResult.getErrors());
                }
                
                // カウンター
                indexDeleteResult += 1;
            }
            
            // マッピング完了処理
            List<RenkeiAddressMaster__c> updateList = new List<RenkeiAddressMaster__c>();
            for (MappingWapper mappingWapper : mapMappingWapper.values()) {
                // 連携財務情報(B/S)取得
                RenkeiAddressMaster__c mappingFrom = mappingWapper.mappingFrom;
                
                // ApexジョブID
                mappingFrom.ApexJobId__c = bc.getJobId();
                
                // チェックエラー有無判定
                if (mappingWapper.haveCheckError || mappingWapper.haveDMLError) {
                    // エラーメッセージ出力処理
                    if (mappingWapper.haveCheckError) {
                        // エラーメッセージ出力（レコード）
                        RBTCommon.outPutToRecord(mappingFrom, mappingWapper.checkErrorMessage);
                        
                        // エラーメッセージ出力（バッチログ）
                        RBTCommon.outPutToBatchLog(this.batchLog, mappingWapper.checkErrorMessage, mappingFrom.Id);
                    } else {
                        // エラーメッセージ出力（レコード）
                        RBTCommon.outPutToRecord(mappingFrom, mappingWapper.dmlErrorList);
                        
                        // エラーメッセージ出力（バッチログ）
                        RBTCommon.outPutToBatchLog(this.batchLog, mappingWapper.dmlErrorList, mappingFrom.Id);
                    }
                    
                    // 失敗件数の統計
                    this.batchLog.ErrorCnt__c += 1;
                } else {
                    // 反映ステータスは「処理済」で設定する
                    mappingFrom.HaneiStatus__c = RBTCommon.HANEISTATUS_YES;
                    
                    // 反映元データエラーメッセージのクリア
                    mappingFrom.ErrorMessage__c = '';
                    
                    // 成功件数統計
                    this.batchLog.SuccessCnt__c += 1;
                }
            
                // 対象件数の統計
                this.batchLog.TargetCnt__c += 1;
                
                // 反映元更新データ格納
                updateList.add(mappingFrom);
            }
            
            // 反映元データ更新
            update updateList;
        } catch (Exception e) {
            // ロールバック
            Database.rollback(sp);
            
            // エラーメッセージ出力（バッチログ）
            RBTCommon.outPutToBatchLog(this.batchLog, e.getMessage());
        }
    }

    /**
     * 概要：バッチ終了処理
     * @parameter Database.BatchableContext
     */
    global void finish(Database.BatchableContext bc) {
        // 終了時刻
        this.batchLog.ProcessEndTime__c = system.now();
        
        // バッチログ更新
        update this.batchLog;
    }
    
    /**
     * マッピング処理内部クラス
     */
    private class MappingWapper {
        // 中間オブジェクト
        public RenkeiAddressMaster__c mappingFrom;
        
        // 業務オブジェクト
        public AddressMaster__c mappingTo = new AddressMaster__c();
        
        // チェックエラー有無フラグ
        public Boolean haveCheckError = false;
        
        // DML処理エラーフラグ
        public Boolean haveDMLError = false;
        
        // 追加更新対象判定フラグ
        public Boolean isUpsert = false;
        
        // 削除対象判定フラグ
        public Boolean isDelete = false;
        
        // エラーメッセージ
        public String checkErrorMessage = '';
        
        // DMLエラーリスト
        public List<Database.Error> dmlErrorList = new List<Database.Error>();
        
        /**
         * 概要：コンストラクタ
         * @parameter RenkeiAddressMaster__c 中間オブジェクト
         */
        public MappingWapper(RenkeiAddressMaster__c mappingFrom) {
            // 中間オブジェクト設定
            this.mappingFrom = mappingFrom;
            
            // チェックを呼び出す
            this.doCheck();
            
            // マッピング処理を呼び出す
            this.doMapping();
        }
        
        /**
         * 概要：DMLエラーメッセージ設定
         * @parameter List<Database.Error> DMLエラー情報
         */
        public void setDMLErrorMessage(List<Database.Error> dmlErrorList) {
            // DML処理エラーフラグ
            this.haveDMLError = true;
            
            // DMLエラーリスト
            this.dmlErrorList = dmlErrorList;
        }
        
        /**
         * 概要：チェック
         */
        private void doCheck() {
            // 差分コードの有効性チェック
            if(this.mappingFrom.SabunCode__c != RBTCommon.SABUNCODE_UPSERT && this.mappingFrom.SabunCode__c != RBTCommon.SABUNCODE_DELETE) {
                this.haveCheckError = true;
                this.checkErrorMessage += Label.SabunCodeNotExist;
            }
        }
        
        /**
         * 概要：マッピング処理
         */
        private void doMapping() {
            // マッピングエラーがある場合、後続処理しない
            if (this.haveCheckError) {
                return;
            }
            
            // 差分コードにより、処理判定
            if (RBTCommon.SABUNCODE_DELETE.equals(this.mappingFrom.SabunCode__c)) {
                // 削除対象
                this.isDelete = true;
                
                return;
            } else {
                // 追加更新対象
                this.isUpsert = true;
            }

            // マッピング処理
            this.mappingTo.RenkeiKey__c = this.mappingFrom.RenkeiKey__c; // 連携キー
            this.mappingTo.Name = this.mappingFrom.AddressCD__c; // 住所CD
            this.mappingTo.Address__c = this.mappingFrom.Address__c; // 住所詳細
        }
    }
}