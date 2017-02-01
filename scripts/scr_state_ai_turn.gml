if (instance_number(par_player) < 1) {global.state = states.fail_state;}

if (global.ai_selected == noone)
{
    if (global.ai_activated == false)
    {
        ai_active = instance_number(par_ennemy) - global.ai_id;
        global.ai_selected = instance_find(par_ennemy, ai_active);
        
        scr_place_move_squares_ai();
        global.ai_activated = true;
    }
}

with (global.ai_selected)
{
    if (global.ai_activated == true)
    {
        nearest_target = instance_nearest(x,y,par_player);
        nearest_move = instance_nearest(nearest_target.x, nearest_target.y, obj_move_square_ai);
        nearest_attack = instance_nearest(x,y,obj_attack_square_ai);
        
        if (type == 1)
        {
            if (moved == false)
            {
                sprite_index = run_anim;
                scr_navigation(x,y,round(nearest_move.x/32)*32, round(nearest_move.y/32)*32,pace);
            }
            if (path_index == -1)
            {
                if (moved == false) {sprite_index = idle_anim;}
                moved = true;
                if (instance_exists(obj_attack_square_ai)) 
                {
                    global.ennemy = instance_position(nearest_attack.x, nearest_attack.y, par_player);
                    scr_melee_attack_ai();
                }
                else {attacked = true;}
                with (obj_move_square_ai) {instance_destroy();}
                cur_node_x = round(x/32)*32;
                cur_node_y = round(y/32)*32;
                
                if (attacked == true && moved == true)
                {
                    global.ennemy = noone;
                    global.ai_id += 1;
                    global.ai_selected = noone;
                    global.ai_activated = false;
                }
            }
        }
        else if (type == 2)
        {
            if (acquired_targets == false)
            {
                with (par_player)
                {
                    if (distance_to_object(global.ai_selected) <= 130) {instance_create(x,y,obj_attack_square_ai);}
                }
                nearest_attack = instance_nearest(x,y,obj_attack_square_ai);
                acquired_targets = true;
            }
            if (instance_exists(obj_attack_square_ai))
            {
                global.ennemy = instance_position(nearest_attack.x, nearest_attack.y, par_player);
                sprite_index = ranged_anim;
                moved = true;
                scr_ranged_attack_ai();
            }
            else if (!instance_exists(obj_attack_square_ai))
            {
                attacked = true;
                if (moved == false)
                {
                    sprite_index = run_anim;
                    scr_navigation(x,y,round(nearest_move.x/32)*32, round(nearest_move.y/32)*32,pace);
                }
            }
            if (path_index == -1)
            {
                if (moved == false) {sprite_index = idle_anim;}
                moved = true;
                cur_node_x = round(x/32)*32;
                cur_node_y = round(y/32)*32;
                with (obj_move_square_ai) {instance_destroy();}
                if (attacked == true && moved == true)
                {
                    global.ennemy = noone;
                    global.ai_id += 1;
                    global.ai_selected = noone;
                    global.ai_activated = false;
                }
            }
        }
    }
}

if (global.ai_id > instance_number(par_ennemy))
{
    global.state = states.p_turn;
    global.ai_selected = noone;
    global.ai_id = 1;
    with (par_ennemy)
    {
        attacked = false;
        moved = false;
        acquired_targets = false;
    }
}
