/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_listBox","_index","_display","_playerListBox","_flag","_buildRights","_playerUID","_playerObject","_text","_playerTerritoryAccess","_myAccessLevel","_leaveButton","_promoteButton","_demoteButton","_nextProtectionMoneyDueDate","_dateTimeString","_territoryPayDayInfo"];
disableSerialization;
_listBox = _this select 0;
_index = _this select 1;
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
_playerListBox = _display displayCtrl 4131;
lbClear _playerListBox;
_flag = objectFromNetId (_listBox lbData _index);
_buildRights = _flag getVariable ["ExileTerritoryBuildRights", []];
{
	_playerUID = _x;
	_playerObject = _playerUID call ExileClient_util_player_objectFromPlayerUid;
	if (isNull _playerObject) then
	{
		_text = format ["~OFFLINE~ (%1)", _playerUID];
	}
	else
	{
		_text = format ["%1 (%2)", name _playerObject, _playerUID];
	};
	_playerTerritoryAccess = [_flag, _playerUID] call ExileClient_util_territory_getAccessLevel;
	_playerListBox lbAdd _text;
	_playerListBox lbSetTooltip [_forEachIndex, (_playerTerritoryAccess select 1)];
	_playerListBox lbSetData [_forEachIndex, _playerUID];
	switch (_playerTerritoryAccess select 0) do
	{
		case 3:		
		{
			_playerListBox lbSetPicture [_forEachIndex, "\a3\ui_f\data\gui\cfg\Ranks\sergeant_gs.paa"];
			_playerListBox lbSetPictureColor [_forEachIndex, [0.91, 0, 0, 0.6]];
		};
		case 2:
		{
			_playerListBox lbSetPicture [_forEachIndex, "\a3\ui_f\data\gui\cfg\Ranks\corporal_gs.paa"];
			_playerListBox lbSetPictureColor [_forEachIndex, [0, 0.78, 0.93, 0.6]];
		};
		default
		{
			_playerListBox lbSetPicture [_forEachIndex, "\a3\ui_f\data\gui\cfg\Ranks\private_gs.paa"];
			_playerListBox lbSetPictureColor [_forEachIndex, [0.7, 0.93, 0, 0.6]];
		};
	};
} 
forEach _buildRights;
_myAccessLevel = [_flag, getPlayerUID player] call ExileClient_util_territory_getAccessLevel;
_leaveButton = _display displayCtrl 4135;
_promoteButton = _display displayCtrl 4136;
_demoteButton = _display displayCtrl 4137;
_promoteButton ctrlEnable false;
_demoteButton ctrlEnable false;
if ((_myAccessLevel select 0) isEqualTo 3) then
{
	_leaveButton ctrlEnable false;
}
else 
{
	_leaveButton ctrlEnable true;
};
_nextProtectionMoneyDueDate = _flag getVariable ["ExileTerritoryMaintenanceDue", [0, 0, 0, 0, 0]];
_dateTimeString = format 
[
	"%1-%2-%3 %4:%5",
	_nextProtectionMoneyDueDate select 0,
	_nextProtectionMoneyDueDate select 1,
	_nextProtectionMoneyDueDate select 2,
	_nextProtectionMoneyDueDate select 3,
	_nextProtectionMoneyDueDate select 4
];
_territoryPayDayInfo = _display displayCtrl 4133;
_territoryPayDayInfo ctrlSetText (format ["Protection Money Due Date: %1", _dateTimeString]);
true