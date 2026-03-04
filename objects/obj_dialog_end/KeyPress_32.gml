// Avanzar a la siguiente línea de texto
current_line += 1;

// Verificar si hemos llegado al final de la lista
if (current_line >= array_length(dialog_lines)) {
    // Al finalizar el diálogo, ir a una room de "Gracias por jugar" o Reiniciar
    show_message("FIN DE LA DEMO - ¡Gracias por jugar!");
    
    // Aquí puedes cambiar a una room de menú:
    // room_goto(rm_main_menu); 
	
	global.dialogo_activo = false;
    
    // O simplemente reiniciar el juego para esta demo:
    game_restart();
    
    // Muy importante: destruir este objeto para que no siga ejecutándose
    instance_destroy(); 
}

else {
    // Nos aseguramos de que el actor exista en la room
    if (instance_exists(obj_trojan)) {
        
        // Dependiendo de qué línea estemos leyendo, cambiamos la animación
        switch (current_line) {
            case 0:
                // Línea 0: Troj habla por primera vez. Se mantiene quieto.
                obj_trojan.sprite_index = spr_idle_trojan;
                break;
                
            case 2:
                // Línea 2: Troj se ríe y se burla. Podríamos ponerlo a caminar o amenazar.
                // Asegúrate de tener un spr_trojan_walk o el que prefieras usar aquí.
                obj_trojan.sprite_index = spr_attack_trojan;
                break;
                
            case 4:
                // Línea 4: "(Troj se disuelve por completo...)"
                // Si tienes un sprite de muerte, lo pones aquí.
                // Si no, podemos destruirlo directamente para que desaparezca.
                instance_destroy(obj_trojan);
                break;
        }
    }
}