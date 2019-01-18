trigger MaintenanceRequest on Case (before update, after update) 
{
    If(Trigger.isUpdate && Trigger.isAfter)
    {
  
    List<case> ClosedCases = [select id, vehicle__c,equipment__c, closeddate,subject,
                              (select name, equipment__R.maintenance_cycle__C from work_parts__r)
                              from case where 
                              id IN : trigger.new and status='closed' and 
                              type IN ('Repair','Routine Maintenance')];
    // call MaintenanceRequestHelper.updateWorkOrders  
    MaintenanceRequestHelper.updateWorkOrders(closedCases);
    }
}