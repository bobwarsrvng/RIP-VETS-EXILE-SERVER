/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_display","_ctrlButtonOK","_ctrlButtonCancel","_screenText"];
disableSerialization;
ExileClientPinCodeLength = _this;
ExileClientPinCode = "";
createDialog "RscExileKeypad";
waitUntil
{
	uiSleep 0.1;
	!isNull findDisplay 24010
};
_display = uiNameSpace getVariable ["RscExileKeypad", displayNull];
_ctrlButtonOK = _display displayCtrl 4000;
_ctrlButtonCancel = _display displayCtrl 4002;
_screenText = _display displayCtrl 4001;
_screenText ctrlSetText "ENTER PIN";
true call ExileClient_gui_postProcessing_toggleDialogBackgroundBlur;
_ctrlButtonOK ctrlSetEventHandler ["ButtonClick","call ExileClient_gui_keypadDialog_event_onOkayButtonClick"];
_ctrlButtonCancel ctrlSetEventHandler ["ButtonClick","call ExileClient_gui_keypadDialog_event_onAbortButtonClick"];
call ExileClient_gui_keypadDialog_updateControls;
waitUntil 
{
	uiSleep 0.1;
	isNull findDisplay 24010 
};
false call ExileClient_gui_postProcessing_toggleDialogBackgroundBlur;
if((count ExileClientPinCode) != ExileClientPinCodeLength)then
{
	ExileClientPinCode = "";
};
ExileClientPinCode