if (instance_position(mouse_x, mouse_y, par_player) && mouse_check_button_pressed(mb_left))
{
    if (global.moving == false && global.attacking == false)
    {
        var player;
        player = instance_nearest(mouse_x, mouse_y, par_player);
        
        global.selected = player;
        
        with (obj_move_square) {instance_destroy();}
        with (obj_attack_square) {instance_destroy();}

        /*if (player.type == 2)
        {
            if (player.attacked == false)
            {
                with (par_enemy)
                {
                    if (distance_to_object(global.selected <= 130)) {instance_create(x,y,obj_attack_square);}
                }
            }
        }*/
        
        scr_place_move_squares();
    }
}

else if (!instance_position(mouse_x, mouse_y, par_player) && mouse_check_button_pressed(mb_left))
{
    if (global.moving == false && global.attacking == false)
    {
        global.selected = noone;
        with (obj_move_square) {instance_destroy();} 
        with (obj_attack_square) {instance_destroy();}
    }
}

if (global.selected != noone && mouse_check_button_pressed(mb_right))
{
    if (instance_position(mouse_x, mouse_y, obj_move_square))
    {
        global.moving = true;
        with (obj_move_square) {instance_destroy();}
        with (obj_attack_square) {instance_destroy();}
        with (global.selected)
        {
            sprite_index = run_anim;
            scr_navigation(x, y, round(mouse_x/32)*32, round(mouse_y/32)*32, pace);
            pixel_dist -= path_get_length(global.navigate); // diminue la distance de mouvement
        }
    }
    else if (instance_position(mouse_x, mouse_y, obj_attack_square))
    {
        global.enemy = instance_position(mouse_x, mouse_y, par_enemy);
        global.attacking = true;
        with (global.selected)
        {
            attacked = true;
            if (type == 1)
            {
                if (distance_to_object(global.enemy) > 13)
                {
                    global.moving = true;
                    scr_calculate_dist();
                    sprite_index = run_anim;
                    scr_navigation(x,y,round(global.attack_travel_x/32)*32, round(global.attack_travel_y/32)*32, pace);
                }
            }
            /*else if (type == 2)
            {
                if (global.enemy.x < x-5) {image_xscale = -1;}
                sprite_index = ranged_anim;
                image_index = 0;
            }*/
        }
        with (obj_move_square) {instance_destroy();}
        with (obj_attack_square) {instance_destroy();}
    }
}

if (global.moving == true)
{
    with (global.selected)
    {
        if (path_index == -1)
        {
            sprite_index = idle_anim;
            cur_node_x = x;
            cur_node_y = y;
            global.moving =false;
        }
    }
}

if (global.attacking == true)
{
    if (global.moving == false)
    {
        with (global.selected)
        {
            if (type == 1) {scr_melee_attack();}
            /*else if (type == 2) {scr_ranged_attack();}*/
            attacked = true;
        }
    }
}
