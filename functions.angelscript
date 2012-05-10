//Asantee Games
//Game: Space Explosions

//function that add a shot

void addShot(const uint team, const vector2 direction, const vector3 position, const float speed)
{
	 ETHEntity @shot;
	AddEntity("shot.ent",position,shot);
	shot.SetUInt("team",team);
	shot.SetVector2("direction",direction);
	shot.SetFloat("speed",g_scale.scale(speed));
}