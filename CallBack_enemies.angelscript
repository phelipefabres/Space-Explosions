//Asantee Games
//Game: Space Explosions


//callback of the ship with hp=2


void ETHCallback_boss(ETHEntity@ boss)
{
		boss.SetAngle(180.0f);
		boss.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,3))*20.0f);
		
		if(boss.GetPositionXY().y > GetScreenSize().y)
			DeleteEntity(boss);

		//if the "hp" of the entity is over, less/equal than 0, the entity is deleted
		if(boss.GetInt("hp") <= 0)
		{
			AddEntity("explosion.ent",boss.GetPosition(),0);
			DeleteEntity(boss);
			PlaySample("soundfx/explosion_huge.mp3");
		}
		
		
		//the enemy shot at every 3 seconds
		if(boss.GetUInt("shot") >= 3000)
		{
			addShot(2,vector2(0,10),boss.GetPosition(),30.0f);
			PlaySample("soundfx/tiro.mp3");
			boss.SetUInt("shot",0);
		}
		
		boss.AddToUInt("shot",g_timeManager.getLastFrameElapsedTime());
}


//the others dinamycs ships 
void ETHCallback_otherShip(ETHEntity@ otherShip)
{
	
		otherShip.SetAngle(180.0f);
		otherShip.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,3))*30.0f);
		if(otherShip.GetPositionXY().y > GetScreenSize().y)
			DeleteEntity(otherShip);
//if the "hp" of the entity is over, less/equal than 0, the entity is deleted			
		if(otherShip.GetInt("hp") <= 0)
		{
			AddEntity("explosion.ent",otherShip.GetPosition(),0);
			DeleteEntity(otherShip);
			PlaySample("soundfx/explosion_huge.mp3");
		}	
	
}

 