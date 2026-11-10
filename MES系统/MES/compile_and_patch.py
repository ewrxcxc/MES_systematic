import zipfile
import os
import subprocess
import glob

base = 'd:/JAVA/MES'
target = os.path.join(base, 'ruoyi-admin/target')
classes_dir = os.path.join(target, 'classes')
lib_dir = os.path.join(target, 'lib')

cp_entries = [classes_dir] + glob.glob(os.path.join(lib_dir, '*.jar'))
classpath = os.pathsep.join(cp_entries)

src_files = [
    # ===== Existing files =====
    # DTO
    'ruoyi-admin/src/main/java/com/ruoyi/mes/dto/ProductionPlanQueryDTO.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/dto/ProductDTO.java',
    # Service
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/ProductionPlanServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/ProductServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/SalesOrderServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/ProcessTaskServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/WorkOrderServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/InventoryServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/IProductionPlanService.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/ISalesOrderService.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/IInventoryService.java',
    # Controller
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/ProductionPlanController.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/SalesOrderController.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/InventoryController.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/MESPageController.java',
    # VO
    'ruoyi-admin/src/main/java/com/ruoyi/mes/vo/ProductionPlanVO.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/vo/SalesOrderVO.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/vo/WorkOrderVO.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/vo/ProductionReportVO.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/vo/BomVO.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/vo/CustomerVO.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/vo/ProductVO.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/vo/InventoryVO.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/vo/ShipmentRecordVO.java',
    # Domain
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/ProcessTask.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/SalesOrder.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/Product.java',

    # ===== NEW: 工序设备映射 =====
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/ProcessEquipmentMapping.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/ProductionLine.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/mapper/ProcessEquipmentMappingMapper.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/mapper/ProductionLineMapper.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/IProcessEquipmentMappingService.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/ProcessEquipmentMappingServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/ProcessEquipmentMappingController.java',

    # ===== NEW: 领料管理 =====
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/MaterialPicking.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/MaterialPickingDetail.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/mapper/MaterialPickingMapper.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/IMaterialPickingService.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/MaterialPickingServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/MaterialPickingController.java',

    # ===== NEW: 入库管理 =====
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/Warehousing.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/WarehousingDetail.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/mapper/WarehousingMapper.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/IWarehousingService.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/WarehousingServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/WarehousingController.java',
    # ===== NEW: 拆卡 =====
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/WorkOrderSplit.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/mapper/WorkOrderSplitMapper.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/IWorkOrderSplitService.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/WorkOrderSplitServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/WorkOrderSplitController.java',

    # ===== NEW: 追溯管理 =====
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/QualityTrace.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/BatchInfo.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/DefectRecord.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/mapper/QualityTraceMapper.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/IQualityTraceService.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/QualityTraceServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/QualityTraceController.java',

    # ===== MODIFIED: ProcessTask display fields + getAllTasks =====
    'ruoyi-admin/src/main/java/com/ruoyi/mes/domain/ProcessTask.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/mapper/ProcessTaskMapper.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/IProcessTaskService.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/ProcessTaskServiceImpl.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/ProcessTaskController.java',
    'ruoyi-admin/src/main/java/com/ruoyi/mes/controller/MESPageController.java',
]

for src in src_files:
    full = os.path.join(base, src)
    print(f"Compiling {os.path.basename(src)}...")
    result = subprocess.run(
        ['javac', '-encoding', 'UTF-8', '-parameters', '-d', classes_dir, '-cp', classpath,
         '-sourcepath', os.path.join(base, 'ruoyi-admin/src/main/java'), full],
        capture_output=True, text=True
    )
    if result.returncode != 0:
        print(f"  FAILED: {result.stderr}")
    else:
        print(f"  OK")

# Patch JAR
jar_path = os.path.join(target, 'ruoyi-admin.jar')
tmp_jar = jar_path + '.tmp'

patches = []
# Automatically find inner class files (e.g., ServiceImpl$1.class)
def find_inner_classes(classes_dir, cf):
    result = []
    base = cf.replace('.class', '')
    import glob as gl
    for f in gl.glob(os.path.join(classes_dir, base + '$*.class')):
        rel = os.path.relpath(f, classes_dir).replace('\\', '/')
        result.append((f, 'BOOT-INF/classes/' + rel))
    return result

