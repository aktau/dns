-- cheap "hack" to get some kind of centralized configuration going
function config(domain)
    local m = { }

    m["aktau.be"] = {
        mx = { "9b0a73a2b74f48853defb11ca0bbcc.pamx1.hotmail.com" },
        trust = "v=spf1 include:hotmail.com ~all",
        ownership = "v=msv1 t=9b0a73a2b74f48853defb11ca0bbcc"
    }

    m["hillegeer.com"] = {
        mx = { "b164dce097b240439a587cae807528.pamx1.hotmail.com" },
        trust = "v=spf1 a:google.com include:_spf.google.com include:hotmail.com ~all",
        ownership = "v=msv1 t=b164dce097b240439a587cae807528"
    }

    return m[domain]
end

function github_pages(domain, username)
    -- Create CNAME for www.yourdomain.com pointing to user.github.com
    cname(concat("www", domain), concat(username, "github.io"))

    -- Create A records for root/naked domain (yourdomain.com)
    a(domain, "204.232.175.78")
end

function outlook_mail(domain, config)
    -- mail setup
    -- To set up mail and prove ownership of this domain, you must create an MX record.
    mx(domain, config.mx[1], 10)

    -- server trust
    -- Create a TXT record to allow other mail servers to trust email originating from your domain.
    -- Also known as sender ID configuration, this setting will help prevent your mail from being marked as junk mail.
    -- txt(domain, config.trust)
    spf(domain, config.trust)

    -- prove domain ownership
    -- If you would like to prove the ownership of domain and create users
    -- without setting up mail, you can use one of the following methods for up to 30 days.
    -- After 30 days, you will need to set up an MX record for mail routing as shown above.
    -- (so basically this is redundant, I'm doing it anyway)
    txt(domain, config.ownership)
end
