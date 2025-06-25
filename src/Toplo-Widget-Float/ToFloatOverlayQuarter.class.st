Class {
	#name : #ToFloatOverlayQuarter,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToFloatOverlayQuarter >> defaultLayout [

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToFloatOverlayQuarter >> initialize [

	super initialize.
	self layout: self defaultLayout
]

{ #category : #skin }
ToFloatOverlayQuarter >> installRawStyle [ 

	super installRawStyle.
	self background: Color transparent
]