# Java classes
for cf in [
    # Existing
    'com/ruoyi/mes/dto/ProductionPlanQueryDTO.class',
    'com/ruoyi/mes/dto/ProductDTO.class',
    'com/ruoyi/mes/service/impl/ProductionPlanServiceImpl.class',
    'com/ruoyi/mes/service/impl/ProductServiceImpl.class',
    'com/ruoyi/mes/service/impl/SalesOrderServiceImpl.class',
    'com/ruoyi/mes/service/impl/ProcessTaskServiceImpl.class',
    'com/ruoyi/mes/service/impl/WorkOrderServiceImpl.class',
    'com/ruoyi/mes/service/impl/WarehousingServiceImpl.class',
    'com/ruoyi/mes/service/impl/InventoryServiceImpl.class',
    'com/ruoyi/mes/service/IProductionPlanService.class',
    'com/ruoyi/mes/service/ISalesOrderService.class',
    'com/ruoyi/mes/service/IInventoryService.class',
    'com/ruoyi/mes/controller/ProductionPlanController.class',
    'com/ruoyi/mes/controller/SalesOrderController.class',
    'com/ruoyi/mes/controller/InventoryController.class',
    'com/ruoyi/mes/controller/MESPageController.class',
    'com/ruoyi/mes/vo/ProductionPlanVO.class',
    'com/ruoyi/mes/vo/SalesOrderVO.class',
    'com/ruoyi/mes/vo/WorkOrderVO.class',
    'com/ruoyi/mes/vo/ProductionReportVO.class',
    'com/ruoyi/mes/vo/BomVO.class',
    'com/ruoyi/mes/vo/CustomerVO.class',
    'com/ruoyi/mes/vo/ProductVO.class',
    'com/ruoyi/mes/vo/InventoryVO.class',
    'com/ruoyi/mes/vo/ShipmentRecordVO.class',
    'com/ruoyi/mes/domain/ProcessTask.class',
    'com/ruoyi/mes/domain/SalesOrder.class',
    'com/ruoyi/mes/domain/Product.class',
    # NEW: 工序设备映射
    'com/ruoyi/mes/domain/ProcessEquipmentMapping.class',
    'com/ruoyi/mes/domain/ProductionLine.class',
    'com/ruoyi/mes/mapper/ProcessEquipmentMappingMapper.class',
    'com/ruoyi/mes/mapper/ProductionLineMapper.class',
    'com/ruoyi/mes/service/IProcessEquipmentMappingService.class',
    'com/ruoyi/mes/service/impl/ProcessEquipmentMappingServiceImpl.class',
    'com/ruoyi/mes/controller/ProcessEquipmentMappingController.class',
    # NEW: 领料管理
    'com/ruoyi/mes/domain/MaterialPicking.class',
    'com/ruoyi/mes/domain/MaterialPickingDetail.class',
    'com/ruoyi/mes/mapper/MaterialPickingMapper.class',
    'com/ruoyi/mes/service/IMaterialPickingService.class',
    'com/ruoyi/mes/service/impl/MaterialPickingServiceImpl.class',
    'com/ruoyi/mes/controller/MaterialPickingController.class',
    # NEW: 入库管理
    'com/ruoyi/mes/domain/Warehousing.class',
    'com/ruoyi/mes/domain/WarehousingDetail.class',
    'com/ruoyi/mes/mapper/WarehousingMapper.class',
    'com/ruoyi/mes/service/IWarehousingService.class',
    'com/ruoyi/mes/service/impl/WarehousingServiceImpl.class',
    'com/ruoyi/mes/controller/WarehousingController.class',
    # NEW: 拆卡
    'com/ruoyi/mes/domain/WorkOrderSplit.class',
    'com/ruoyi/mes/mapper/WorkOrderSplitMapper.class',
    'com/ruoyi/mes/service/IWorkOrderSplitService.class',
    'com/ruoyi/mes/service/impl/WorkOrderSplitServiceImpl.class',
    'com/ruoyi/mes/controller/WorkOrderSplitController.class',
    # NEW: 追溯管理
    'com/ruoyi/mes/domain/QualityTrace.class',
    'com/ruoyi/mes/domain/BatchInfo.class',
    'com/ruoyi/mes/domain/DefectRecord.class',
    'com/ruoyi/mes/mapper/QualityTraceMapper.class',
    'com/ruoyi/mes/service/IQualityTraceService.class',
    'com/ruoyi/mes/service/impl/QualityTraceServiceImpl.class',
    'com/ruoyi/mes/controller/QualityTraceController.class',
    # MODIFIED: ProcessTask + ProcessTaskController + MESPageController
    'com/ruoyi/mes/domain/ProcessTask.class',
    'com/ruoyi/mes/mapper/ProcessTaskMapper.class',
    'com/ruoyi/mes/service/IProcessTaskService.class',
    'com/ruoyi/mes/service/impl/ProcessTaskServiceImpl.class',
    'com/ruoyi/mes/controller/ProcessTaskController.class',
    'com/ruoyi/mes/controller/MESPageController.class',
]:
    src = os.path.join(classes_dir, cf)
    if os.path.exists(src):
        patches.append((src, 'BOOT-INF/classes/' + cf))
        # Also find inner classes
        for inner_src, inner_dst in find_inner_classes(classes_dir, cf):
            patches.append((inner_src, inner_dst))

