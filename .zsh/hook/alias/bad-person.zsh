# Alice's over-engineered z-shell configuration, released in the public domain.
# Yes, I'm a bad person.

alias 4ch='rm -f ~/.4ch-cookies; touch ~/.4ch-cookies; wget -e robots=off -E -nd -nc -np -r -H -Di.4cdn.org -Rhtml --user-agent="Mozilla/5.0 (X11; U; Linux i686; es-AR; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1" --header="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" --header="Accept-Language: es-ar,es;q=0.8,en-us;q=0.5,en;q=0.3" --header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" --header="Keep-Alive: 300" --header="Connection: keep-alive" --load-cookies ~/.4ch-cookies --save-cookies ~/.4ch-cookies --keep-session-cookies'
alias dch='rm -f ~/.dch-cookies; touch ~/.dch-cookies; wget -e robots=off -E -nd -nc -np -r -H -Ddesuchan.net -Rhtml --user-agent="Mozilla/5.0 (X11; U; Linux i686; es-AR; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1" --header="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" --header="Accept-Language: es-ar,es;q=0.8,en-us;q=0.5,en;q=0.3" --header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" --header="Keep-Alive: 300" --header="Connection: keep-alive" --load-cookies ~/.dch-cookies --save-cookies ~/.dch-cookies --keep-session-cookies'
