Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #initialization }
ToGeneralButton >> defaultEventHandler [ 

	^ ToSkinnableEventHandler new 
]

{ #category : #initialization }
ToGeneralButton >> initialize [

	super initialize.
	self addEventHandler: self defaultEventHandler
]
