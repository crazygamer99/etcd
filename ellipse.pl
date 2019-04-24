sub ellipse_area
{
	my ($rx,$ry)=@_;
	my $area=$rx*$ry*3.14;
	return $area;
}
print("enter radius of ellipse");
$rx=<STDIN>;
$ry=<STDIN>;
$area=ellipse_area($rx,$ry);
print("area is",$area,"\n");
