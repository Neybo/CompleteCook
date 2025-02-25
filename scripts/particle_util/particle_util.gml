enum particles {
	bleh, // unused
	genericpoof, // replace with an even more generic name
	gib,
	stars,
	parry,
	taunt,
	machcharge,
	bang,
	yellowstar
}

function particle_create(_x, _y, p_type, _xscale = 1, _yscale = 1, _sprite = noone)
{
	var p = {
		sprite_index: spr_null,
		image_index: 0,
		image_speed: 0.35,
		x: _x,
		y: _y,
		image_xscale: _xscale,
		image_yscale: _yscale,
		image_blend: c_white,
		image_angle: 0,
		image_alpha: 1,
		depth: 0,
		type: p_type
	}
	switch (p_type)
	{
		case particles.genericpoof:
			p.sprite_index = spr_genericpoofeffect
			p.image_speed = 0.35
			break;
		case particles.gib:
		case particles.stars:
			p.sprite_index = p_type == particles.gib ? spr_gibs : spr_gibstars
			p.image_index = random_range(0, sprite_get_number(p.sprite_index))
			p.image_speed = 0
			p.hsp = irandom_range(6, -6)
			p.vsp = irandom_range(12, -12)
			p.image_angle = random_range(0, 360)
			break;
		case particles.yellowstar:
			p.sprite_index = spr_gibstars
			p.image_speed = 0
			p.hsp = random_range(6, -6)
			p.vsp = random_range(12, -12)
			p.image_angle = random_range(0, 360)
			break;
		case particles.parry:
			p.sprite_index = spr_parryflash
			p.depth = -230
			break;
		case particles.taunt:
			p.sprite_index = spr_taunteffect
			break;
		case particles.machcharge:
			p.sprite_index = spr_mach3charge
			p.image_speed = 0.5
			obj_particlecontroller.active_particles.machcharge = true
			break;
		case particles.bang:
			p.sprite_index = spr_bangeffect
			p.image_speed = 0.5
			break;
	}
	
	if _sprite != noone
		p.sprite_index = _sprite
	
	p.image_number = sprite_get_number(p.sprite_index)
	with (obj_particlecontroller)
		array_push(particle_list, p)
}

function particle_sprite_exists(sprite)
{
	for (var i = 0; i < array_length(obj_particlecontroller.particle_list); i++) 
	{
	    var p = obj_particlecontroller.particle_list[i]
		if p.sprite_index == sprite
		{
			return true;
			break;
		}
	}
	return false;
}
