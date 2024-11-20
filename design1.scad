// everything is in inches

//create a block
module block(height, width, depth) 
{
	scale([height,width,depth]) //scale
	{
			//make a cube
			cube([1,1,1], center = true); 
	}
}

slab_w = 96;
slab_h = 103;
slab_d = 4;
post_h = 96;
post_w = 6;

//create 3 stacked dodecahedra 
//call the module with a height of 1 and move up 2
color("grey")translate([slab_w/2,slab_h/2,-slab_d/2])block(slab_w, slab_h, slab_d); 
color("yellow")translate([post_w,post_w,post_h/2])block(post_w, post_w, post_h); 
color("yellow")translate([post_w,slab_h/2,post_h/2])block(post_w, post_w, post_h); 
color("yellow")translate([post_w,slab_h - post_w,post_h/2])block(post_w, post_w, post_h); 

//call the module with a height of 2
