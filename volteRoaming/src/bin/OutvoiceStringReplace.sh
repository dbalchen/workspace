awk -F'\t' -v OFS="\t" '{ print $6,$7,$1,$2,$3,$8,$4,$5,$9,$10 }'
