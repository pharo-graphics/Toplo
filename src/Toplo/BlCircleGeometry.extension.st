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

	| usedRadius usedRectangle |
	usedRectangle := anElement margin expand: anElement measuredBounds asRectangle.
	usedRadius := usedRectangle extent min / 2.0.
	^ usedRadius * anAngle cos @ (usedRadius * anAngle sin)
]

{ #category : #'*Toplo' }
BlCircleGeometry >> pointOnPerimeterForAnchor: anAnchor inRectangle: aRectangle [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ (self pointOnPerimeterAtDegrees: anAnchor degrees - 90 of: anAnchor element) + aRectangle center
]
