function github_pages(domain, github_username)
	-- Create CNAME for www.yourdomain.com pointing to user.github.com
	cname(concat("www", domain), concat(username, "github.com"))

	-- Create A records for root/naked domain (yourdomain.com)
	a(domain, "204.232.175.78")
end