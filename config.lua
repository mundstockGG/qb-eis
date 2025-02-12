Config = {}

Config.Interactions = {{
    propModel = prop_cs_burger_01, -- Model hash for the hamburger prop
    spawnCoords = vector4(123.0, -456.0, 30.0, 90.0), -- X, Y, Z, Heading
    label = "Hamburguesa", -- Title for the notification
    description = "Una jugosa hamburguesa con queso y tocino.", -- Description for the notification
    interactKey = 38, -- E key
    interactText = "[E] Interactuar", -- 3D text to display
    interactionDistance = 2.0 -- Distance to trigger interaction
}, {
    propModel = prop_drink_whisky, -- Model hash for a whisky bottle
    spawnCoords = vector4(100.0, -200.0, 30.0, 180.0), -- X, Y, Z, Heading
    label = "Whisky",
    description = "Un whisky añejo de alta calidad.",
    interactKey = 38, -- E key
    interactText = "[E] Interactuar",
    interactionDistance = 2.0
} -- Add more props as needed
}
