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
	
	"Dresser initialization processus"
	self preInitializeDresser.
	self initializeDresser.
	self postInitializeDresser.
]
