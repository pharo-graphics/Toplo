Extension { #name : #BlEllipseGeometry }

{ #category : #'*Toplo' }
BlEllipseGeometry >> pointOnPerimeterAtRadians: radians of: anElement [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| usedRectangle radiusX radiusY |
	usedRectangle := anElement margin expand:
		                 anElement measuredBounds asRectangle.
	radiusX := usedRectangle extent x / 2.0.
	radiusY := usedRectangle extent y / 2.0.
	^ radiusX * radians cos @ (radiusY * radians sin)
	  + anElement measuredBounds center
]
