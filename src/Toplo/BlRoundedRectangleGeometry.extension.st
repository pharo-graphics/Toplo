Extension { #name : #BlRoundedRectangleGeometry }

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> pointOnPerimeterAtDegrees: aDegrees of: anElement [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  pointOnPerimeterAtRadians: aDegrees degreesToRadians
		  of: anElement
]

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> pointOnPerimeterAtRadians0: aRadians for: anElement [

	| bounds margin rect adjustedCenter rx ry dx dy px py cornerRadius innerWidth innerHeight inCorner arcCenter x y signX signY intersection projX projY length scaleX scaleY maxScale |
	"1. Calculer les bounds extérieurs avec la marge"
	bounds := anElement measuredBounds.
	margin := anElement margin.

	rect := Rectangle
		        origin: bounds topLeft - (margin left @ margin top)
		        corner: bounds bottomRight + (margin right @ margin bottom).

	adjustedCenter := rect center.
	rx := rect width / 2.
	ry := rect height / 2.

	"2. Direction du rayon"
	dx := aRadians cos.
	dy := aRadians sin.

	"3. Coordonnées projetées"
	px := dx * rx.
	py := dy * ry.

	"4. Rayon du coin dans la direction donnée"
	cornerRadius := cornerRadii radiusForDirectionX: dx directionY: dy.
	cornerRadius := cornerRadius min: (rx min: ry).

	"5. Zone rectangulaire intérieure sans les coins"
	innerWidth := rx - cornerRadius.
	innerHeight := ry - cornerRadius.

	inCorner := px abs > innerWidth and: [ py abs > innerHeight ].

	signX := dx sign.
	signY := dy sign.

	intersection := inCorner
		                ifTrue: [ "6. Dans un coin arrondi : calcul du centre de l’arc + projection"
				                arcCenter := adjustedCenter
				                             +
				                             (innerWidth * signX
				                              @ (innerHeight * signY)).

				                projX := px - (signX * innerWidth).
				                projY := py - (signY * innerHeight).

				                length := (projX squared + projY squared) sqrt.
				                projX := projX / length.
				                projY := projY / length.

				                x := arcCenter x + (cornerRadius * projX).
				                y := arcCenter y + (cornerRadius * projY).
				                x @ y ]
		                ifFalse: [ "7. Sur les côtés droits : limiter au périmètre"
				                scaleX := px = 0
					                          ifTrue: [ Float infinity ]
					                          ifFalse: [ rx / px abs ].
				                scaleY := py = 0
					                          ifTrue: [ Float infinity ]
					                          ifFalse: [ ry / py abs ].
				                maxScale := scaleX min: scaleY.
				                maxScale := maxScale min: 1.

				                adjustedCenter
				                + (dx * rx * maxScale @ (dy * ry * maxScale)) ].

	^ intersection
]

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> pointOnPerimeterAtRadians: aRadians for: anElement [

	| bounds margin rect rx ry dx dy px py cornerRadius innerWidth innerHeight inCorner adjustedCenter signX signY arcCenter x y scale |
	"1. Calculer le rectangle externe incluant les marges"
	bounds := anElement measuredBounds.
	margin := anElement margin.
	rect := Rectangle
		        origin: bounds topLeft - (margin left @ margin top)
		        corner: bounds bottomRight + (margin right @ margin bottom).

	adjustedCenter := rect center.
	rx := rect width / 2.
	ry := rect height / 2.

	"2. Calculer la direction (vecteur unitaire) à partir de l’angle"
	dx := aRadians cos.
	dy := aRadians sin.

	px := dx * rx.
	py := dy * ry.

	signX := dx sign.
	signY := dy sign.

	"3. Obtenir le rayon de coin à partir de la direction"
	cornerRadius := cornerRadii radiusForDirectionX: dx directionY: dy.

	innerWidth := rx - cornerRadius.
	innerHeight := ry - cornerRadius.

	"4. Vérifier si la direction correspond à un coin arrondi"
	inCorner := px abs >= innerWidth and: [ py abs >= innerHeight ].

	inCorner ifTrue: [ "5. Calculer le centre de l’arc du coin"
			arcCenter := (signX = 1
				              ifTrue: [ rect right - cornerRadius ]
				              ifFalse: [ rect left + cornerRadius ]) @ (signY = 1
				              ifTrue: [ rect bottom - cornerRadius ]
				              ifFalse: [ rect top + cornerRadius ]).

			"6. Calculer le point sur l’arc"
			x := arcCenter x + (cornerRadius * dx).
			y := arcCenter y + (cornerRadius * dy).

			^ x @ y ].

	"7. Sinon, calculer le point sur un segment droit"
	scale := 1 / (px abs / rx max: py abs / ry).
	x := adjustedCenter x + (dx * rx * scale).
	y := adjustedCenter y + (dy * ry * scale).

	^ x @ y
]

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> pointOnPerimeterAtRadians: anAngleInRadians of: anElement [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ self pointOnPerimeterAtRadians: anAngleInRadians for: anElement
]

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> pointOnPerimeterForAnchor: anAnchor inRectangle: aRectangle [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ (self pointOnPerimeterAtDegrees: anAnchor degrees - 90 of: anAnchor element) + aRectangle topLeft
]

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> positionOnBorderAtRadiansV0: anAngleInRadians of: anElement [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| adjustedRect dx dy scale x y halfWidth halfHeight usedCenter insets bnds |
	insets := anElement margin.
	bnds := anElement measuredBounds asRectangle.

	adjustedRect := Rectangle
		                origin: bnds topLeft + insets topLeft negated
		                corner: bnds bottomRight + insets bottomRight.

	usedCenter := adjustedRect center.
	dx := anAngleInRadians cos.
	dy := anAngleInRadians sin.

	halfWidth := adjustedRect width / 2.
	halfHeight := adjustedRect height / 2.

	scale := 1 / (dx abs / halfWidth max: dy abs / halfHeight).

	x := usedCenter x + (dx * scale).
	y := usedCenter y + (dy * scale).

	^ x @ y
]
