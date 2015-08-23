\include "english.ly"
\version "2.6.0"
\header {
    tagline = ""
}
#(set-global-staff-size 32)
#(set-default-paper-size "letter")
global = { 
    \time 4/4
    
}
globalTempo = {
    \override Score.MetronomeMark #'transparent = ##t
    \tempo 4 = 70  
}
\layout{ indent = #1 }
     emptymusic = {
       \repeat unfold 16 % Change this for more lines.
       { s1\break }
       \bar "|."
     }
     \new Score \with {
       \override TimeSignature #'transparent = ##t
     % un-comment this line if desired
       \override Clef #'transparent = ##t
       defaultBarType = #""
       \remove Bar_number_engraver
     } <<

     % modify these to get the staves you want
       \new Staff \emptymusic
>>

