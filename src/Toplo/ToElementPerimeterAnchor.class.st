Class {
	#name : #ToElementPerimeterAnchor,
	#superclass : #ToElementLocationAnchor,
	#instVars : [
		'radians'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToElementPerimeterAnchor >> degrees [

	^ radians / Float pi * 180
]

{ #category : #accessing }
ToElementPerimeterAnchor >> degrees: anAngleInDegrees [

	radians := anAngleInDegrees degreesToRadians 
]

{ #category : #accessing }
ToElementPerimeterAnchor >> radians [

	^ radians 
]

{ #category : #accessing }
ToElementPerimeterAnchor >> radians: anAngleInRadians [

	radians := anAngleInRadians
]

{ #category : #applying }
ToElementPerimeterAnchor >> valueInBounds: aBounds [

	^ self element geometry
		  pointOnPerimeterForAnchor: self
		  inRectangle: aBounds
]
