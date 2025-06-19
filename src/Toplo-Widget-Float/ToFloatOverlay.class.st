Class {
	#name : #ToFloatOverlay,
	#superclass : #ToOverlayElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToFloatOverlay >> defaultLayout [

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToFloatOverlay >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self startToEnd: false.
	
]
