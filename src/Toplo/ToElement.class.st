Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TToResizable + TToEnableable + TToDressable + TToSkinable + TObservable',
	#classTraits : 'TToResizable classTrait + TToEnableable classTrait + TToDressable classTrait + TToSkinable classTrait + TObservable classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'t - dressable -  initialization' }
ToElement >> defaultDresser [

	^ ToDresser new
]

{ #category : #'t - skinable - initialization' }
ToElement >> defaultStyleTags [

	^ #( )
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

{ #category : #accessing }
ToElement >> innerElement [ 

	^ nil
]

{ #category : #'t - layout resizeable' }
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
