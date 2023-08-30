Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TToElement + TToEnableable + TBlLayoutResizable + TToDressable + TToSkinable + TObservable',
	#classTraits : 'TToElement classTrait + TToEnableable classTrait + TBlLayoutResizable classTrait + TToDressable classTrait + TToSkinable classTrait + TObservable classTrait',
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

{ #category : #'t  - layout resizeable' }
ToElement >> innerElement [ 

	^ nil
]

{ #category : #'t  - layout resizeable' }
ToElement >> resizableConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	
	Can be basically defined with #constraintsDo: aBlock.
	
	Introduced a an explicit requirement to let user
	implement additional actions when resizing is changed
	
	"
	self constraintsDo: aBlock.
	self dispatchEvent: ToLayoutConstraintsChangedEvent new
	
]
