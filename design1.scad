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

slab_w = 96;
slab_h = 103;
slab_d = 4;
post_h = 96;
post_w = 6;
post_slab_edge_offset = 2;
horizontal_post_overlap = 10;
house_wall_h = 130;

// create slab and 3 main posts
color("grey")translate([0,0,-slab_d])block(slab_w, slab_h, slab_d); 
color("yellow")translate([post_slab_edge_offset,post_slab_edge_offset,0])block(post_w, post_w, post_h); 
color("yellow")translate([post_slab_edge_offset,slab_h/2-post_w/2,0])block(post_w, post_w, post_h); 
color("yellow")translate([post_slab_edge_offset,slab_h - post_w-post_slab_edge_offset,0])block(post_w, post_w, post_h); 

//create horizontal post on top of three main posts
color("brown")translate([post_slab_edge_offset,-horizontal_post_overlap,post_h-post_w])block(post_w, slab_h+horizontal_post_overlap*2, post_w); 
//create wall of the house
color("red")translate([0, 0, 0])block(1, house_wall_h*2, house_wall_h); 
