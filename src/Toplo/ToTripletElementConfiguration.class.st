Class {
	#name : #ToTripletElementConfiguration,
	#superclass : #ToTripletContainerConfiguration,
	#traits : 'TToTripletElementConfiguration',
	#classTraits : 'TToTripletElementConfiguration classTrait',
	#category : #'Toplo-Core'
}

{ #category : #hook }
ToTripletElementConfiguration >> applyOn: anElement [

	"'applyOn: ' trace. anElement traceCr."

	super applyOn: anElement.
	self applyTripletElementConfigurationOn: anElement
]

{ #category : #initialization }
ToTripletElementConfiguration >> initialize [ 

	super initialize.
	self initializeAsTripletElementConfiguration
]
