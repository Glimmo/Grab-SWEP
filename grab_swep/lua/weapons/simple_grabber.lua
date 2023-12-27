


SWEP.PrintName = "Grab" -- The name of the weapon
    
SWEP.Author = "Kenzie"
SWEP.Contact = ""--Optional
SWEP.Purpose = "Use this tool to grab things."
SWEP.Instructions = "LMB to grab and put down something. RMB to throw what you've grabbed."
SWEP.Category = "Kenzie SWEPs" --This is required or else your weapon will be placed under "Other"



SWEP.Spawnable= true --Must be true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1  -- How much bullets are in the mag
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo = "none" --The ammo type will it use
SWEP.Primary.Automatic = false 

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Automatic	= false

SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = false
SWEP.Weight = 5 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60
SWEP.ViewModel			= ""
SWEP.WorldModel			= ""
SWEP.UseHands           = true

SWEP.HoldType = "normal" 

SWEP.FiresUnderwater = true


SWEP.CSMuzzleFlashes = false

function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )
    
end 
function SWEP:CanPrimaryAttack()

end
function SWEP:CanSecondaryAttack()

end
function SWEP:Reload()

end

function SWEP:PrimaryAttack()
    if SERVER then
        local ply = self:GetOwner()
        local tr = ply:GetEyeTrace()
        local plyPos = ply:GetPos()
        local entClass = tostring(tr.Entity:GetClass())
        
        if file.Exists("grabber_blacklist.json","DATA") then
            local blacklistFile = file.Read("grabber_blacklist.json","DATA")
            blTable = util.JSONToTable(blacklistFile)
        else
            blTable = {}
        end
        if isentity(tr.Entity) and plyPos:Distance(tr.Entity:GetPos())<100 and not blTable[entClass] then
            timer.Simple(0.2,function()
                ply:PickupObject(tr.Entity)
            end)
        else
            return
        end
    end 

    if CLIENT then
        if timer.Exists("msgCooldn") then
            return
        else
            timer.Create("msgCooldn",1,1,function() end)
        end
        local plyTr = self:GetOwner():GetEyeTrace()
        print("[Grabber] You tried to pickup:   "..tostring(plyTr.Entity:GetClass()))
    end
end