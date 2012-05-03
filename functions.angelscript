//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto
//função que me dá a posição relativa do meu logo na tela 

void addShot(const uint team, const vector2 direction, const vector3 position)
{
	 ETHEntity @shot;
	AddEntity("shot.ent",position,shot);
	shot.SetUInt("time",team);
	shot.SetVector2("direcao",direction);
	shot.SetFloat("speed",60.0f);
}