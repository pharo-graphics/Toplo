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
ToFloatOverlay >> defaultLayout [

	^ ToAnchorLayout new
]

{ #category : #initialization }
ToFloatOverlay >> initialize [ 

	super initialize.
	self layout: self defaultLayout
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
