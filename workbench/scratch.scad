//$fn= 30;
//translate([5,0,0]) sphere(r=10);
//
//difference(){
//cube([5,5,1]);
//translate([2.5,2.5,.0]) cylinder(r=1,h=1);
//}

//cube([2,4,30], center = true);

//module board( size, label = false ) {
//    // size[0] is always with the grain.
//    // size[1] is against the grain.
//    // size[2] is the board thickness.
//    
//    cube( size = size );
//    
//    // Output the size of the board for easy cut lists.
//    echo( str( size[2], " ", label, ": ", size[0], "x", size[1], " ", (size[0] * size[1] * size[2] / 144), " board feet" ) );
//}
//
//board([10, 4, 2]);

/**
 * Standard right-angled triangle
 *
 * @param number o_len Lenght of the opposite side
 * @param number a_len Lenght of the adjacent side
 * @param number depth How wide/deep the triangle is in the 3rd dimension
 * @todo a better way ?
 */
module triangle(o_len, a_len, depth)
{
    linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}

/**
 * Standard right-angled triangle (tangent version)
 *
 * @param number angle of adjacent to hypotenuse (ie tangent)
 * @param number a_len Lenght of the adjacent side
 * @param number depth How wide/deep the triangle is in the 3rd dimension
 */
module a_triangle(tan_angle, a_len, depth)
{
    linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,tan(tan_angle) * a_len]], paths=[[0,1,2]]);
    }
}

module miter_board(size) {
    //difference() {
        cube(size, center = true);
        translate([size[2]/2, 0, 0]) a_triangle(45,size[1],size[0]);
    //}
}

module board(size) {
    cube(size, center = true);
}

length = 30;
width = 2;
for (a=[0:1:3]) {
    if (a % 2 == 0) {
        rotate([0,a*90,0]) translate([length/2-width/2,0,0]) miter_board([width,4,length]);
        echo (a);
    } else {
        rotate([0,a*90,0]) translate([length/2+width/2,0,0]) miter_board([width,4,length], center = true);
    }
}

//// top
//length = 80;
//width = 2;
//for (a = [0:1:8]) {
//    translate([a*width,0,0]) cube([2,width,length]);
//}

// legs:
//length