# Templates + XML
templates_src = os.path.join(base, 'ruoyi-admin/src/main/resources')
for t in [
    # Existing
    'templates/mes/plan/plan.html',
    'templates/mes/plan/detail.html',
    'templates/mes/plan/add.html',
    'templates/mes/product/add.html',
    'mapper/mes/ProductionPlanMapper.xml',
    'mapper/mes/ProductMapper.xml',
    # NEW: Templates
    'templates/mes/equipment/add.html',
    'templates/mes/equipment/mapping.html',
    'templates/mes/equipment/mapping_add.html',
    'templates/mes/picking/picking.html',
    'templates/mes/picking/picking_detail.html',
    'templates/mes/warehousing/warehousing.html',
    'templates/mes/warehousing/add.html',
    'templates/mes/workorder/split.html',
    'templates/mes/workorder/detail.html',
    'templates/mes/inventory/add.html',
    'templates/mes/order/add.html',
    'templates/mes/bom/add.html',
    'templates/mes/customer/add.html',
    'templates/mes/trace/trace.html',
    # NEW: Mapper XMLs
    'mapper/mes/ProcessEquipmentMappingMapper.xml',
    'mapper/mes/ProductionLineMapper.xml',
    'mapper/mes/MaterialPickingMapper.xml',
    'mapper/mes/WarehousingMapper.xml',
    'mapper/mes/WorkOrderSplitMapper.xml',
    'mapper/mes/QualityTraceMapper.xml',
    'mapper/mes/ProcessTaskMapper.xml',
    # NEW: 工序中心
    'templates/mes/process/process.html',
    # MODIFIED: add pages with buttons
    'templates/mes/plan/add.html',
    'templates/mes/report/add.html',
    'templates/mes/shipment/add.html',
    'templates/mes/warehousing/add.html',
    'templates/mes/equipment/mapping_add.html',
]:
    src_path = os.path.join(templates_src, t)
    if os.path.exists(src_path):
        patches.append((src_path, 'BOOT-INF/classes/' + t))

print(f"\nPatching {len(patches)} files...")
patched_filenames = set()
with zipfile.ZipFile(jar_path, 'r') as zin:
    with zipfile.ZipFile(tmp_jar, 'w', zipfile.ZIP_DEFLATED) as zout:
        for item in zin.infolist():
            data = None
            for src, dst in patches:
                if item.filename == dst:
                    with open(src, 'rb') as f:
                        data = f.read()
                    print(f"  PATCHED: {item.filename}")
                    patched_filenames.add(dst)
                    break
            if data is None:
                data = zin.read(item.filename)
            zout.writestr(item, data)
        # Add new files that didn't exist in the original JAR
        for src, dst in patches:
            if dst not in patched_filenames and os.path.exists(src):
                with open(src, 'rb') as f:
                    data = f.read()
                new_info = zipfile.ZipInfo(filename=dst)
                new_info.date_time = (2026, 6, 1, 0, 0, 0)
                zout.writestr(new_info, data)
                print(f"  ADDED: {dst}")

os.replace(tmp_jar, jar_path)
print("Done!")
