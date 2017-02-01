if (sprite_index != melee_anim)
{
    if (global.ennemy.x > x-5) {image_xscale = 1;}
    sprite_index = melee_anim;
    image_index = 0;
}

if (image_index >= image_number-1)
{
    sprite_index = idle_anim;
    global.damage_dealt = irandom(attack);
    global.ennemy.defence -= global.damage_dealt;
    instance_create(global.ennemy.x, global.ennemy.y, obj_damage_dealt);
    if (global.ennemy.defence <= 0)
    {
        global.ennemy.image_index = 0;
        global.ennemy.sprite_index = global.ennemy.death_anim;
    }
    
    image_xscale = -1;
    with (obj_attack_square_ai) {instance_destroy();}
    global.ennemy = noone;
    attacked = true;
    if (instance_number(par_player) < 1) {global.state = states.fail_state;}
}
