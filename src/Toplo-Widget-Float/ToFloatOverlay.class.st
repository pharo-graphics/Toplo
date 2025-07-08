Class {
	#name : #ToFloatOverlay,
	#superclass : #ToOverlayElement,
	#instVars : [
		'margin',
		'northWest',
		'northEast',
		'southWest',
		'southEast'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToFloatOverlay >> defaultElevation [

	^ BlRelativeElevation elevation: 20
]

{ #category : #initialization }
ToFloatOverlay >> defaultLayout [

	^ BlAnchorLayout new
]

{ #category : #initialization }
ToFloatOverlay >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self elevation: self defaultElevation 
]

{ #category : #accessing }
ToFloatOverlay >> northEast [

	^ northEast
]

{ #category : #accessing }
ToFloatOverlay >> northWest [

	^ northWest
]

{ #category : #accessing }
ToFloatOverlay >> southEast [

	^ southEast
]

{ #category : #accessing }
ToFloatOverlay >> southWest [

	^ southWest
]
