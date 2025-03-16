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

{ #category : #hook }
ToTripletElementConfiguration >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self onInstalledTripletElementConfigurationIn: anElement

]

{ #category : #dependencies }
ToTripletElementConfiguration >> release [ 

	super release.
	startContainer := nil.
	middleContainer := nil.
	endContainer := nil.
	startFiller := nil.
	endFiller := nil.
	startElement := nil.
	middleElement := nil.
	endElement := nil
]
