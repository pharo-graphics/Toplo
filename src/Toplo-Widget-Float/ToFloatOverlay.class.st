Class {
	#name : #ToFloatOverlay,
	#superclass : #ToOverlayElement,
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
