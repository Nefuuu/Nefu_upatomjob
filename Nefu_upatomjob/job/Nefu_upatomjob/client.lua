-- By "𝙉𝙀𝙁𝙐™#6730
-- Discord : https://discord.gg/mtHH5wcZgQ

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	RefreshupatomMoney()
end)


Citizen.CreateThread(function()

        local upatommap = AddBlipForCoord(84.34, 284.20, 110.23)
        SetBlipSprite(upatommap, 304)
        SetBlipColour(upatommap, 59)
        SetBlipAsShortRange(upatommap, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("upatom")
        EndTextCommandSetBlipName(upatommap)


end)

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k,v in pairs(upatom.pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'upatom' then 
            if (upatom.Type ~= -1 and GetDistanceBetweenCoords(coords, v.position.x, v.position.y, v.position.z, true) < upatom.DrawDistance) then
                DrawMarker(upatom.Type, v.position.x, v.position.y, v.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, upatom.Size.x, upatom.Size.y, upatom.Size.z, upatom.Color.r, upatom.Color.g, upatom.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    
end
end)

RMenu.Add('fridgeupatom', 'main', RageUI.CreateMenu("Frigo", "Pour la consommation des clients"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('fridgeupatom', 'main'), true, true, true, function()    
         
        for k, v in pairs(upatom.fridgeitem) do
            RageUI.Button(v.nom.." ~r~$"..v.prix.."", nil, {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
                if (Selected) then  
                local quantite = 1    
                local item = v.item
                local prix = v.prix
                local nom = v.nom    
                TriggerServerEvent('upatom:achatfridge', v, quantite)
            end
            end)

        end
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, upatom.pos.fridge.position.x, upatom.pos.fridge.position.y, upatom.pos.fridge.position.z)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'upatom' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au Frigo")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('fridgeupatom', 'main'), not RageUI.Visible(RMenu:Get('fridgeupatom', 'main')))
                    end   
                end
               end 
        end
end)

RMenu.Add('garageupatom', 'main', RageUI.CreateMenu("Garage", "Pour livré les meilleurs burger de la ville !"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('garageupatom', 'main'), true, true, true, function() 
            RageUI.Button("Ranger le véhicule", "Pour ranger le véhicule.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            if dist4 < 4 then
                ESX.ShowAdvancedNotification("Garage", "Le véhicule est de retour merci!", "", "CHAR_BIKESITE", 1)
                DeleteEntity(veh)
            end 
            end
            end)         
            RageUI.Button("Scooter", "Pour sortir un Scooter.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            ESX.ShowAdvancedNotification("Garage", "Le véhicule arrive dans quelques instant..", "", "CHAR_BIKESITE", 1) 
            Citizen.Wait(2000)   
            spawnuniCar("faggio2")
            ESX.ShowAdvancedNotification("Garage", "Abime pas le véhicule", "", "CHAR_BIKESITE", 1) 
            end
            end)
            

            
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, upatom.pos.garage.position.x, upatom.pos.garage.position.y, upatom.pos.garage.position.z)
            if dist3 <= 3.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'upatom' then    
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then           
                        RageUI.Visible(RMenu:Get('garageupatom', 'main'), not RageUI.Visible(RMenu:Get('garageupatom', 'main')))
                    end   
                end
               end 
        end
end)

function spawnuniCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, upatom.pos.spawnvoiture.position.x, upatom.pos.spawnvoiture.position.y, upatom.pos.spawnvoiture.position.z, upatom.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Up Atom"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) 
end

RMenu.Add('coffreupatom', 'main', RageUI.CreateMenu("Coffre", "Pour déposer/récuperer des choses dans le coffre."))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('coffreupatom', 'main'), true, true, true, function()
            RageUI.Button("Prendre objet", "Pour prendre un objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            OpenGetStocksupatomMenu()
            end
            end)
            RageUI.Button("Déposer objet", "Pour déposer un objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            OpenPutStocksupatomMenu()
            end
            end)
            end, function()
            end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, upatom.pos.coffre.position.x, upatom.pos.coffre.position.y, upatom.pos.coffre.position.z)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'upatom' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au coffre")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('coffreupatom', 'main'), not RageUI.Visible(RMenu:Get('coffreupatom', 'main')))
                    end   
                end
               end 
        end
end)

function OpenGetStocksupatomMenu()
    ESX.TriggerServerCallback('upatom:prendreitem', function(items)
        local elements = {}

        for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'upatom',
            title    = 'upatom stockage',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'upatom',
                title = 'quantité'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    ESX.ShowNotification('quantité invalide')
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('upatom:prendreitems', itemName, count)

                    Citizen.Wait(300)
                    OpenGetStocksupatomMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

function OpenPutStocksupatomMenu()
    ESX.TriggerServerCallback('upatom:inventairejoueur', function(inventory)
        local elements = {}

        for i=1, #inventory.items, 1 do
            local item = inventory.items[i]

            if item.count > 0 then
                table.insert(elements, {
                    label = item.label .. ' x' .. item.count,
                    type = 'item_standard',
                    value = item.name
                })
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'upatom',
            title    = 'inventaire',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'upatom',
                title = 'quantité'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    ESX.ShowNotification('quantité invalide')
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('upatom:stockitem', itemName, count)

                    Citizen.Wait(300)
                    OpenPutStocksupatomMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end
--vestiaire

RMenu.Add('vestiaireupatom', 'main', RageUI.CreateMenu("Vestiaire", "Pour prendre votre tenue de service ou reprendre votre tenue civil."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('vestiaireupatom', 'main'), true, true, true, function()
            RageUI.Button("Tenue civil", "Pour prendre votre tenue civil.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
            ESX.ShowNotification('Vous avez repris votre ~b~tenue civil')
            end)
            end
            end)
            
            RageUI.Button("tenue de Service", "Pour prendre votre tenue de Service.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            if skin.sex == 0 then
                clothesSkin = {
                            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                            ['torso_1'] = 281,   ['torso_2'] = 21,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 85,
                            ['pants_1'] = 9,   ['pants_2'] = 7,
                            ['shoes_1'] = 61,   ['shoes_2'] = 0,
                            ['chain_1'] = 0,  ['chain_2'] = 0
                        }
            else
                clothesSkin = {
                            ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
                            ['torso_1'] = 8,    ['torso_2'] = 2,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 5,
                            ['pants_1'] = 44,   ['pants_2'] = 4,
                            ['shoes_1'] = 0,    ['shoes_2'] = 0,
                            ['chain_1'] = 0,    ['chain_2'] = 2
                        }
            end
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            ESX.ShowNotification('Vous avez équipé votre ~b~tenue de Service')
            end)

            end
            end)
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, upatom.pos.vestiaire.position.x, upatom.pos.vestiaire.position.y, upatom.pos.vestiaire.position.z)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'upatom' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('vestiaireupatom', 'main'), not RageUI.Visible(RMenu:Get('vestiaireupatom', 'main')))
                    end   
                end
               end 
        end
end)


