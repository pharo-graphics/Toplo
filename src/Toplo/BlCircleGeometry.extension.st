Extension { #name : #BlCircleGeometry }

{ #category : #'*Toplo' }
BlCircleGeometry >> pointOnPerimeterAtDegrees: aDegrees of: anElement [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  pointOnPerimeterAtRadians: aDegrees degreesToRadians
		  of: anElement
]

{ #category : #'*Toplo' }
BlCircleGeometry >> pointOnPerimeterAtRadians: anAngle of: anElement [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ radius * anAngle cos @ (radius * anAngle sin)
]

{ #category : #'*Toplo' }
BlCircleGeometry >> pointOnPerimeterForAnchor: anAnchor inRectangle: aRectangle [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| adjustedRectangle |
	adjustedRectangle := (anAnchor element margin expand: anAnchor element measuredBounds).
	self matchExtent: adjustedRectangle extent.
	^ (self pointOnPerimeterAtDegrees: anAnchor degrees - 90 of: anAnchor element) + aRectangle center
]
