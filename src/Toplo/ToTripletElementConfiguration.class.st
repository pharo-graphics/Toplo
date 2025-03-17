Class {
	#name : #ToTripletElementConfiguration,
	#superclass : #ToElementConfiguration,
	#traits : 'TToTripletElementConfiguration',
	#classTraits : 'TToTripletElementConfiguration classTrait',
	#category : #'Toplo-Core'
}

{ #category : #hook }
ToTripletElementConfiguration >> applyOn: anElement [

	"'applyOn: ' trace. anElement traceCr."

	self applyTripletElementConfigurationOn: anElement
]

{ #category : #initialization }
ToTripletElementConfiguration >> initialize [ 

	super initialize.
	self initializeAsTripletElementConfiguration
]

{ #category : #dependencies }
ToTripletElementConfiguration >> release [ 

	super release.
	startFiller := nil.
	endFiller := nil.
	endGap := nil.
	startGap := nil
]
