function respawn_player() {
    // Usamos 'with' para asegurarnos de que afecte al jugador aunque sea persistente
    with (obj_player) {
        // 1. Reset de estadísticas
        hp = 20; 
        vidas = 10; // Esto debería resetear los corazones del HUD
        
        // 2. Reset visual y de estado
        visible = true;
        image_alpha = 1;
        sprite_index = idleSpr; // Usamos tu variable del Create
        image_index = 0;
        
        // 3. Parar movimiento
        xspd = 0;
        yspd = 0;
        
        // 4. Posición y Viaje
        // Ajusta estos números a las coordenadas de inicio de tu Room1
        x = 32; 
        y = 224;
        
        room_goto(Room1);
    }
}