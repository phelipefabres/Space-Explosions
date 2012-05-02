//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto


//callback dos asteroides

//movimento do asteroid, no caso o 'AddToAngle' faz com que ele gire no próprio eixo no sentido horário em uma velocidade
void ETHCallback_nave_chefe(ETHEntity@ chefe)
{
		chefe.SetAngle(180.0f);
//		chefe.SetInt("hp",2);
		chefe.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,3))*30.0f);
		
		if(chefe.GetPositionXY().y > GetScreenSize().y)
			DeleteEntity(chefe);
			
		if(chefe.GetInt("hp") == 0)
		{
			AddEntity("explosion.ent",chefe.GetPosition(),0);
			DeleteEntity(chefe);
			PlaySample("soundfx/explosion_huge.mp3");
		}
		
		ETHEntity@ tiro;
		
		if(chefe.GetUInt("tiro") >= 1000)
		{
			AddEntity("shot.ent",chefe.GetPosition(),tiro);
			PlaySample("soundfx/tiro.mp3");
			tiro.SetString("tipo","chefe");
			chefe.SetUInt("tiro",0);
		}
		
		chefe.AddToUInt("tiro",g_timeManager.getLastFrameElapsedTime());
}


//movimentando minha entidade 'tiro'
void ETHCallback_nave_aux(ETHEntity@ auxiliar)
{
	
		auxiliar.SetAngle(180.0f);
		auxiliar.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,3))*30.0f);
		if(auxiliar.GetPositionXY().y > GetScreenSize().y)
			DeleteEntity(auxiliar);
			
		if(auxiliar.GetInt("hp") == 0)
		{
			AddEntity("explosion.ent",auxiliar.GetPosition(),0);
			DeleteEntity(auxiliar);
			PlaySample("soundfx/explosion_huge.mp3");
		}	
	
}

 