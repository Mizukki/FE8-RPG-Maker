if (sprite_index != melee_anim)
{
//    if (global.enemy.x > x-5) {image_xscale = 1;}
    sprite_index = melee_anim;
    image_index = 0;
}

if (image_index >= image_number-1)
{
    sprite_index = idle_anim;
    global.damage_dealt = irandom(attack);
    global.enemy.defence -= global.damage_dealt;
    instance_create(global.enemy.x, global.enemy.y, obj_damage_dealt);
    if (global.enemy.defence <= 0)
    {
        global.enemy.image_index = 0;
        global.enemy.sprite_index = global.enemy.death_anim;
    }
    
    //image_xscale = -1;
    with (obj_attack_square_ai) {instance_destroy();}
    global.enemy = noone;
    attacked = true;
    if (instance_number(par_player) < 1) {global.state = states.fail_state;}
}
