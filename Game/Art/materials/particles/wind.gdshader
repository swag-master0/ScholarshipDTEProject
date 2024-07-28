shader_type particles;

void start() {
	// Called when a particle is spawned.
}

void process() {
	VELOCITY.x += 5.0;
	// Called every frame on existing particles (according to the Fixed FPS property).
}
