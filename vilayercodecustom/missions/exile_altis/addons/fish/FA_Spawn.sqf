private ["_object", "_Continue", "_ClosestObject", "_dir", "_vel", "_speed", "_player", "_Getdamage"];

[] spawn FA_ArrayBuilder;

waitUntil {count FA_FishFood > 0};

//While FISHATTACK is true, run this script
while {FISHATTACK} do 
{
	[] spawn 
	{
		_object = FISHGROUP createUnit ["Rabbit_F",getpos FishSpawn,[],10,"FORM"];
		_object addRating -10000;
		_object setspeaker "NoVoice";
		FA_FishActiveArray pushback _object;
		_Continue = true;
		_object addEventHandler ["HandleDamage",{_this call FishDamage;}];
		while {alive _object && _Continue} do
		{
			_ClosestObject = [FA_FishFood,_object] call BIS_fnc_nearestPosition;
			_object domove (getpos _ClosestObject);
			waitUntil {(getPos _object select 2) < 1;};
			_object setDir ([_object,_ClosestObject] call BIS_fnc_dirTo);
			_dir = direction _object;
			_vel = velocity _object;
			_speed = 4;
			_object setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+ (cos _dir*_speed),(_vel select 2)+ 6];
			
			if ((_object distance _ClosestObject) < 1) then {
			
			_object attachto [(vehicle _ClosestObject),[0,0,(random 2)]];
			[
			[
			[_object,(vehicle _ClosestObject)],
			{
				_object = _this select 0;
				_player = _this select 1;
				while {alive _object && alive _player} do
				{
					_object say3D "Scared_Animal5";
					_Getdamage = getDammage _player;
					_player setdamage (_Getdamage + 0.05);
					sleep (random 10);
				};
				detach _object;
				_object setdamage 1;
				sleep Fish_BodyRemovalRate;
				deletevehicle _object;
			}],"BIS_fnc_spawn",true,false,false] spawn BIS_fnc_MP;
			_Continue = false;

			
			};
			sleep 1;
		};
		sleep Fish_BodyRemovalRate;
		deletevehicle _object;
	};
sleep Fish_RespawnRate;
};