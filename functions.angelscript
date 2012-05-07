//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//function that add a shot

void addShot(const uint team, const vector2 direction, const vector3 position)
{
	 ETHEntity @shot;
	AddEntity("shot.ent",position,shot);
	shot.SetUInt("time",team);
	shot.SetVector2("direcao",direction);
	shot.SetFloat("speed",60.0f);
}