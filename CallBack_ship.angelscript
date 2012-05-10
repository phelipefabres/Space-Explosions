//Asantee Games
//Game: Space Explosions


//callback os the ships statics


void ETHCallback_ship(ETHEntity @ ship)
{
	ship.SetColor(vector3(1,0,0));
	
	//if the "hp" of the entity is over, less/equal than 0, the entity is deleted
	if(ship.GetInt("hp") <= 0)
	{
		//AddEntity("explosion.ent",ship.GetPosition(),0);
		AddScaledEntity("explosion.ent",ship.GetPosition(),g_scale.getScale());
		DeleteEntity(ship);
		PlaySample("soundfx/explosion_huge.mp3");
	}
}


//callback of the main ship, the Destroyer


void ETHCallback_Destroyer(ETHEntity @ ship)
{
	ETHInput @input = GetInputHandle();
	
	
	
	float speed = g_timeManager.scaledUnitsPerSecond(120.0f);
	
	//keyboard handle
	if(input.KeyDown(K_SHIFT))
	{
		speed *=2.0f;
	}
	
	
	
	if(input.KeyDown(K_UP))
	{
		ship.AddToPositionXY(vector2(0,-1)* speed);
	}
	
	if(input.KeyDown(K_DOWN))
	{
		ship.AddToPositionXY(vector2(0,1)* speed);
	}
	if(input.KeyDown(K_LEFT))
	{
		ship.AddToPositionXY(vector2(-1,0)* speed);
	}
	if(input.KeyDown(K_RIGHT))
	{
		ship.AddToPositionXY(vector2(1,0)* speed);
	}
	
	
	
	
	//creating a shot from the Destroyer
	
	if(input.GetKeyState(K_SPACE) == KS_HIT)
	{
		addShot(1,vector2(0,-5),ship.GetPosition(),60.0f);
		PlaySample("soundfx/tiro.mp3");
		
	}
	
	//if the "hp" of the entity is over, less/equal than 0, the entity is deleted
	if(ship.GetInt("hp") <= 0)
	{
		//AddEntity("explosion.ent",ship.GetPosition(),0);
		AddScaledEntity("explosion.ent",ship.GetPosition(),g_scale.getScale());
		DeleteEntity(ship);
		PlaySample("soundfx/explosion_huge.mp3");
		return;
	}
	
	//control of colision from the Destroyer with the other "things" in the scene
	
	ETHEntityArray shipArray;
	
	vector2 BucketShip(GetBucket(ship.GetPositionXY()));
	
	GetEntitiesFromBucket(BucketShip,shipArray);
	GetEntitiesFromBucket(BucketShip + vector2(0,-1),shipArray);
	GetEntitiesFromBucket(BucketShip + vector2(0,1),shipArray);
	GetEntitiesFromBucket(BucketShip + vector2(-1,0),shipArray);
	GetEntitiesFromBucket(BucketShip + vector2(1,0),shipArray);
	GetEntitiesFromBucket(BucketShip + vector2(-1,-1),shipArray);
	GetEntitiesFromBucket(BucketShip + vector2(1,1),shipArray);

	for(uint i=0; i<shipArray.size(); i++)
	{
		if(shipArray[i].GetUInt("destroyable") == 1)
		{
				if(shipArray[i].GetUInt("team") != ship.GetUInt("team"))
				{
					if(distance(ship.GetPositionXY(),shipArray[i].GetPositionXY()) < 64 )
					{
					print(shipArray[i].GetEntityName());
					shipArray[i].AddToInt("hp",-1);
					ship.AddToInt("hp",-1);
				
								
							
				
					}
			   }
		}
		
	}
	
	
	//handle the screen so the Destroyer don't go out of the screen
	if(ship.GetPositionXY().y > GetScreenSize().y)
		ship.SetPositionXY(vector2(ship.GetPositionXY().x,GetScreenSize().y));
	else if(ship.GetPositionXY().y < 0)
		ship.SetPositionXY(vector2(ship.GetPositionXY().x,0));
	else if(ship.GetPositionXY().x > GetScreenSize().x)
		ship.SetPositionXY(vector2(GetScreenSize().x,ship.GetPositionXY().y));
	else if(ship.GetPositionXY().x < 0)
		ship.SetPositionXY(vector2(0,ship.GetPositionXY().y));
	
}

