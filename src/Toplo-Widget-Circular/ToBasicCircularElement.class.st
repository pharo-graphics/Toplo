Class {
	#name : #ToBasicCircularElement,
	#superclass : #ToElement,
	#traits : 'TToCircularElement',
	#classTraits : 'TToCircularElement classTrait',
	#category : #'Toplo-Widget-Circular-BasicElement'
}

{ #category : #initialization }
ToBasicCircularElement >> initialize [ 

	super initialize.
	self initializeAsCircularElement 
]
