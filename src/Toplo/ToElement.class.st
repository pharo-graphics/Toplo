Class {
	#name : #ToElement,
	#superclass : #OBlElement,
	#traits : 'TToElement + TToElementtWithState + TOBlLayoutResizable + TToDressable + TToSkinable + TToWorldElement',
	#classTraits : 'TToElement classTrait + TToElementtWithState classTrait + TOBlLayoutResizable classTrait + TToDressable classTrait + TToSkinable classTrait + TToWorldElement classTrait',
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

	^ OBlLayoutCommonConstraints new
]

{ #category : #initialization }
ToElement >> initialize [ 

	super initialize.
	
	self class initializeSlots: self.
	
	"Dresser initialization steps"
	self preInitializeDresser.
	self initializeDresser.
	self postInitializeDresser
]
