#!/bin/bash

# Gets a list of all articles from web

articles=$(wget -q -O - "https://www.ynetnews.com/category/3082" | grep -o -E "https://www.ynetnews.com/article/[a-zA-Z0-9]*" | sort | uniq)

# Prints num of articles
echo "$articles" | wc -l

for article in $articles; do
	
	# Reads an article
	content=$(wget -q -O - $article)
	
	# Counts all desired keywords
	netanyahu=$(echo $content | grep -o "Netanyahu" | wc -l)
	gantz=$(echo $content | grep -o "Gantz" | wc -l)
	bennett=$(echo $content | grep -o "Bennett" | wc -l)
	peretz=$(echo $content | grep -o "Peretz" | wc -l)
	
	# Print result accordin to format
	if [[ netanyahu -eq 0 ]] && [[ gantz -eq 0 ]]  && [[ bennett -eq 0 ]] && [[ peretz -eq 0 ]]; then
		echo "$article, -"
	else
		echo "$article, Netanyahu, $netanyahu, Gantz, $gantz, Bennett, $bennett, Peretz, $peretz"
	fi
	
done
