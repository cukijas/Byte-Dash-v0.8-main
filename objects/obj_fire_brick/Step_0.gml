event_inherited();

// Lógica de contador
brickTimer += 1;

// Cálculo total
var totalDuration = Fase1Length + Fase2Length + Fase3Length + Fase4Length + Fase5Length;

// Verificación de destrucción
if (brickTimer >= totalDuration) {
    destroyBrick();
}