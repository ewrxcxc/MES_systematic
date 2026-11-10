import zipfile
import os
import subprocess

jar_path = "ruoyi-admin/target/ruoyi-admin.jar"
base = "d:/JAVA/MES"

# Step 1: Compile ProductionPlanServiceImpl.java using the JAR as classpath
# Extract classpath from BOOT-INF/lib/
with zipfile.ZipFile(jar_path, 'r') as z:
    lib_jars = [e for e in z.namelist() if e.startswith("BOOT-INF/lib/") and e.endswith(".jar")]

# Build classpath
classpath = os.pathsep.join([os.path.join(base, jar_path)] + [os.path.join(base, jar_path) + "/" + l for l in lib_jars])

print("Building classpath...")

# Compile the single modified Java file
src_file = "ruoyi-admin/src/main/java/com/ruoyi/mes/service/impl/ProductionPlanServiceImpl.java"
target_dir = "ruoyi-admin/target/classes"
dest_class = os.path.join(target_dir, "com/ruoyi/mes/service/impl/ProductionPlanServiceImpl.class")

print(f"Compiling {src_file}...")
result = subprocess.run([
    "javac", "-d", target_dir,
    "-cp", classpath,
    "-sourcepath", "ruoyi-admin/src/main/java",
    src_file
], cwd=base, capture_output=True, text=True)

if result.returncode != 0:
    print("Compilation FAILED:")
    print(result.stderr)
    print(result.stdout)
    # Try alternative: use the BOOT-INF/classes as source for deps
    print("Trying alternative compilation...")
    # Extract classes from JAR to temp first
else:
    print("Compilation successful!")

# Step 2: Patch files into JAR
print("Patching JAR...")

# Files to patch: (source_relative_path, target_in_jar)
patches = []

# Compiled class
if os.path.exists(os.path.join(base, dest_class)):
    patches.append((dest_class, f"BOOT-INF/classes/com/ruoyi/mes/service/impl/ProductionPlanServiceImpl.class"))
    print(f"  Will patch: {dest_class}")

# Template files
templates = [
    "ruoyi-admin/src/main/resources/templates/mes/plan/plan.html",
    "ruoyi-admin/src/main/resources/templates/mes/plan/add.html",
    "ruoyi-admin/src/main/resources/templates/mes/workorder/workorder.html",
]

for t in templates:
    src = os.path.join(base, t)
    if os.path.exists(src):
        dst = t.replace("ruoyi-admin/src/main/resources/", "BOOT-INF/classes/")
        patches.append((t, dst))
        print(f"  Will patch: {t} -> {dst}")

# Read original JAR, replace files, write new JAR
tmp_jar = jar_path + ".tmp"
with zipfile.ZipFile(jar_path, 'r') as zin:
    with zipfile.ZipFile(tmp_jar, 'w', zipfile.ZIP_DEFLATED) as zout:
        for item in zin.infolist():
            data = zin.read(item.filename)
            # Check if this file should be replaced
            replaced = False
            for src_path, dst_path in patches:
                if item.filename == dst_path:
                    src_full = os.path.join(base, src_path)
                    with open(src_full, 'rb') as f:
                        data = f.read()
                    print(f"  Patching: {item.filename} ({len(data)} bytes)")
                    replaced = True
                    break
            zout.writestr(item, data)

os.replace(tmp_jar, jar_path)
print("JAR patched successfully!")
