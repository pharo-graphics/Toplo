Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TToElement + TBlLayoutResizable + TToDressable + TToSkinable + TObservable',
	#classTraits : 'TToElement classTrait + TBlLayoutResizable classTrait + TToDressable classTrait + TToSkinable classTrait + TObservable classTrait',
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
