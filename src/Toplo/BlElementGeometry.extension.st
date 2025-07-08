Extension { #name : #BlElementGeometry }

{ #category : #'*Toplo' }
BlElementGeometry >> pointOnPerimeterForAnchor: anAnchor [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ self
		  pointOnPerimeterOfElement: anAnchor element
		  atRadians: anAnchor radians - 90 degreesToRadians
]

{ #category : #'*Toplo' }
BlElementGeometry >> pointOnPerimeterOfElement: anElement atDegrees: aDegrees [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  pointOnPerimeterOfElement: anElement
		  atRadians: aDegrees degreesToRadians
]

{ #category : #'*Toplo' }
BlElementGeometry >> pointOnPerimeterOfElement: anElement atRadians: anAngle [
	" default version that should be redefined according to my perimeter computation "

	^ 0 @ 0
]
