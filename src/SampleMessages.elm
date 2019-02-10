module SampleMessages exposing (sampleMessages)

import UI exposing (ChatMessage)


sampleMessages : List ChatMessage
sampleMessages =
    [ { author = "neumaneuma", time = "2:17 PM", text = "i joined the elm slack workspace!" }
    , { author = "kofi", time = "2:23 PM", text = "hah you're so in it now! you've crossed the line from curious to.. something after curious\n#beginners is a _really_ good resource if you get stuck ever. it's wild how fast people are to respond" }
    , { author = "neumaneuma", time = "2:25 PM", text = "probably the most profound thing you've ever said" }

    -- How to implement respond to conversation?
    -- kofi
    -- hah you're so in it now! you've crossed the line from curious to.. something after curious
    -- Direct MessageDec 13thView conversation
    , { author = "kofi", time = "2:25 PM", text = "This forum is also pretty nice https://discourse.elm-lang.org/. I try to respond to beginners on there every-so-often since there's uaually a higher lag time" }
    , { author = "neumaneuma", time = "2:26 PM", text = "i was just looking at that too\nhow's the subreddit?" }
    , { author = "kofi", time = "2:27 PM", text = "least active of the 3. also the people who post just seem less happy lol\ni still end up checking it weekly, but that's because i'm obsessed" }
    , { author = "neumaneuma", time = "2:39 PM", text = "i can already foresee 2 major downsides of joining this workspace\n1. my messaging ecosystem is going to become even more fragmented (slack, groupme, whatsapp, sms, fb messenger, and snapchat sort of)\n2. less importantly my productivity at work will decline because i'll be talking to you more frequently about random stuff" }
    , { author = "kofi", time = "2:41 PM", text = "dude, talking to me will likely increase productivity" }
    , { author = "neumaneuma", time = "2:47 PM", text = "do you have any elm blogs you would recommend?\ni stumbled on https://korban.net, which is how i found out about `elm-ui`\nand really, `elm-ui` is why i've gone from thinking \"elm is really cool, i should put more time into learning it when i get a chance\" to \"drop everything and learn more about elm\"\nmaking UIs is, as dumb as it sounds, really daunting to me" }
    , { author = "kofi", time = "3:04 PM", text = "hah that's cool. I don't think i've heard of anyone coming into Elm via that route. i'm sure Matt would be glad to hear it (#elm-ui) but that's a fair complaint of html/css.\nKorban definitely puts out a lot of stuff (how'd you find him?) – I don't know anyone who is blogging more frequently. I just watch #news-and-links for new posts really\nand discourse. I subscribe to that with Feedly (edited)" }
    , { author = "neumaneuma", time = "3:33 PM", text = "Well let's see how much progress I make towards writing elm apps before letting him know :sweat_smile: (edited)QUOTEkofihah that's cool. I don't think i've heard of anyone coming into Elm via that route. i'm sure Matt would be glad to hear it (#elm-ui) but that's a fair complaint of html/css.QUOTE\nDirect MessageDec 13thView conversationHonestly I don't remember... It just happened sometime in the last weekkofiKorban definitely puts out a lot of stuff (how'd you find him?) – I don't know anyone who is blogging more frequently. I just watch #news-and-links for new posts reallyDirect MessageDec 13thView conversation" }
    ]
