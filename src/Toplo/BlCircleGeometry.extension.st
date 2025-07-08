Extension { #name : #BlCircleGeometry }

{ #category : #'*Toplo' }
BlCircleGeometry >> pointOnPerimeterOfElement: anElement atRadians: anAngle [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| adjustedRectangle prevRadius prevOrigin pt |
	prevRadius := radius.
	prevOrigin := origin.
	adjustedRectangle := anElement margin expand:
		                     anElement measuredBounds.
	self matchExtent: adjustedRectangle extent.
	pt := radius * anAngle cos @ (radius * anAngle sin).
	radius := prevRadius.
	origin := prevOrigin.
	^ pt + adjustedRectangle center
]
