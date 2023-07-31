Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TToElement + TToElementWithState + TBlLayoutResizable + TToDressable + TToSkinable + TToWorldElement + TObservable',
	#classTraits : 'TToElement classTrait + TToElementWithState classTrait + TBlLayoutResizable classTrait + TToDressable classTrait + TToSkinable classTrait + TToWorldElement classTrait + TObservable classTrait',
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
ToElement >> initialize [ 

	super initialize.
	
	self class initializeSlots: self.
	
	"Dresser initialization steps"
	self preInitializeDresser.
	self initializeDresser.
	self postInitializeDresser.
	self initializeSkin
]
