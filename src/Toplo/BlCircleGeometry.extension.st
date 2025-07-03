Extension { #name : #BlCircleGeometry }

{ #category : #'*Toplo' }
BlCircleGeometry >> positionOnBorderAtDegrees: aDegrees of: anElement [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  positionOnBorderAtRadians: aDegrees * Float pi / 180
		  of: anElement
]

{ #category : #'*Toplo' }
BlCircleGeometry >> positionOnBorderAtRadians: anAngle of: anElement [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| usedRadius |
	usedRadius := anElement measuredExtent min / 2.0.
	^ usedRadius * anAngle cos @ (usedRadius * anAngle sin)
]

{ #category : #'*Toplo' }
BlCircleGeometry >> positionOnBorderForAnchor: anAnchor inRectangle: aRectangle [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ (self positionOnBorderAtDegrees: anAnchor degrees - 90 of: anAnchor element) + aRectangle center
]
