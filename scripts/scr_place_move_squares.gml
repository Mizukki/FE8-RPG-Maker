mp_grid_clear_rectangle(global.map_grid,0,0,640,360);
with (par_player)
{
    if (self.id != global.selected.id) {mp_grid_add_rectangle(global.map_grid,x,y,x,y);}
}

with (par_ennemy)
{
    mp_grid_add_rectangle(global.map_grid,x,y,x,y);
}

for (i=0; i<18; i+=1;)
{
    var i_x;
    i_x = 64+32*i;
    
    if (mp_grid_path(global.map_grid, global.navigate, global.selected.cur_node_x, global.selected.cur_node_y, i_x, row, 1))
    {
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
    
    if (i_x >= 576)
    {
        i = -1;
        row += 32;
    }
    
    if (row > 600)
    {
        row = 128;
        i = 30;
        return false;
    }
}
