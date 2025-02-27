/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_position","_range","_players"];
_position = _this select 0;
_range = _this select 1;
_players = [];
{
	if (alive _x) then
	{
		if ((vehicle _x) isEqualTo _x) then
		{
			if ((_x distance2D _position) <= _range) exitWith
			{
				_players pushBack _x;
			};
		};
	};
}
forEach allPlayers;
_players