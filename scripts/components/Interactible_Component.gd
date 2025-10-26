extends Component

class_name Interactible_Component

var outline_shader : Shader = preload("res://shaders/outline_shader.gdshader")

func interact():
	pass

func interact_with_source(_source: Node):
	pass

func highlight():
	for c in component_owner.get_children():
		if c is MeshInstance3D:
			var mat = ShaderMaterial.new()
			mat.shader = outline_shader
			
			c.material_overlay = mat

func unhighlight():
	for c in component_owner.get_children():
		if c is MeshInstance3D:
			c.material_overlay = null
