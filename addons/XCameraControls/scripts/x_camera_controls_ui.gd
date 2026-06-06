extends Node2D

@export var environment:WorldEnvironment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_profile_option_button_item_selected(index: int) -> void:
	var profile_option = $Options/Profile/OptionButton
	if profile_option.text == "Rec. 709":
		var e = environment.environment
		e.adjustment_enabled = false
		$Options/Hdr/OptionButton.disabled = true
		$Options/Log/OptionButton.disabled = true
	elif profile_option.text == "Log":
		var e = environment.environment
		e.adjustment_enabled = true
		$Options/Log/OptionButton.disabled = false
		$Options/Hdr/OptionButton.disabled = true
		#$Options/Log/OptionButton.emit_signal("item_selected")
		_on_log_option_button_item_selected(0)
	else:
		var e = environment.environment
		e.adjustment_enabled = true
		$Options/Hdr/OptionButton.disabled = false
		$Options/Log/OptionButton.disabled = true
		_on_hdr_option_button_item_selected(0)


func _on_log_option_button_item_selected(index: int) -> void:
	var option = $Options/Log/OptionButton
	var file_path = "res://addons/XCameraControls/profiles/Log/Curves/" + option.text +  ".tres"
	if FileAccess.file_exists(file_path):
		var e = environment.environment
		e.adjustment_enabled = true
		e.adjustment_color_correction = ResourceLoader.load(file_path)
		#print(e.adjustment_color_correction, " TYPE: ", e.adjustment_color_correction.get_class())
		$error.text = "";
	else:
		$error.text = "Error: the curves file could not be loaded. Please make sure that the curve file exists or \nreport this issue to the developer.";


func _on_tonemapping_option_button_item_selected(index: int) -> void:
	var option = $Options/ToneMapping/OptionButton
	var e = environment.environment
	if (option.text == "Filmic"):
		e.tonemap_mode = e.TONE_MAPPER_FILMIC
	elif (option.text == "ACES"):
		e.tonemap_mode = e.TONE_MAPPER_ACES
	elif (option.text == "Agx"):
		e.tonemap_mode = e.TONE_MAPPER_AGX
	elif (option.text == "Linear"):
		e.tonemap_mode = e.TONE_MAPPER_LINEAR
	elif (option.text == "Reinhard"):
		e.tonemap_mode = e.TONE_MAPPER_REINHARDT


func _on_ssr_button_down() -> void:
	var e = environment.environment
	e.ssr_enabled = not(e.ssr_enabled)


func _on_sdfgi_button_down() -> void:
	var e = environment.environment
	e.sdfgi_enabled = not(e.sdfgi_enabled)


func _on_ssil_button_down() -> void:
	var e = environment.environment
	e.ssil_enabled = not(e.ssil_enabled)


func _on_ssao_button_down() -> void:
	var e = environment.environment
	e.ssao_enabled = not(e.ssao_enabled)


func _on_hdr_option_button_item_selected(index: int) -> void:
	var option = $Options/Hdr/OptionButton
	var file_path = "res://addons/XCameraControls/profiles/Hdr/Curves/" + option.text +  ".tres"
	if FileAccess.file_exists(file_path):
		var e = environment.environment
		e.adjustment_enabled = true
		e.adjustment_color_correction = ResourceLoader.load(file_path)
		#print(e.adjustment_color_correction, " TYPE: ", e.adjustment_color_correction.get_class())
		$error.text = "";
	else:
		$error.text = "Error: the hdr curves file could not be loaded. Please make sure that the curve file exists or \nreport this issue to the developer.";
