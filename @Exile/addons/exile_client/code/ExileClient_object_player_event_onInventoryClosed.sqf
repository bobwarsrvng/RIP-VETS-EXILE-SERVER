/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_container"];
_container = _this select 1;
ExileClientInventoryOpened = false;
ExileClientCurrentInventoryContainer = objNull;
try
{
	if((typeOf _container) in ["GroundWeaponHolder","WeaponHolderSimulated"])then
	{
		throw "";
	};
	if(_container isKindOf "Man")then
	{
		throw "";
	};
	["vehicleSaveRequest",[netId _container]] call ExileClient_system_network_send;
}
catch
{
	true
};
true