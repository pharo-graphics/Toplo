Extension { #name : #BlElementGeometry }

{ #category : #'*Toplo' }
BlElementGeometry >> pointOnPerimeterAtDegrees: aDegrees of: anElement [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  pointOnPerimeterAtRadians: aDegrees degreesToRadians
		  of: anElement
]

{ #category : #'*Toplo' }
BlElementGeometry >> pointOnPerimeterAtRadians: anAngle of: anElement [
	" default version that should be redefined according to my perimeter computation "

	^ 0 @ 0
]

{ #category : #'*Toplo' }
BlElementGeometry >> pointOnPerimeterForAnchor: anAnchor [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ self
		  pointOnPerimeterAtRadians: anAnchor radians - 90 degreesToRadians 
		  of: anAnchor element
]
