pos = {
	x: camera_get_view_x(view_camera[0]),
	y: camera_get_view_y(view_camera[0])
}

bgx++

draw_sprite_tiled_ext(bg, 0, pos.x * 0.9, pos.y * 0.9, 1, 1, c_white, 0.25)
draw_sprite_tiled_ext(bg2, 0, (pos.x * 0.5) + bgx, pos.y * 0.5, 1, 1, c_white, 0.25)