local societyupatommoney = nil

RMenu.Add('upatomf6', 'main', RageUI.CreateMenu("Up Atom Burger", "Les Meilleurs Burger De Los Santos"))
RMenu.Add('upatomf6', 'patron', RageUI.CreateSubMenu(RMenu:Get('upatomf6', 'main'), "Option patron", "Option patron"))

Citizen.CreateThread(function()
    while true do
    	

        RageUI.IsVisible(RMenu:Get('upatomf6', 'main'), true, true, true, function()
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'upatom' and ESX.PlayerData.job.grade_name == 'boss' then	
        RageUI.Button("Option patron", "Option disponible pour le patron", {RightLabel = "→→→"},true, function()
        end, RMenu:Get('upatomf6', 'patron'))
        end
        RageUI.Button("Facture", "Pour facturer le client", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                

                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('Personne autour')
                    else
                    	local amount = KeyboardInput('Veuillez saisir le montant de la facture', '', 4)
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_upatom', 'upatom', amount)
                    end

            end
            end)
        RageUI.Button("Annonce ouvert", "Pour annoncer l'ouverture du Up Atom Burger", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                TriggerServerEvent('upatom:annonceopen')
            end
            end)
            end, function()
        end)
        RageUI.IsVisible(RMenu:Get('upatomf6', 'patron'), true, true, true, function()
            if societyupatommoney ~= nil then
            RageUI.Button("Montant disponible dans la société :", nil, {RightLabel = "$" .. societyupatommoney}, true, function()
            end)
        end
        RageUI.Button("Annonce recrutement", "Pour annoncer des recrutements au Up Atom Burger", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
				TriggerServerEvent('upatom:annoncerecrutement')
            end
            end)
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'upatom' then  
                    
                    if IsControlJustPressed(1,167) then
                        RageUI.Visible(RMenu:Get('upatomf6', 'main'), not RageUI.Visible(RMenu:Get('upatomf6', 'main')))
                        RefreshupatomMoney()
                    end   
                
               end 
        end
end)

RegisterNetEvent('upatom:infoservice')
AddEventHandler('upatom:infoservice', function(service, nom, message)
	if service == 'patron' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('INFO upatom', '~b~A lire', 'Patron: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_SOCIAL_CLUB', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)	
	end
end)

function RefreshupatomMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyupatomMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyupatomMoney(money)
    societyupatommoney = ESX.Math.GroupDigits(money)
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdboss = GetEntityCoords(GetPlayerPed(-1), false)
                local bossdist = Vdist(plycrdboss.x, plycrdboss.y, plycrdboss.z, upatom.pos.boss.position.x, upatom.pos.boss.position.y, upatom.pos.boss.position.z)
		    if bossdist <= 1.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'upatom' and ESX.PlayerData.job.grade_name == 'boss' then	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à la gestion d'entreprise")
                    if IsControlJustPressed(1,51) then
                        OpenBossActionsupatomMenu()
                    end   
                end
               end 
        end
end)

function OpenBossActionsupatomMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'upatom',{
        title    = 'Action patron upatom',
        align    = 'top-left',
        elements = {
            {label = 'Gestion employées', value = 'boss_upatomactions'},
    }}, function (data, menu)
        if data.current.value == 'boss_upatomactions' then
            TriggerEvent('esx_society:openBossMenu', 'upatom', function(data, menu)
                menu.close()
            end)
        end
    end, function (data, menu)
        menu.close()

    end)
end