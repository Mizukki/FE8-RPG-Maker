

if (sprite_index == ranged_anim)
{
    if (image_index >= image_number-1)
    {
        instance_create(x+5,y,my_projectile);
        sprite_index = idle_anim;
        image_index = 0;
    }
}

with (my_projectile)
{
    image_angle = direction;
    move_towards_point(global.ennemy.x, global.ennemy.y, 15);
    
    if (instance_place(x,y,global.ennemy))
    {
        global.damage_dealt = irandom(global.selected.attack);
        global.ennemy.defence -= global.damage_dealt;
        instance_create(global.ennemy.x, global.ennemy.y, obj_damage_dealt);
        if (global.ennemy.defence <= 0)
        {
            global.ennemy.image_index = 0;
            global.ennemy.sprite_index = global.ennemy.death_anim;
        }
        global.attacking = false;
        global.selected.image_xscale = 1;
        global.ennemy = noone;
        instance_destroy(); 
    }
}
