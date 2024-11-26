/* materials:
2 baseboards: 2x8x20 2шт = $22 * 2
rafters: 2x8x12 10шт = $9.18*10
posts: 6x6x8, 4шт = $32*4
posts base 4шт = $54
osb 7 шт... = 
*/

// everything is in inches

//create a block
module block(height, width, depth) 
{
	scale([height,width,depth]) //scale
	{
			//make a cube
			cube([1,1,1]); 
	}
}

//projection(cut=false);

slab_w = 192;
slab_h = 140;
slab_d = 4;
post_h = 96;
post_w = 6;
post_slab_edge_offset = 6;
horizontal_post_overlap = 12;
house_wall_h = 112;
house_wall_d = 1;
baseboard_w = 8;
wood_d = 2;

roof_rafter_spacing = 24;
roof_rafter_size = 8;
roof_rafter_cut = 1;
roof_rafter_overlap = 12;


// create slab and 3 main posts
color("grey")translate([0,0,-slab_d])block(slab_h, slab_w, slab_d);

for (i = [0:1:3]) {
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,post_slab_edge_offset+(slab_w-post_slab_edge_offset*2-post_w)/3*i,0])block(post_w, post_w, post_h);
}
/*
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,post_slab_edge_offset,0])block(post_w, post_w, post_h); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,slab_w/3-post_w/2,0])block(post_w, post_w, post_h); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,slab_w/3*2-post_w/2,0])block(post_w, post_w, post_h); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,slab_w - post_w-post_slab_edge_offset,0])block(post_w, post_w, post_h); 
*/
baseboard_l = slab_w-post_slab_edge_offset*2+horizontal_post_overlap*2;
baseboard_offset = post_slab_edge_offset-horizontal_post_overlap;
//create horizontal post on top of main posts
color("brown")translate([slab_h-post_slab_edge_offset-wood_d,baseboard_offset,post_h-baseboard_w])block(wood_d, baseboard_l, baseboard_w); 
//create wall of the house
color("red")translate([-house_wall_d, -house_wall_h * 0.5, 0])block(house_wall_d, slab_w*2, house_wall_h); 
// create baseboard
color("green")translate([0,baseboard_offset,house_wall_h-baseboard_w])block(wood_d, baseboard_l, baseboard_w);
// create roof rafters
// calculate angle
roof_angle_tan = (house_wall_h-baseboard_w - (post_h-roof_rafter_cut)) / (slab_h - wood_d - post_slab_edge_offset);
roof_angle = atan(roof_angle_tan);
rafter_horizontal_l = slab_h - post_slab_edge_offset - wood_d;
rafter_l = rafter_horizontal_l / cos(roof_angle) + roof_rafter_overlap;
echo(rafter_l, baseboard_l);
rafter_n = baseboard_l/roof_rafter_spacing + 1;

for (i = [0:1:rafter_n]) {
color("blue")translate([wood_d,min(baseboard_offset + i * roof_rafter_spacing, baseboard_l+baseboard_offset-wood_d),house_wall_h-baseboard_w])rotate([0,roof_angle,0])block(rafter_l,wood_d,roof_rafter_size);
}


