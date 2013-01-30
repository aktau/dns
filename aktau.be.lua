-- File: aktau.be.lua
-- Variable _a is replaced with zone name
-- _a = example.com

-- replace github-username with your username
github_pages(_a, "aktau")

-- setup mailing via outlook.com, can't use google apps basic because
-- that isn't free anymore
outlook_mail(_a, config()[_a])