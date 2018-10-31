public class WarehouseSyncSchedule Implements schedulable
{

 Public void execute(system.SchedulableContext sysSchedule)
  {
        WarehouseCalloutService.runWarehouseEquipmentSync();
  }

}