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

function github_pages(domain, username, use_alias)
    -- use_alias defaults to true
    use_alias = use_alias == nil and true or false

    local userpage = concat(username, "github.io")

    -- Create CNAME for www.yourdomain.com pointing to user.github.com
    cname(concat("www", domain), userpage)

    -- Create A records for root/naked domain (yourdomain.com)
    if use_alias then
        -- Create ALIAS records, which allows the use of github's cdn
        alias(domain, userpage)
    else
        a(domain, "192.30.252.153")
        a(domain, "192.30.252.154")
    end
end

function outlook_mail(domain, config)
    -- mail setup
    -- To set up mail and prove ownership of this domain, you must create an MX record.
    mx(domain, config.mx[1], 10)

    -- server trust
    -- Create a TXT record to allow other mail servers to trust email originating from your domain.
    -- Also known as sender ID configuration, this setting will help prevent your mail from being marked as junk mail.
    txt(domain, config.trust)
    spf(domain, config.trust)

    -- prove domain ownership
    -- If you would like to prove the ownership of domain and create users
    -- without setting up mail, you can use one of the following methods for up to 30 days.
    -- After 30 days, you will need to set up an MX record for mail routing as shown above.
    -- (so basically this is redundant, I'm doing it anyway)
    txt(domain, config.ownership)
end

function google_app(domain)
    -- mail exchangers
    mx(domain, "aspmx.l.google.com", 1, 3600)
    mx(domain, "alt1.aspmx.l.google.com", 5, 3600)
    mx(domain, "alt2.aspmx.l.google.com", 5, 3600)
    mx(domain, "aspmx2.googlemail.com", 10, 3600)
    mx(domain, "aspmx3.googlemail.com", 10, 3600)
    
    -- mail.domain.com alias
    cname(concat("mail", domain), "ghs.google.com")
  
    -- SPF record
    spf(domain, "v=spf1 a mx include:_spf.google.com ~all")
end
