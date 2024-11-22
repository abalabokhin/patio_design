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

slab_w = 192;
slab_h = 140;
slab_d = 4;
post_h = 96;
post_w = 6;
post_slab_edge_offset = 4;
horizontal_post_overlap = 10;
house_wall_h = 112;
house_wall_d = 1;
baseboard_w = 6;
wood_d = 2;

roof_rafter_spacing = 16;
roof_rafter_size = 6;
roof_rafter_cut = 2;
roof_rafter_overlap = 12;


// create slab and 3 main posts
color("grey")translate([0,0,-slab_d])block(slab_h, slab_w, slab_d); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,post_slab_edge_offset,0])block(post_w, post_w, post_h); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,slab_w/3-post_w/2,0])block(post_w, post_w, post_h); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,slab_w/3*2-post_w/2,0])block(post_w, post_w, post_h); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,slab_w - post_w-post_slab_edge_offset,0])block(post_w, post_w, post_h); 

//create horizontal post on top of three main posts
color("brown")translate([slab_h-post_slab_edge_offset-post_w,-horizontal_post_overlap,post_h-post_w])block(post_w, slab_w+horizontal_post_overlap*2, post_w); 
//create wall of the house
color("red")translate([-house_wall_d, -house_wall_h * 0.5, 0])block(house_wall_d, slab_w*2, house_wall_h); 
// create baseboard
color("green")translate([0,-horizontal_post_overlap,house_wall_h-baseboard_w])block(wood_d, slab_w+horizontal_post_overlap*2, baseboard_w);
// create roof rafters
// calculate angle
roof_angle_tan = (house_wall_h-baseboard_w - (post_h-roof_rafter_cut)) / (slab_h - wood_d - post_slab_edge_offset);
roof_angle = atan(roof_angle_tan);
rafter_horizontal_l = slab_h - post_slab_edge_offset - wood_d;
rafter_l = rafter_horizontal_l / cos(roof_angle) + roof_rafter_overlap;
rafter_n = (slab_w+horizontal_post_overlap*2)/roof_rafter_spacing;

for (i = [0:1:rafter_n]) {
color("yellow")translate([wood_d,-horizontal_post_overlap + i * roof_rafter_spacing,house_wall_h-baseboard_w])rotate([0,roof_angle,0])block(rafter_l,wood_d,roof_rafter_size);
}

