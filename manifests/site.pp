node default {

notify{'none of the host matched':}
notify{'no changes done':}
}

node /^puppetclient/ {

include openssh

}
