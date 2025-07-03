Extension { #name : #BlEllipseGeometry }

{ #category : #'*Toplo' }
BlEllipseGeometry >> pointOnPerimeterAtDegrees: aDegrees of: anElement [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  pointOnPerimeterAtRadians: aDegrees degreesToRadians
		  of: anElement
]

{ #category : #'*Toplo' }
BlEllipseGeometry >> pointOnPerimeterAtRadians: radians of: anElement [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| usedRectangle radiusX radiusY |
	usedRectangle := anElement margin expand:
		                 anElement measuredBounds asRectangle.
	radiusX := usedRectangle extent x / 2.0.
	radiusY := usedRectangle extent y / 2.0.
	^ radiusX * radians cos @ (radiusY * radians sin)
]

{ #category : #'*Toplo' }
BlEllipseGeometry >> pointOnPerimeterForAnchor: anAnchor inRectangle: aRectangle [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ (self pointOnPerimeterAtDegrees: anAnchor degrees - 90 of: anAnchor element) + aRectangle center
]
