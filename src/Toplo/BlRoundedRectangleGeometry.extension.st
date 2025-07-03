Extension { #name : #BlRoundedRectangleGeometry }

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> positionOnBorderAtDegrees: aDegrees of: anElement [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  positionOnBorderAtRadians: aDegrees * Float pi / 180
		  of: anElement
]

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> positionOnBorderAtRadians: anAngle of: anElement [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| bnds dx dy scale x y  |
	dx := anAngle cos.
	dy := anAngle sin.

	bnds := anElement measuredBounds.
	center := bnds position + (bnds extent / 2).

	"Détermination du facteur d’échelle pour rester sur le bord"
	scale := 1 / (dx abs / center x max: dy abs / center y).

	x := center x + (dx * scale).
	y := center y + (dy * scale).

	^ x @ y
]

{ #category : #'*Toplo' }
BlRoundedRectangleGeometry >> positionOnBorderForAnchor: anAnchor inRectangle: aRectangle [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ (self positionOnBorderAtDegrees: anAnchor degrees - 90 of: anAnchor element) + aRectangle topLeft
]
