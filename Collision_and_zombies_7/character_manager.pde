class CharacterManager {
	ArrayList<Character> characters;
	int nZombies;

	CharacterManager() {
		// println("created character manager");
		characters = new ArrayList<Character>(1000);
		characters.add(new Zombie(320, 240, 20, new PVector(-5, -5)));
		nZombies = 1;
		for (int n = 0; n < 99; n++) {
			Human man;
			do {
				float x = random(835);
				float y = random(655);
				man = new Human(x, y, 20);
			} while (man.withinTerrain(terrain) == true);
			characters.add(man);
		}
	}

	void collide(int w, int h, float delta_t) {
		for (int n = characters.size() - 1; n >= 0; n--) {
			characters.get(n).edgeCollide(w, h);
			characters.get(n).backgroundCollide(terrain, delta_t);
			if (characters.get(n) instanceof Zombie) {
				float distance = 10000;
				int closestHuman = 0;
				for (int human = characters.size() - 1; human >= 0; human--) {
					if (characters.get(human) instanceof Human) {
						// Find closest human, and attack!
						float xd = characters.get(n).pos.x - characters.get(human).pos.x;
						float yd = characters.get(n).pos.y - characters.get(human).pos.y;
						if (sqrt(xd * xd + yd * yd) < distance) {
							distance = sqrt(xd * xd + yd * yd);
							closestHuman = human;
						}

						// Check if zombie and human collide	
						if (overlap(characters.get(n), characters.get(human))) {
							Human fella = (Human)characters.get(human);
							if (fella.zombieTransition == -1)
								fella.zombieTransition = 100;
								fella.clock = fella.treshold;
						}					
					}
				}

				// Aim zombie towards closest human!
				// ... and make the human run from it
				if (n != closestHuman && closestHuman != 0) {
					characters.get(n).chase(characters.get(closestHuman));
					if (characters.get(closestHuman).state == 0) {
						characters.get(closestHuman).runFrom(characters.get(n));
						Human x = (Human)characters.get(closestHuman);
						x.clock = x.treshold - 10;
					}
				}
			}
		}		
	}

	boolean overlap(Character c1, Character c2) {
		float xd = c1.pos.x - c2.pos.x;
		float yd = c1.pos.y - c2.pos.y;
		if ((xd * xd + yd * yd) < (c1.size / 2 + c2.size / 2) * (c1.size / 2 + c2.size / 2))
			return true;
		return false;
	}

	void transform(float delta_t) {
		for (int n = 0; n < characters.size(); n++) {
			characters.get(n).transform(delta_t);

			
			if (characters.get(n) instanceof Human) {
				Human fella = (Human)characters.get(n);
				if (fella.dead == true) {
					Zombie zombie = new Zombie(fella.pos.x, fella.pos.y, 20, fella.vel);
					characters.remove(n);
					characters.add(zombie);
					nZombies++;
				}
			}
		}
	}

	void draw() {
		for (Character c : characters) {
			c.draw();
		}
	}
}