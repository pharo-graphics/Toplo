Class {
	#name : #ToElement,
	#superclass : #OBlElement,
	#traits : 'TToElement + TOBlLayoutResizable + TToDressable + TToWorldElement',
	#classTraits : 'TToElement classTrait + TOBlLayoutResizable classTrait + TToDressable classTrait + TToWorldElement classTrait',
	#category : #'Toplo-Core'
}

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
	self postInitializeDresser.
]
