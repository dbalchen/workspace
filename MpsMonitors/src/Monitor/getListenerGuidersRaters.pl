#!/opt/perl5/bin/perl
use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);


$hh = "ps -ef | grep ppLSN | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8,9 | grep DIVCOD";
@stuff = `$hh`;

if ($stuff[0] ne "")
{
for($a = 0; $a < @stuff; $a++)
{
 ($time,$pgm,$ext) = split(/ /,$stuff[$a]);
 print "$pgm!$time\n";
}
}
else {
print "ppLSN!-\n";
}

$hh = "ps -ef | grep MpsGuide | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8,9 | grep M0";

@stuff = `$hh`;

if ($stuff[0] ne "")
{

for($a = 0; $a < @stuff; $a++)
{
 chomp($stuff[$a]);
 ($time,$pgm,$ext) = split(/ /,$stuff[$a]);
 $Guiders = $Guiders."$ext!$time;";
}
}
else {
$Guiders = "No Guiders!-;";
}
print $Guiders."\n";

$hh = 'RaterStatus.pl night_start "4" SqlLib "sql/" market "'.uc($ENV{'TLG_UP_ROOT'}).'" Log "log/" sql_day "raters_day.sql" title "RaterStatus" sql_night "raters_night.sql" night_end "13" MpsLib "" web "yes"';
@Stuff = `$hh`;

chomp(@Stuff);

for($a = 0; $a < @stuff; $a++)
{
 if (index($Stuff[$a],"not") > 1)
 {
  ($toss,$rate,$toss) = split(/ /,$Stuff[$a]);
  $RATERS = $RATERS."$rate!DOWN;";
 }
 else {

  if ($Stuff[$a] ne "")
  {
   ($toss,$rate,$toss,$status) = split(/ /,$Stuff[$a]);
    $RATERS = $RATERS."$rate!UP;";
  }
 }
 }

 print $RATERS."\n";
exit(0);

