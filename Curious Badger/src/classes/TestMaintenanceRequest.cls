@isTest
public class TestMaintenanceRequest 
{
    @isTest
    Public static void testPositive() 
    {
    Integer CasesCount = 2;
    List<case> lstcases = setTestData(CasesCount);
    Test.startTest();
    for(integer i=0;i<CasesCount;i++)
    {
     Case caseNew=lstcases[i];
     caseNew.Type='Repair';
     caseNew.status='Closed';
    }
    update lstcases;
    system.assertEquals(CasesCount, [select id from case where status='closed' and 
                              type IN ('Repair','Routine Maintenance') and id in :lstcases].size());
    Test.stopTest();
    }
    @isTest
    Public static void testNegative()
    {
    Integer CasesCount = 2;
    List<case> lstcases = setNegativeTestData(CasesCount);
    Test.startTest();
    for(integer i=0;i<CasesCount;i++)
    {
     Case caseNew=lstcases[i];
     caseNew.Type='Electrical';
     caseNew.status='Working';
    }
    update lstcases;
    system.assertEquals(0, [select id from case where status='closed' and 
                              type IN ('Repair','Routine Maintenance') and id in :lstcases].size());
    Test.stopTest(); 
    }
    @isTest
    Public static void testBulk()
    {
    Integer CasesCount = 200;
    List<case> lstcases = setTestData(CasesCount);
    Test.startTest();
    for(integer i=0;i<CasesCount;i++)
    {
     Case caseNew=lstcases[i];
     caseNew.Type='Repair';
     caseNew.status='Closed';
    }
    update lstcases;
    system.assertEquals(CasesCount, [select id from case where status='closed' and 
                              type IN ('Repair','Routine Maintenance') and id in :lstcases].size());
    Test.stopTest();
    }
    
    @isTest
    Public static void testSchedule()
    {
    WarehouseSyncSchedule wCallout = new WarehouseSyncSchedule();
	// Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
	String sch = '0 0 2 * * ?';
	String jobID = System.schedule('Test Warehouse Callout', sch, wCallout);
    system.assertEquals(1, [SELECT Id, CronJobDetail.Id, CronJobDetail.Name, CronJobDetail.JobType,TimesTriggered, NextFireTime 
    FROM CronTrigger where CronJobDetail.Name='Test Warehouse Callout'].size());

    }
    Public static List<case> setTestData(integer TOTAL_CASES)
    {
		Vehicle__c vehicle= new Vehicle__c();
        vehicle.Name='TSURU';
        insert vehicle;
        Product2 eq3=new Product2(ProductCode='003',Maintenance_Cycle__c=33,Name='EQ3');
        insert eq3;
        Product2 eq1=new Product2(ProductCode='001',Maintenance_Cycle__c=10,Name='EQ1',Replacement_Part__c=true);
        insert eq1;
        List <Case>lista= new List<Case>();
        List <Work_Part__c>wps= new List<Work_Part__c>();
        for(integer i=0;i<TOTAL_CASES;i++){
            Case caseNew= new Case();
            caseNew.Vehicle__c=vehicle.Id;
            caseNew.Equipment__c=eq3.Id;
            caseNew.Type='PRUEBA';
            caseNew.Subject='INICIO'+i;
            caseNew.Date_Reported__c=date.today();
            caseNew.Type='Repair';
            lista.add(caseNew);
        }
        insert lista;
        for(integer i=0;i<TOTAL_CASES;i++){
            Work_Part__c wp = new Work_Part__c();
            wp.Equipment__c=eq1.Id;
            wp.Maintenance_Request__c=lista[i].Id;
            wp.Quantity__c=1;
            wps.add(wp);
        }
        insert wps;
        Return lista;
    }
    Public static List<case> setNegativeTestData(integer TOTAL_CASES)
    {
		Vehicle__c vehicle= new Vehicle__c();
        vehicle.Name='TSURU';
        insert vehicle;
        Product2 eq3=new Product2(ProductCode='003',Maintenance_Cycle__c=33,Name='EQ3');
        insert eq3;
        Product2 eq1=new Product2(ProductCode='001',Maintenance_Cycle__c=10,Name='EQ1',Replacement_Part__c=true);
        insert eq1;
        List <Case>lista= new List<Case>();
        List <Work_Part__c>wps= new List<Work_Part__c>();
        for(integer i=0;i<TOTAL_CASES;i++){
            Case caseNew= new Case();
            caseNew.Vehicle__c=vehicle.Id;
            caseNew.Equipment__c=eq3.Id;
            caseNew.Type='PRUEBA';
            caseNew.Subject='INICIO'+i;
            caseNew.Date_Reported__c=date.today();
            caseNew.Type='Electrical';
            lista.add(caseNew);
        }
        insert lista;
        for(integer i=0;i<TOTAL_CASES;i++){
            Work_Part__c wp = new Work_Part__c();
            wp.Equipment__c=eq1.Id;
            wp.Maintenance_Request__c=lista[i].Id;
            wp.Quantity__c=1;
            wps.add(wp);
        }
        insert wps;
        Return lista;
    }

}