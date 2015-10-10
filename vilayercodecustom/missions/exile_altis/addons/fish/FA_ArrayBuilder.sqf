private ["_CheckVariable", "_ClassName", "_Array1", "_Array2"];

while {FISHATTACK} do 
{
	if ((count allUnits) > 0) then 
  {
		sleep 0.25;
    {
			_CheckVariable = _x getVariable "FISH_ADDED";
			if (isNil ("_CheckVariable")) then {_CheckVariable = 0;};
			_ClassName = typeOf _x;
			if (_ClassName isEqualTo "Tuna_F") then {_CheckVariable = 1};
			if (_CheckVariable isEqualTo 0) then {FA_FishFood pushBack _x;_x setVariable ["FISH_ADDED",1,false];};
		} forEach allUnits;

		sleep 0.25;
		publicVariable "FA_FishFood";
		sleep 2;
 
		_Array1 = []; 
		{
			if (!(alive _x)) then {_Array1 pushBack _x};
		}foreach FA_FishActiveArray; 
    {
      FA_FishActiveArray = FA_FishActiveArray - [_x];
    } foreach _Array1;
    
 		_Array2 = []; 
		{
			if (!(alive _x)) then {_Array2 pushBack _x};
		}foreach FA_FishFood; 
    {
      FA_FishFood = FA_FishFood - [_x];
    } foreach _Array2;   
    

		sleep 2;
	};
};