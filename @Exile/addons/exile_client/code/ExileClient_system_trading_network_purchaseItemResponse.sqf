/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_responseCode","_newPlayerMoneyString","_itemClassName","_quantity","_containerType","_containerNetID","_dialog","_purchaseButton","_newPlayerMoney","_salesPrice","_containersBefore","_containersAfter","_vehicle"];
_responseCode = _this select 0;
_newPlayerMoneyString = _this select 1;
_itemClassName = _this select 2;
_quantity  = _this select 3;
_containerType = _this select 4;
_containerNetID = _this select 5;
ExileClientIsWaitingForServerTradeResponse = false;
_dialog = uiNameSpace getVariable ["RscExileTraderDialog", displayNull];
if!(isNull _dialog)then
{
	_purchaseButton = _dialog displayCtrl 4010;
	_purchaseButton ctrlEnable true;
	_purchaseButton ctrlCommit 0;
};
if (_responseCode isEqualTo 0) then
{
	_newPlayerMoney = parseNumber _newPlayerMoneyString;
	_salesPrice = ExileClientPlayerMoney - _newPlayerMoney;
	ExileClientPlayerMoney = _newPlayerMoney;
	switch (_containerType) do
	{
		case 1:
		{
			_containersBefore = [uniform player, vest player, backpack player];
			[player, _itemClassName] call ExileClient_util_playerCargo_add;
			_containersAfter = [uniform player, vest player, backpack player];
			if !(_containersAfter isEqualTo _containersBefore) then
			{
				call ExileClient_gui_traderDialog_updateInventoryDropdown;
			};
		};
		case 2:
		{
			[(uniformContainer player), _itemClassName] call ExileClient_util_containerCargo_add;
		};
		case 3:
		{
			[(vestContainer player), _itemClassName] call ExileClient_util_containerCargo_add;
		};
		case 4:
		{
			[(backpackContainer player), _itemClassName] call ExileClient_util_containerCargo_add;
		};
		case 5:
		{
			_vehicle = objectFromNetId _containerNetID;
			[_vehicle, _itemClassName] call ExileClient_util_containerCargo_add;
		};
	};
	["ItemPurchasedInformation", [_salesPrice * -1]] call ExileClient_gui_notification_event_addNotification;
	_dialog = uiNameSpace getVariable ["RscExileTraderDialog", displayNull];
	if !(_dialog isEqualTo displayNull) then
	{
		call ExileClient_gui_traderDialog_updateInventoryListBox;
		call ExileClient_gui_traderDialog_updatePlayerControls;
	};
}
else 
{
	["Whoops", [format["Failed to purchase item: %1", _responseCode]]] call ExileClient_gui_notification_event_addNotification;
};