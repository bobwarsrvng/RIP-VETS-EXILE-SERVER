if (isServer) then
{
	FA_Init = compile preprocessFile "FA_Spawn.sqf";
	FA_ArrayBuilder = compile preprocessFile "FA_ArrayBuilder.sqf";
	
	//You can set this to false to disable the fish spawning. You just need to use " [] spawn FA_Init " to get the fish attacking again.
	FISHATTACK = true;
	//Creating a group for the fish to use
	FISHGROUP = createGroup Civilian;
	//Spawn rate of the fish
	Fish_RespawnRate = 30; //2 seconds
	//How long to wait before removing the bodies
	Fish_BodyRemovalRate = 30; //30 seconds
	//Array of active fishes
	FA_FishActiveArray = [];
	//Array of active fish food
	FA_FishFood = [];
	
	//The below prevents fish from killing themselves from fall damage.
	FishDamage = 
	{
		_unit = _this select 0;
		_damage = _this select 2;
		_source = _this select 3;
		_projectile = _this select 4;

		if (_projectile isEqualTo "") then {0} else {_damage};
		
	};

	
	
	
	sleep 0.001;
	[] spawn FA_Init;
	
	
};