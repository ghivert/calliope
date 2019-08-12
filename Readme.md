# Debussy

If you’re looking here for a fully functional application, you’re not in the
right place. This project is deprecated. Here’s some explanations.

# Introduction

Debussy was a music player project, written on top of Electron, to finally get
a perfect music player, compatible with all major platforms. Yes, I know, I know,
Electron is slow, etc. But life is too short to write three different
applications, and when I started the project, React Native or things like that
(Flutter, I’m thinking about you) were not mature enough for me (and wasn’t
targeting the desktop by the way).

# Why is it deprecated?

If you came here, it’s probably because you’re looking for a music player, or
maybe because you’re looking for an [Electron](https://electronjs.org) wrapper
for Elm, to write your full application directly in Elm. And how cool would that
be right? Just imagine: you open your text editor, and think « What if I
can develop a full desktop application in JS? Oh cool, Electron does that! But
what about Elm? Oh wait… Elm compiles to JavaScript right? Gosh, I NEED to get
a full application written in Elm into Electron! ».

Yeah, you guessed, that’s what happened to me. I was into the Elm ecosystem
since month when I decided to start the project, in Elm 0.18. That was the
starting point for me to write effect managers and « outside-of-browser-elm ».
And that was pretty cool. Really. And then came Elm 0.19. Elm 0.19 removed the
possibility to write Kernel code into Elm. Yup, no JS anymore. You’re forced to
do it in two separate worlds. You can’t mix the languages as you want.

Don’t get me wrong, I still think that removing Kernel code in 0.19 is smart.
It’s just not my way of thinking. Elm is a strong small language, and remains
today one of the best choice you can do for your frontend application in team.
It’s just not tailored for explorations like this one, and probably never will.

If you’re interested in the project, feel free to use it at your will. Fork,
clone, copy, steal code. I don’t. As wise men would say, **do what the fuck you
want**.

# Architecture

Because the project still exists, here’s some additional informations. Debussy
is built with Elm 0.18, Webpack and Electron. Electron powered the desktop part,
and right now, boots up using Elm. You can get an eye at what it *could* be in
[this file](https://github.com/ghivert/debussy/blob/master/src/main/Process.elm).
The package running the Electron wrapper resides in the parent folder of
`Process.elm`: [`main`](https://github.com/ghivert/debussy/tree/master/src/main).

On the other hand, the frontend is a classic Elm 0.18 application residing into
[`renderer`](https://github.com/ghivert/debussy/tree/master/src/renderer).
It is running with Webpack to get the source code compiled, as well as some
JavaScript and assets files bundled.

# The project is so good, please go on!

Oh, that’s nice! But as of now, I won’t continue the project. Maybe it will have
a revival in few years, with some PureScript or ClojureScript powering it. But
for now, the project will remains as it is. Star it, send me mails, make me rich,
and maybe I’ll rethink about it!
