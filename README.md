doo doot doo...
7/29/2026:
The basic idea - Have Desmos try to predict what the next prime number is using a regression line, and then turn those into musical notes.
Using Godot for the main codebase of the project, Desmos Graphing for the placement of notes, Ultrabox for the individual note sound effects, [this](https://www.math.uchicago.edu/~luis/allprimes.html) funny little website that has a list of all primes, and a strange JavaScript script I found on Reddit (of all places) to rip the Desmos array into plaintext so I can copypaste it into Godot.
Initially used pitch-shifting for the sounds, and realized it sounded terrible, so now I have like 30 sound effect files, with hopefully a better result.

<br>
6:55PM:  
	First audio clip! I had done this in Jummbox by hand a while back, never thought to put in it Godot to automate it til now tho
<br> kinda haunting knowing how much it sounds like it has a pattern, when there isn't really... it's strange

<br>
<br>8PM: You know, this reminds me of the [Egg Song](linkhttps://www.youtube.com/watch?v=JvAjtd8jhZc) from Animal Well...

<br><br>
7/30: Fixed an error where the first note wouldn't be visualized, and made two different sound visualizers. One I uhhhhh... "imported" (mostly copypasted, it's under MIT License) from a [Godot Asset Demo](https://godotengine.org/asset-library/asset/2762). The other is made by hand, and shows the notes going from left to right. Currently has goofy placeholder art.
