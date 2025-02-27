/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_position","_range","_flags","_isInRange"];
_position = _this select 0;
_range = _this select 1;
_flags = _position nearObjects ["Exile_Construction_Flag_Static", _range];
_isInRange = !(_flags isEqualTo []);
_isInRange