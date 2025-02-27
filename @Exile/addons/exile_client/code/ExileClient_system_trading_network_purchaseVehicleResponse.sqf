/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_responseCode","_vehicleNetID","_newPlayerMoneyString","_vehicleObject","_newPlayerMoney","_salesPrice"];
_responseCode = _this select 0;
_vehicleNetID = _this select 1;
_newPlayerMoneyString = _this select 2;
if (_responseCode isEqualTo 0) then
{
	_vehicleObject = objectFromNetId _vehicleNetID;
	_newPlayerMoney = parseNumber _newPlayerMoneyString;
	_salesPrice = ExileClientPlayerMoney - _newPlayerMoney;
	ExileClientPlayerMoney = _newPlayerMoney;
	player moveInDriver _vehicleObject;
	["VehiclePurchasedInformation", [_salesPrice * -1]] call ExileClient_gui_notification_event_addNotification;
}
else 
{
	["Whoops", [format["Failed to purchase vehicle: %1", _responseCode]]] call ExileClient_gui_notification_event_addNotification;
};