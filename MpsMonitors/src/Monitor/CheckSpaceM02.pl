#!/opt/perl5/bin/perl

@stuff = `bdf /cares/mpsm02`;
chomp(@stuff);
print FormatSpace(@stuff)."\n";

@stuff = `bdf /cares/mpsm02b`;
chomp(@stuff);
print FormatSpace(@stuff)."\n";

@stuff = `bdf /TLG_VAR2/m02/log`;
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
