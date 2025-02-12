local QBCore = exports['qb-core']:GetCoreObject()
local spawnedProps = {}
local isInteracting = false

-- Debug function
local function Debug(message)
    print("[DEBUG] " .. message)
end

-- Function to spawn props
local function SpawnProps()
    for _, interaction in pairs(Config.Interactions) do
        RequestModel(interaction.propModel)
        while not HasModelLoaded(interaction.propModel) do
            Wait(10)
        end

        local prop = CreateObject(interaction.propModel, interaction.spawnCoords.x, interaction.spawnCoords.y, interaction.spawnCoords.z, false, false, false)
        SetEntityHeading(prop, interaction.spawnCoords.w)
        FreezeEntityPosition(prop, true)
        table.insert(spawnedProps, prop)
        Debug("Spawned prop: " .. interaction.label)
    end
end

-- Function to display 3D text
local function Display3DText(coords, text)
    local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(screenX, screenY)
    end
end

-- Function to smoothly switch the camera
local function SwitchCameraToProp(propCoords)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, true)
    local camOffset = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.5)
    SetCamCoord(cam, camOffset.x, camOffset.y, camOffset.z)
    PointCamAtCoord(cam, propCoords.x, propCoords.y, propCoords.z)
    Debug("Camera switched to prop")
    return cam
end

-- Function to reset the camera
local function ResetCamera(cam)
    RenderScriptCams(false, true, 1000, true, false)
    DestroyCam(cam, false)
    isInteracting = false
    Debug("Camera reset")
end

-- Main interaction logic
local function CheckProximity()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _, interaction in pairs(Config.Interactions) do
        local propCoords = vector3(interaction.spawnCoords.x, interaction.spawnCoords.y, interaction.spawnCoords.z)
        local distance = #(playerCoords - propCoords)

        if distance <= interaction.interactionDistance then
            -- Display 3D text
            Display3DText(propCoords, interaction.interactText)

            -- Check for key press
            if IsControlJustReleased(0, interaction.interactKey) and not isInteracting then
                isInteracting = true
                Debug("Interaction started with: " .. interaction.label)

                -- Switch camera to prop
                local cam = SwitchCameraToProp(propCoords)

                -- Show notification
                QBCore.Functions.Notify(interaction.description, "primary", 5000, interaction.label)

                -- Wait for 5 seconds, then reset camera
                Wait(5000)
                ResetCamera(cam)
            end
        end
    end
end

-- Spawn props when the resource starts
CreateThread(function()
    SpawnProps()
    Debug("Props spawned successfully")
end)

-- Main loop
CreateThread(function()
    while true do
        Wait(0)
        if not isInteracting then
            CheckProximity()
        end
    end
end)