@isTest
private class WarehouseCalloutServiceTest 
{
  // implement your mock callout test here
  @isTest
    static void testCallout()
    {
       /* StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('warehouse_vehicle');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'Application/Json');*/
        Test.setMock(HttpCalloutMock.class, new warehousecalloutServiceMock());
        WarehouseCalloutService.runWarehouseEquipmentSync();        
    }
    public void testNegativeCallout()
    {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('warehouse_vehicle');
        mock.setStatusCode(201);
        mock.setHeader('Content-Type', 'Application/Json');
        Test.setMock(HttpCalloutMock.class, new warehousecalloutServiceMock());
        WarehouseCalloutService.runWarehouseEquipmentSync();
        
    }
}