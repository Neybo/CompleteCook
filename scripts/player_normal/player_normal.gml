function player_normal()
{
	var default_idle = spr_player_idle
	var default_move = spr_player_move
	if global.panic.active
	{
		default_idle = spr_player_panic
		
		if global.panic.timer <= 0
		{
			default_idle = spr_player_weak
			default_move = spr_player_weakmove
		}
	}
	
	if (p_move != 0)
	{
		movespeed = approach(movespeed, 8, movespeed > 8 ? 0.1 : 0.5)
		if (floor(movespeed) == 8)
			movespeed = 6
		xscale = p_move
	}
	else
		movespeed = 0
	
	hsp = movespeed * xscale
	
	var idlegestures = [
	spr_player_idlefrown, 
	spr_player_idledance, 
	spr_player_idlehand, 
	spr_player_idlecareless, 
	spr_player_idlewhat,
	spr_player_idlebite
	]
	
	if p_move != 0
		idletimer = 120
	
	if (breakdance_secret.buffer < 10)
	{
		if p_move != 0
		{
			if (sprite_index != spr_player_landmove)
				sprite_index = default_move
		}
		else
		{
			if (idletimer <= 0 && idletimer != -4)
			{
				reset_anim(idlegestures[irandom(5)])
				idletimer = -4
			}
			
			if (anim_ended() && idletimer == -4)
			{
				reset_anim(default_idle)
				idletimer = 180
			}
			
			if (sprite_index != spr_player_machslideend && sprite_index != spr_player_land && sprite_index != spr_player_bodyslamland && sprite_index != spr_player_facehurt && idletimer > 0)
				sprite_index = default_idle
		}
	}
	
	image_speed = 0.35
	
	if key_taunt.down
	{
		if breakdance_secret.buffer < 10
			breakdance_secret.buffer++
		else
		{
			sprite_index = spr_player_breakdance
			breakdance_secret.spd = approach(breakdance_secret.spd, 0.5, 0.005)
			image_speed = breakdance_secret.spd
		}
		if breakdance_secret.spd > 0.48
		{
			aftimg_timers.blur.do_it = true
			if (!instance_exists(obj_beatbox))
				instance_create(x, y, obj_beatbox)
		}
	}
	else
	{
		breakdance_secret.buffer = 0
		breakdance_secret.spd = 0.1
	}
	
	if (key_down.down || scr_solid(x, y - 16))
	{
		reset_anim(spr_player_crouchdown)
		state = states.crouch
	}
	
	if !grounded
	{
		state = states.jump
		reset_anim(spr_player_fall)
	}
	
	if (coyote_time && key_jump.pressed)
	{
		vsp = -11
		state = states.jump
		reset_anim(spr_player_jump)
		jumpstop = false
		scr_sound_3d(sfx_jump, x, y)
	}
	
	do_grab() //intentional game design
	
	if (key_dash.down && !place_meeting(x + xscale, y, obj_solid))
	{
		state = states.mach2
		if (movespeed < 6)
			movespeed = 6
		reset_anim(spr_player_mach1)
	}
	
	switch (sprite_index)
	{
		case spr_player_move:
			image_speed = movespeed / 15
			break;
		case spr_player_machslideend:
		case spr_player_land:
			reset_anim_on_end(spr_player_idle)
			break;
		case spr_player_landmove:
			image_speed = movespeed / 15
			reset_anim_on_end(spr_player_idle)
			break;
		case spr_player_facehurt:
			reset_anim_on_end(spr_player_idle)
			break;
	}
	
	do_taunt()
}