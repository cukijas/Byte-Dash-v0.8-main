function controlsSetup(){
	jumpBufferTime = 5;
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
}
function getControls(){	
	//Direcciones
	rightKey = keyboard_check(ord("D")) + gamepad_button_check(0,gp_padr);
	rightKey = clamp(rightKey,0,1);
	
	leftKey = keyboard_check(ord("A")) + gamepad_button_check(0,gp_padl);
	leftKey = clamp(leftKey,0,1);
	
	downKey = keyboard_check(ord("S")) + gamepad_button_check(0,gp_padd);
	downKey = clamp(downKey,0,1);
	
	attackKey = keyboard_check_pressed(vk_space) + gamepad_button_check_pressed(0,gp_face2);
	attackKey = clamp(attackKey,0,1);
	
	//Habilidades
	dashKey = keyboard_check_pressed(vk_shift) + gamepad_button_check_pressed(0,gp_shoulderlb);
	dashKey = clamp(dashKey,0,1);
	
	brickKey = keyboard_check_pressed(ord("E")) + gamepad_button_check_pressed(0,gp_shoulderrb);
	brickKey = clamp(brickKey,0,1);
	
	fsKey = keyboard_check_pressed(ord("Q")) + gamepad_button_check_pressed(0, gp_shoulderl);
	fsKey = clamp(fsKey,0,1);
	
	//Acciones
	jumpKeyPressed = keyboard_check_pressed(ord("W")) + gamepad_button_check_pressed(0,gp_face1);
	jumpKeyPressed = clamp(jumpKeyPressed,0,1);
	
	jumpKey = keyboard_check(ord("W")) + gamepad_button_check(0,gp_face1);
	jumpKey = clamp(jumpKey,0,1);


	runKey = keyboard_check(vk_control) + gamepad_button_check(0,gp_face3);
	runKey = clamp(runKey,0,1);
	

	//Buffering del salto
	
	if jumpKeyPressed
	{
		jumpKeyBufferTimer = jumpBufferTime;
	}
	
	
	if jumpKeyBufferTimer > 0 {
	
		jumpKeyBuffered = 1; 
		jumpKeyBufferTimer--;
	
	}else{
		jumpKeyBuffered = 0;
	}
	
}