mp_grid_clear_rectangle(global.map_grid,0,0,512,352);

with (par_player)
{
    if (self.id != global.selected.id) 
    {
        mp_grid_add_rectangle(global.map_grid,x,y,x,y);
    }
}

with (obj_wall)
{
    mp_grid_add_rectangle(global.map_grid,x,y,x,y);
}

with (par_enemy)
{
    mp_grid_add_rectangle(global.map_grid,x,y,x,y); //can t move on an ally
}


for (i=0; i<16; i+=1;)
{
    var i_x;
    i_x = 32+32*i;
    
    if (mp_grid_path(global.map_grid, global.navigate, global.selected.cur_node_x, global.selected.cur_node_y, i_x, row, 0))
    {
        ///////////////
        /*if (!place_free(cur_node_x,cur_node_y))
        {
            mp_grid_add_rectangle(global.map_grid, i_x, row, i_x, row);
        }*/
        ///////////
            
        if (path_get_length(global.navigate) <= global.selected.pixel_dist)
        {
            instance_create(i_x, row, obj_move_square);
        }
        else
        {
            mp_grid_add_rectangle(global.map_grid, i_x, row, i_x, row);
        }
    }
    else { mp_grid_add_rectangle(global.map_grid, i_x, row, i_x, row);}
    
    if (i_x >= 496)
    {
        i = -1;
        row += 32;
    }
    
    if (row > 336)
    {
        row = 32;
        i = 20;
        return false;
    }
}
