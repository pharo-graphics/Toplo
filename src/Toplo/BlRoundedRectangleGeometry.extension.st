Extension { #name : #BlRoundedRectangleGeometry }

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> pointOnPerimeterAtDegrees: aDegrees of: anElement [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  positionOnBorderAtRadiansV0: aDegrees degreesToRadians
		  of: anElement
]

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> pointOnPerimeterAtRadians: aRadians for: anElement [
    "Retourne un point sur le périmètre extérieur de cet élément (mesuredBounds),
    en tenant compte des coins arrondis et de l’angle en radians."

    | bnds insets adjustedRect adjustedCenter dx dy
      rx ry tx ty useArc intersection
      arcCenter cornerRadius scaleX scaleY
      radii x y |

    "1. Zone extérieure visible de l'élément (inclut les marges)"
	bnds := anElement measuredBounds asRectangle.
	insets := anElement margin.
	adjustedRect := Rectangle
	                origin: bnds topLeft + insets topLeft negated
	                corner: bnds bottomRight + insets bottomRight.

    adjustedCenter := adjustedRect center.
    rx := adjustedRect width / 2.
    ry := adjustedRect height / 2.

    "2. Direction à partir de l’angle"
    dx := aRadians cos.
    dy := aRadians sin.

    "3. Récupération du rayon du coin selon la direction"
    radii := self cornerRadii.
    cornerRadius := radii radiusForDirectionX: dx directionY: dy.

    "4. Distance utile sans les coins"
    scaleX := (rx - cornerRadius) max: 0.
    scaleY := (ry - cornerRadius) max: 0.
    tx := dx abs / scaleX.
    ty := dy abs / scaleY.
    useArc := tx > 1 or: [ ty > 1 ].

    "5. Calcul du point sur l’arc ou le bord"
    intersection := useArc
        ifTrue: [
            arcCenter := ((adjustedCenter x) + ((rx - cornerRadius) * dx sign)) @
                         ((adjustedCenter y) + ((ry - cornerRadius) * dy sign)).
            x := arcCenter x + (cornerRadius * dx).
            y := arcCenter y + (cornerRadius * dy).
            x @ y
        ]
        ifFalse: [
            scaleX := 1 / (tx max: ty).
            (adjustedCenter x + (dx * scaleX)) @ (adjustedCenter y + (dy * scaleX))
        ].

    ^ intersection

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
