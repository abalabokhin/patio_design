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

module slab() 
{
    color("grey")translate([0,0,-slab_d])block(slab_h, slab_w, slab_d);
}

module posts() 
{
for (i = [0:1:3]) {
difference() {
  color("yellow")translate([slab_h-post_slab_edge_offset-post_w,post_slab_edge_offset+(slab_w-post_slab_edge_offset*2-post_w)/3*i,0])block(post_w, post_w, post_h);
  translate([slab_h-post_slab_edge_offset-wood_d,baseboard_offset,post_h-baseboard_w])block(wood_d+epsilon, baseboard_l, baseboard_w+epsilon);
  }
}
}

module posts_board() 
{
//create horizontal post on top of main posts
color("brown")translate([slab_h-post_slab_edge_offset-wood_d,baseboard_offset-baseboard_overlap,post_h-baseboard_w])block(wood_d, baseboard_l_real, baseboard_w);     
}

module wall() 
{
//create wall of the house
color("red")translate([-house_wall_d, -house_wall_h * 0.5, 0])block(house_wall_d, slab_w*2, house_wall_h); 
}

module baseboard() 
{
color("green")translate([0,baseboard_offset-baseboard_overlap,house_wall_h-baseboard_w])block(wood_d, baseboard_l_real, baseboard_w);
}

module rafters() 
{
for (i = [0:1:rafter_n]) {
  color("blue")translate([wood_d,min(baseboard_offset + i * roof_rafter_spacing, baseboard_l+baseboard_offset-wood_d),house_wall_h-baseboard_w])rotate([0,roof_angle,0])block(rafter_l,wood_d,roof_rafter_size);
}
}

length_factor = 25.4;

slab_w = 192 * length_factor;
slab_h = 140 * length_factor;
slab_d = 4 * length_factor;
post_h = 96 * length_factor;
post_w = 5.5 * length_factor;
post_slab_edge_offset = 6 * length_factor;
horizontal_post_overlap = 12 * length_factor;
house_wall_h = 112 * length_factor;
house_wall_d = 1 * length_factor;
baseboard_w = 7.25 * length_factor;
baseboard_overlap = 1 * length_factor;
wood_d = 1.5 * length_factor;
epsilon = 0.01;

roof_rafter_spacing = 24 * length_factor;
roof_rafter_size = 7.25 * length_factor;
roof_rafter_cut = 1 * length_factor;
roof_rafter_overlap = 12 * length_factor;

baseboard_l = slab_w-post_slab_edge_offset*2+horizontal_post_overlap*2;
baseboard_l_real = slab_w-post_slab_edge_offset*2+horizontal_post_overlap*2+baseboard_overlap *2;
baseboard_offset = post_slab_edge_offset-horizontal_post_overlap;

roof_angle_tan = (house_wall_h-baseboard_w - (post_h-roof_rafter_cut)) / (slab_h - wood_d - post_slab_edge_offset);
roof_angle = atan(roof_angle_tan);
rafter_horizontal_l = slab_h - post_slab_edge_offset - wood_d;
rafter_l = rafter_horizontal_l / cos(roof_angle) + roof_rafter_overlap;
rafter_n = baseboard_l/roof_rafter_spacing + 1;

slab();
posts();
posts_board();
//wall();
baseboard();
rafters();

/*
projection(cut=false) {
//slab();
posts();
posts_board();
//wall();
baseboard();
rafters();
}


projection(cut=false) {
translate([0,-50,0])
rotate([90, 0, 0]) {
slab();
posts();
posts_board();
//wall();
baseboard();
rafters();
}
}

projection(cut=false) {
translate([-130,0,0])
rotate([0, 90, 0]) {
slab();
posts();
posts_board();
//wall();
//baseboard();
//rafters();
}
}
*/
