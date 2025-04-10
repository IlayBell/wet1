#!/bin/bash

wget -q https://www.ynetnews.com/category/3082
articles=($(grep -o -E "https://www.ynetnews.com/article/[a-zA-Z0-9]*" ./3082 | sort | uniq))

echo ${#articles[@]}

for article in ${articles[@]}; do
	content=$(wget -q -O - $article)
	netanyahu=$(echo $content | grep -o "Netanyahu" | wc -l)
	gantz=$(echo $content | grep -o "Gantz" | wc -l)
	bennet=$(echo $content | grep -o "Bennet" | wc -l)
	peretz=$(echo $content | grep -o "Peretz" | wc -l)
	
	if [[ netanyahu -eq 0 ]] && [[ gantz -eq 0 ]]  && [[ bennet -eq 0 ]] && [[ peretz -eq 0 ]]; then
		echo "$article, -"
	else
		echo "$article, Netanyahu, $netanyahu, Gantz, $gantz, Bennet, $bennet, Peretz, $peretz"
	fi
	
done
