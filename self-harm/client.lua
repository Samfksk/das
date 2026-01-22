local aimingSelf = false
local aimThreadId = nil

local function notify(message)
    TriggerEvent('chat:addMessage', {
        color = {255, 50, 50},
        multiline = true,
        args = {'SelfAim', message}
    })
end

local function canUseWeapon(ped)
    return GetSelectedPedWeapon(ped) ~= `WEAPON_UNARMED`
end

local function stopSelfAim()
    aimingSelf = false
    if aimThreadId then
        aimThreadId = nil
    end
    ClearPedTasks(PlayerPedId())
end

local function startSelfAim()
    local ped = PlayerPedId()

    if IsPedInAnyVehicle(ped, false) then
        notify('Du kan inte använda detta i ett fordon.')
        return
    end

    if not canUseWeapon(ped) then
        notify('Du måste hålla i ett vapen.')
        return
    end

    if aimingSelf then
        return
    end

    aimingSelf = true

    aimThreadId = CreateThread(function()
        while aimingSelf do
            local headCoords = GetPedBoneCoords(ped, 31086, 0.0, 0.0, 0.0)
            TaskAimGunAtCoord(ped, headCoords.x, headCoords.y, headCoords.z, 1000, false, false)
            Wait(850)
        end
    end)
end

local function shootSelf()
    if not aimingSelf then
        return
    end

    local ped = PlayerPedId()
    stopSelfAim()
    ApplyDamageToPed(ped, 200, false)
end

RegisterCommand('selfaim', function()
    startSelfAim()
end, false)

RegisterCommand('selfshoot', function()
    shootSelf()
end, false)

RegisterCommand('selflower', function()
    stopSelfAim()
end, false)

RegisterKeyMapping('selfshoot', 'Skjut dig själv (endast om du siktar mot dig själv)', 'keyboard', 'G')
RegisterKeyMapping('selflower', 'Lägg ner vapnet (sluta sikta mot dig själv)', 'keyboard', 'H')
