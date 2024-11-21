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

slab_w = 130;
slab_h = 103;
slab_d = 4;
post_h = 96;
post_hr = 95.99;
post_w = 6;
post_wr = 5.99;
base_h = 2;
post_slab_edge_offset = 0;
horizontal_post_overlap = 10;
house_wall_h = 130;
house_wall_d = 1;

// create 2 by 6 as a base
color("green")translate([slab_h-post_w,0,0])block(post_w, slab_w/3 + post_w / 2, base_h); 
color("green")translate([slab_h-post_w,slab_w*2/3-post_w/2,0])block(post_w, slab_w/3 + post_w / 2, base_h); 

// create slab and 3 main posts
color("grey")translate([0,0,-slab_d])block(slab_h, slab_w, slab_d); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,post_slab_edge_offset,0])block(post_wr, post_wr, post_hr); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,slab_w/3-post_w/2,0])block(post_wr, post_wr, post_hr); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,slab_w/3*2-post_w/2,0])block(post_wr, post_wr, post_hr); 
color("yellow")translate([slab_h-post_slab_edge_offset-post_w,slab_w - post_w-post_slab_edge_offset,0])block(post_wr, post_wr, post_hr); 

//create horizontal post on top of three main posts
color("brown")translate([slab_h-post_slab_edge_offset-post_w,-horizontal_post_overlap,post_h-post_w])block(post_w, slab_w+horizontal_post_overlap*2, post_w); 
//create wall of the house
color("red")translate([-house_wall_d, -house_wall_h * 0.5, 0])block(house_wall_d, house_wall_h*2, house_wall_h); 
