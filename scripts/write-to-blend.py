import bpy


def setMaterial(ob, mat):
    me = ob.data
    me.materials.append(mat)

print("Importing.")
bpy.ops.wm.collada_import(filepath="./tmp/final.dae")
bpy.context.scene.render.engine='CYCLES'
bpy.ops.wm.save_mainfile(filepath="./final/final.blend")
print("Imported.")