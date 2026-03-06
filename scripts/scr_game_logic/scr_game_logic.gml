function respawn_player() {
    // Usamos 'with' para obligar a que el código afecte al jugador
    with (obj_player) {
        // 1. Reset de estadísticas
		audio_play_sound(snd_fall, 10, false);
		
        hp = 20; 
        vidas = 10; 
        
        // 2. Reset visual y de estado
        visible = true;
        image_alpha = 1;
        sprite_index = idleSpr; 
        image_index = 0;
        
        // 3. Frenar movimiento
        xspd = 0;
        yspd = 0;
        
        // 4. Posición y Viaje
        // Ajusta estos valores a las coordenadas de inicio de tu Room1
        x = 32; 
        y = 224;
        
        room_goto(Room1);
    }
}