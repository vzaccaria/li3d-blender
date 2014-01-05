import bpy
import json

def loadMaterial(name):
	bpy.ops.wm.link_append(
		link=False, 
		directory="materials/materials.blend/Material/",
		filename=name,
		filepath="//materials.blend/Material/"+name,
		relative_path=False,
		active_layer=True)	
	

def loadMaterialHash():
	input = open("./scripts/conversion.json", "r")
	content = input.read()
	return json.loads(content)

def substituteMaterial(oldname, newname):

	for ob in bpy.data.objects:

		if hasattr(ob, 'material_slots'):

			omts = ob.material_slots
			gmts = bpy.data.materials

			old = gmts.get(oldname)
			new = gmts.get(newname)

			for m in omts:
				if m.material == old:
					m.material = new

## Begin

bpy.ops.wm.collada_import(filepath="./tmp/final.dae")
bpy.context.scene.render.engine='CYCLES'

## Loading materials 

renamedMaterials = loadMaterialHash()

for k,v in renamedMaterials['mapping'].items():
	loadMaterial(v)
	substituteMaterial(k,v)
	print("Substituted "+k+" with "+v)


## Saving file
bpy.ops.wm.save_mainfile(filepath="./final/final.blend")

