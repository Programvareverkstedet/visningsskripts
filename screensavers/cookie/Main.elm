import Window

main = paint <~ Window.dimensions ~ 30 `timesPer`second

paint (w,h) time
 = layers
    [ bgBlue
        |> size w h
    , foreground time
        |> fit (floor <| toFloat w*0.7) (floor <| toFloat h*0.7)
        |> container w h middle
    ,sound
   ]

foreground time
 = collage 512 512
    [ shine
        |> alpha 0.5
        |> rotate (time* -30 `degreesPer`second)
    , shine
        |> alpha 0.25
        |> rotate (time*  15 `degreesPer`second)
    , nest
        |> moveY -130
    , cookie
   ]


bgBlue = tiledImg "bgBlue.jpg"
cookie = img 256 256 "perfectCookie.png"
shine = img 512 512 "shine.png"
nest = img 304 161 "nest.png"


baseUrl = "http://orteil.dashnet.org/cookieclicker/img/"
img x y = toForm . image x y . (++) baseUrl
tiledImg = tiledImage 0 0 . (++) baseUrl

fit w h elem =
 let
   (ew,eh) = sizeOf elem
   aspWin = w // h
   aspPic = ew // eh
   fac = if aspPic > aspWin
           then w // ew
           else h // eh
 in
   elem
     |> toForm
     |> scale fac
     |> collage w h . flip(::)[]
     
timesPer count interval = every <| interval/count
degreesPer angle time = degrees angle / time

(//) a b = toFloat a / toFloat b


sound = [markdown|
  <iframe style="display:none"
          src="http://mynoise.net/NoiseMachines/throatSingingDroneGenerator.php?c=0&l=99772423572458243922&a=1"
  ></iframe>
|]
