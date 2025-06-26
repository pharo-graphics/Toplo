Class {
	#name : #ToFloatContainer,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToFloatContainer >> defaultLayout [

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToFloatContainer >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self padding: (BlInsets all: 20).
	self preventMouseEvents.
]

{ #category : #skin }
ToFloatContainer >> installRawStyle [ 

	super installRawStyle.
	self background: Color transparent
]
