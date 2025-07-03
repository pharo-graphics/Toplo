Class {
	#name : #ToElementBorderAnchor,
	#superclass : #ToElementGeometryAnchor,
	#instVars : [
		'radians'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToElementBorderAnchor >> degrees [

	^ radians / Float pi * 180
]

{ #category : #accessing }
ToElementBorderAnchor >> degrees: anAngleInDegrees [

	radians := anAngleInDegrees * Float pi / 180
]

{ #category : #accessing }
ToElementBorderAnchor >> radians [

	^ radians 
]

{ #category : #accessing }
ToElementBorderAnchor >> radians: anAngleInRadians [

	radians := anAngleInRadians
]

{ #category : #applying }
ToElementBorderAnchor >> readRectangle: aRectangle [

	^ self element geometry
		  positionOnBorderForAnchor: self
		  inRectangle: aRectangle
]
