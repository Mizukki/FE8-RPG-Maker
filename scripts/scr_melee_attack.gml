

if (sprite_index != melee_anim)
{
    sprite_index = melee_anim;
    image_index = 0.1;
}

if (image_index >= image_number-1)
{
    sprite_index = idle_anim;
    
    global.damage_dealt = irandom(global.selected.attack);
    global.ennemy.defence -= global.damage_dealt;
    //create damage object
    instance_create(global.ennemy.x, global.ennemy.y, obj_damage_dealt);
    if (global.ennemy.defence <= 0)
    {
        global.ennemy.sprite_index = global.ennemy.death_anim;
        global.ennemy.image_index = 0;
    }
    
    global.attacking = false;
    image_xscale = 1;
    global.ennemy = noone; 
}
