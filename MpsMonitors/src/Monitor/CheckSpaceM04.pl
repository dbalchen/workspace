#!/opt/perl5/bin/perl

@stuff = `bdf /TLG_VAR4/m04/projs/up`;
chomp(@stuff);
print FormatSpace(@stuff)."\n";

@stuff = `bdf /TLG_VAR4/m04/log`;
chomp(@stuff);
print FormatSpace(@stuff)."\n";

@stuff = `bdf /cares/mpsm04b`;
chomp(@stuff);
print FormatSpace(@stuff)."\n";


exit(0);

sub FormatSpace 
{
 local(@INFO) = @_;

 $Return = $INFO[1];
 $lret =  $INFO[2];

 $Return = $Return.$lret.";";
 $Return =~ s/  */;/g;
return $Return;

}
