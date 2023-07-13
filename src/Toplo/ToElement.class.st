Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TToElement + TToElementtWithState + TBlLayoutResizable + TToDressable + TToWorldElement',
	#classTraits : 'TToElement classTrait + TToElementtWithState classTrait + TBlLayoutResizable classTrait + TToDressable classTrait + TToWorldElement classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'*Toplo-LookAndFeel' }
ToElement class >> skinType: aType [

	| e |
	e := self new.
	e skinType: aType.
	^ e
]

{ #category : #initialization }
ToElement >> defaultLayoutCommonConstraints [

	^ BlLayoutCommonConstraints new
]

{ #category : #initialization }
ToElement >> initialize [ 

	super initialize.
	
	self class initializeSlots: self.
	
	"Dresser initialization steps"
	self preInitializeDresser.
	self initializeDresser.
	self postInitializeDresser.
]
