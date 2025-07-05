Extension { #name : #BlRectangleGeometry }

{ #category : #'*Toplo' }
BlRectangleGeometry >> pointOnPerimeterAtDegrees: aDegrees of: anElement [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  pointOnPerimeterAtRadians: aDegrees degreesToRadians 
		  of: anElement
]

{ #category : #'*Toplo' }
BlRectangleGeometry >> pointOnPerimeterAtRadians: anAngleInRadians of: anElement [
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

{ #category : #'*Toplo' }
BlRectangleGeometry >> pointOnPerimeterForAnchor: anAnchor inRectangle: aRectangle [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ (self
		   pointOnPerimeterAtDegrees: anAnchor degrees - 90
		   of: anAnchor element) + aRectangle topLeft
	 
]
