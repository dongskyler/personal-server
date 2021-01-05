server {
	server_name gen2.skylerdong.com www.gen2.skylerdong.com;
	root /var/www/gen2.gen2.skylerdong.com/public_html;
	index index.php index.html;
	return 307 $scheme://skylerdong.com$request_uri;

	access_log /var/log/nginx/gen2.skylerdong.com.access.log;
	error_log /var/log/nginx/gen2.skylerdong.com.error.log;

	location / {
		try_files $uri /index.html =404;
		fastcgi_pass unix:/run/php-fpm/www.sock;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		include fastcgi_params;
	}

}
