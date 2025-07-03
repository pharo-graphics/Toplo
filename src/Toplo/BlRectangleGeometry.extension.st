Extension { #name : #BlRectangleGeometry }

{ #category : #'*Toplo' }
BlRectangleGeometry >> positionOnBorderAtDegrees: aDegrees of: anElement [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  positionOnBorderAtRadians: aDegrees * Float pi / 180
		  of: anElement
]

{ #category : #'*Toplo' }
BlRectangleGeometry >> positionOnBorderAtRadians: anAngle of: anElement [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| bnds dx dy scale x y center |
	dx := anAngle cos.
	dy := anAngle sin.

	bnds := anElement bounds.
	center := bnds position + (bnds extent / 2).

	"Détermination du facteur d’échelle pour rester sur le bord"
	scale := 1 / (dx abs / center x max: dy abs / center y).

	x := center x + (dx * scale).
	y := center y + (dy * scale).

	^ x @ y
]
