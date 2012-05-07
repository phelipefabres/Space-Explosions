//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto


//callback of the ship with hp=2


void ETHCallback_boss(ETHEntity@ boss)
{
		boss.SetAngle(180.0f);
//		boss.SetInt("hp",2);
		boss.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,3))*30.0f);
		
		if(boss.GetPositionXY().y > GetScreenSize().y)
			DeleteEntity(boss);
			
		if(boss.GetInt("hp") <= 0)
		{
			AddEntity("explosion.ent",boss.GetPosition(),0);
			DeleteEntity(boss);
			PlaySample("soundfx/explosion_huge.mp3");
		}
		
		
		
		if(boss.GetUInt("tiro") >= 1000)
		{
			addShot(2,vector2(0,10),boss.GetPosition());
			PlaySample("soundfx/tiro.mp3");
			boss.SetUInt("tiro",0);
		}
		
		boss.AddToUInt("tiro",g_timeManager.getLastFrameElapsedTime());
}


//the others dinamycs ships 
void ETHCallback_otherShip(ETHEntity@ otherShip)
{
	
		otherShip.SetAngle(180.0f);
		otherShip.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,3))*30.0f);
		if(otherShip.GetPositionXY().y > GetScreenSize().y)
			DeleteEntity(otherShip);
			
		if(otherShip.GetInt("hp") <= 0)
		{
			AddEntity("explosion.ent",otherShip.GetPosition(),0);
			DeleteEntity(otherShip);
			PlaySample("soundfx/explosion_huge.mp3");
		}	
	
}

 