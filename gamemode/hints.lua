local hints = {
"Need Help? Press F1 for Game Info, Commands, Rules, etc.",
"No Defense? Say /buyturret to get a Turret for $1,000.",
"Shooting people randomly falls under RDMing.",
"RDMing is againist the rules! You be warned, kick and then banned.",
"If you have a base set up and you hear beeping and can see 'BOMB' right outside of your base, then you should probably go and defuse it.",
"Enemy holded up in a secure base and blowtorching isn't working? Buy a BigBomb, say /buybomb but it costs $10,000,000.",
"One of the best ways to keep your base from being raided is to team up with people. People who won't go around shooting people that are looking for people to raid.",
"There is no such thing as a perfect base, if you just block everything with props, they will blowtorch it, if you keep them from doing that, they will probably use the bigbomb.",
"Props are not weapons! Get a gun instead. Press F1 to learn how.",
"Dying slowly from poison?  Say /buyantidote",
"If you are low on money, buy some stuff to make more money. Press F1 to learn how.",
"Visit our website @ LRG.Site.NfoServers.com"
}

function giveHint()
	PrintMessageAll( HUD_PRINTTALK , hints[math.random(1,#hints)])
end

timer.Create( "hints", 210, 0, giveHint )
/*
local rpdmhints = {
"Need Help? Press F1 for Game Info, Commands, Rules, etc.",
"No Defense? Say /buyturret to get a Turret for $1,000.",
"Shooting people randomly falls under RDMing.",
"RDMing is againist the rules! You be warned, kick and then banned.",
"If you have a base set up and you hear beeping and can see 'BOMB' right outside of your base, then you should probably go and defuse it.",
"Enemy holded up in a secure base and blowtorching isn't working? Buy a BigBomb, say /buybomb but it costs $10,000,000.",
"One of the best ways to keep your base from being raided is to team up with people. People who won't go around shooting people that are looking for people to raid.",
"There is no such thing as a perfect base, if you just block everything with props, they will blowtorch it, if you keep them from doing that, they will probably use the bigbomb.",
"Props are not weapons! Get a gun instead. Press F1 to learn how.",
"Dying slowly from poison?  Say /buyantidote",
"If you are low on money, buy some stuff to make more money. Press F1 to learn how.",
"Visit our website @ LRG.Site.NfoServers.com"
}

function giveHint()
	PrintMessageAll( HUD_PRINTTALK , rpdmhints[math.random(1,#rpdmhints)])
end

timer.Create( "hints", 120, 0, giveHint )
*/