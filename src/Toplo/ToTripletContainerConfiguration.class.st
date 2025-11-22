Class {
	#name : #ToTripletContainerConfiguration,
	#superclass : #ToWidgetConfiguration,
	#traits : 'TToTripletContainerConfiguration',
	#classTraits : 'TToTripletContainerConfiguration classTrait',
	#category : #'Toplo-Core'
}

{ #category : #hook }
ToTripletContainerConfiguration >> applyOn: anElement [

	"'applyOn: ' trace. anElement traceCr."

	super applyOn: anElement.
	self applyTripletContainerConfigurationOn: anElement
]

{ #category : #initialization }
ToTripletContainerConfiguration >> initialize [ 

	super initialize.
	self initializeAsTripletContainerConfiguration
]

{ #category : #dependencies }
ToTripletContainerConfiguration >> release [ 

	super release.
	endGap := nil.
	startGap := nil
]
