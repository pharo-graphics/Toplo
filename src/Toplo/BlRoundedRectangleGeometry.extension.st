Extension { #name : #BlRoundedRectangleGeometry }

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> pointOnPerimeterAtRadians: aRadians of: anElement [

	| bounds margin rect rx ry dx dy px py cornerRadius innerWidth innerHeight inCorner adjustedCenter signX signY arcCenter x y scale |
	"1. Compute the bounds rectangle that includes the margin "
	bounds := anElement measuredBounds.
	margin := anElement margin.
	rect := Rectangle
		        origin: bounds topLeft - margin topLeft
		        corner: bounds bottomRight + margin bottomRight.

	adjustedCenter := rect center.
	rx := rect width / 2.
	ry := rect height / 2.

	"2. compute the direction from the angle (unit vector)"
	dx := aRadians cos.
	dy := aRadians sin.

	px := dx * rx.
	py := dy * ry.

	signX := dx sign.
	signY := dy sign.

	"3. get the corner radius from the direction "
	cornerRadius := cornerRadii radiusForDirectionX: dx directionY: dy.

	innerWidth := rx - cornerRadius.
	innerHeight := ry - cornerRadius.

	"4.  check if the direction fits a rounded corner "
	inCorner := (px abs * 2.5) >= innerWidth and: [ (py abs * 2.5) >= innerHeight ].
	"
	dx trace. ' ' trace. rx trace. ' ' trace. px abs trace. ' ' trace. innerWidth traceCr.
	dy trace. ' ' trace. ry trace. ' ' trace. py abs trace. ' ' trace. innerHeight traceCr.
	inCorner traceCr.
	"
	inCorner ifTrue: [ "5. compute the arc angle"
			arcCenter := (signX = 1
				              ifTrue: [ rect right - cornerRadius ]
				              ifFalse: [ rect left + cornerRadius ]) @ (signY = 1
				              ifTrue: [ rect bottom - cornerRadius ]
				              ifFalse: [ rect top + cornerRadius ]).

			"6. compute the point on arc"
			x := arcCenter x + (cornerRadius * dx).
			y := arcCenter y + (cornerRadius * dy).

			^ x @ y ].

	"7. else compute the position on a straight line"
	scale := 1 / (px abs / rx max: py abs / ry).
	x := adjustedCenter x + (dx * rx * scale).
	y := adjustedCenter y + (dy * ry * scale).

	^ x @ y
]
