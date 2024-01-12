extends ScrollContainer


func _ready():
	# Crea un VBoxContainer principal para manejar la separación entre los slots
	var main_container = VBoxContainer.new()
	self.add_child(main_container)

	for i in range(GlobalVariables.player.slots):
		# Crea un nuevo contenedor / slot
		var slot = VBoxContainer.new()
		main_container.add_child(slot)

		# Si vehículo asignado, muestra sus datos
		var vehicle_id = GlobalVariables.player.get("transport" + str(i) + "Id")
		if vehicle_id != null and vehicle_id != 0:
			var vehicle = GlobalVariables.player.Transport[vehicle_id - 1]

			# Crea la imagen del vehículo
			var vehicle_image = TextureRect.new()
			vehicle_image.texture = vehicle.skin
			slot.add_child(vehicle_image)

			# Crea un contenedor horizontal para nombre
			var name_text = HBoxContainer.new()
			slot.add_child(name_text)
			
			# Crea el nombre del vehículo
			var vehicle_name = Label.new()
			vehicle_name.text = vehicle.name
			name_text.add_child(vehicle_name)
			
			# Crea un contenedor horizontal para Capacidad
			var capacity_text = HBoxContainer.new()
			slot.add_child(capacity_text)
			
			# Crea la capacidad del vehículo
			var vehicle_capacity = Label.new()
			vehicle_capacity.text = str(vehicle.capacity)
			capacity_text.add_child(vehicle_capacity)

			# Crea el botón de "upgrade" y añádelo al slot
			var button = Button.new()
			button.text = "Upgrade"
			slot.add_child(button)
		elif i == 0 or (i > 0 and GlobalVariables.player.get("transport" + str(i - 1) + "Id") != null and GlobalVariables.player.get("transport" + str(i - 1) + "Id") != 0):
			# Si el slot no tiene un vehículo asignado y es el primer slot o el slot anterior tiene un vehículo, muestra un botón para comprar un vehículo
			var button = Button.new()
			button.text = "Comprar vehículo"
			slot.add_child(button)
		else:
			# Si el slot no tiene un vehículo asignado y el slot anterior tampoco tiene un vehículo, muestra un mensaje
			var available_label = Label.new()
			available_label.text = "Disponible para un coche"
			slot.add_child(available_label)
