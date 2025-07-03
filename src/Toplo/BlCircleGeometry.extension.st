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

	^ radius * anAngle cos @ (radius * anAngle sin)
]
