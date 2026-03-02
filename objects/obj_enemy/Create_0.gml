//variables iniciales
startX = x;
startY = y;
event_inherited();

//variables daño
hp = 10;
damager = noone;
damageCooldown = 15;
damageTimer = 0;


//variables movimiento en Y
grav = 0.275;
yspd = 0;

//variables movimiento en X
spd = 1.5;
face = choose(1,-1);
xspd = 0;

maxRightMov = startX + 100;
maxLeftMov = startX - 100;
minMov = 30;
maxMov = 35;
dirTimer = 30;
waitTimer = 15;
dirAtack = 0;

freezeTime = 100; // tiempo que se congela
freezeTimer =0;
frozen = false;


// variables de deteccion de ataque
timerAttack = 0;
isAttacking = false;
attackStarted = false;

//variables modificables del ataque
visionRangeX = 100;
visionRangeY = 40;
attackCooldown = 60;
attackOffsetX = 0;
attackOffsetY = 0;
objAttack = noone;

target = noone;





// variables Sprites
sprIdle = TestEnemy;
sprWalk = TestEnemy;
sprAttack = TestEnemy;
sprDeath = TestEnemy;


