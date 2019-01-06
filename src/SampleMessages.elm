module SampleMessages exposing (..)

type alias Message =
    { author : String, time : String, text : String }

sampleChannelMessages : List Message
sampleChannelMessages =
    [ { author = "augustin82", time = "6:09AM", text = "@gampleman I think you need to `clip` the `scrollable` element, and that that element should be larger than its parent, which (I think) means that the containing parent should have a fixed width" }
    , { author = "u0421793", time = "6:22AM", text = "I’ve been trying to make a few links on a page in elm and elm-ui but I’ve not found a way to make it work because I haven’t found any examples of elm-ui which incorporate an anchor element" }
    , { author = "augustin82", time = "6:27AM", text = "@u0421793 what are you looking for exactly? do you have an Ellie where you've tried  doing some stuff?" }
    , { author = "icepac", time = "7:53 AM", text = "Anybody replied to @lango https://elmlang.slack.com/archives/C4F9NBLR1/p1541911789377400 About Animation vs Element ?" }
    , { author = "mgriffith", time = "8:00 AM", text = "You can use them together, for sure :smile: You just need to use `Element.htmlAttribute` to render the style attribute." }
    , { author = "duncan", time = "9:32 AM", text = "so ideally, it'd be nice to get the r,g,b,a components from a `Color` so that I could do the string interp (edited)" }
    , { author = "lango", time = "1:23 PM", text = "@mgriffith But that isn't really them 'working together' is it, its more they just happen to be together? For example, `elm-ui` has `background.gradient` but `elm-style-animation` only has `backgroundColor`. It's not clear to me how I could animation `elm-ui`'s `background.gradient` using `elm-animation`?" }
    , { author = "mgriffith", time = "4:28 PM", text = "@lango Oh, yeah I totally agree it isn’t seamless :smile: That’s why I’ve been putting a lot of time towards an API for animation for elm-ui.  But technically `elm-style-animation` and `elm-ui` can work together." }
    , { author = "eniac314", time = "6:49 AM", text = "It seems it it possible to press buttons without the event handler associated being fired when one clicks the thin area along the top border. In this example: https://ellie-app.com/3T4KLBKbnTQa1 it's possible to see the button moving without the counter increasing or decreasing. Is this due to the way I did the styling for the buttons? It seems to be related to the shadow (edited)" }
    , { author = "anthony.deschamps", time = "10:24 AM", text = "What's the most recent version of elm-ui/stylish-elephants that works on 0.18?" }
    , { author = "progger", time = "10:46 AM", text = "I've got some text that I'm laying out in a paragraph, and I want to put a link in there too.  Paragraph put the link on its own line though.  Shouldn't it all flow together?" }
    , { author = "progger", time = "11:22 AM", text = "Ha, I filed an issue about this back in oct.  Used my own workaround!" }
    ]


sampleMessages : List Message
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