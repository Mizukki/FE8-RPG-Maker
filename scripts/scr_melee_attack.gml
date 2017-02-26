

if (sprite_index != melee_anim)
{
    sprite_index = melee_anim;
    image_index = 0;
}

if (image_index >= image_number-1)
{
    sprite_index = idle_anim;
    
    global.damage_dealt = irandom(global.selected.attack);
    global.enemy.defence -= global.damage_dealt;
    //create damage object
    instance_create(global.enemy.x, global.enemy.y, obj_damage_dealt);
    if (global.enemy.defence <= 0)
    {
        global.enemy.sprite_index = global.enemy.death_anim;
        global.enemy.image_index = 0;
    }
    
    
    
    global.attacking = false;
    image_xscale = 1;
    global.ennemy = noone; 
}
