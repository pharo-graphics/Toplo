Class {
	#name : #ToTripletElementConfiguration,
	#superclass : #ToElementConfiguration,
	#traits : 'TToTripletElementConfiguration',
	#classTraits : 'TToTripletElementConfiguration classTrait',
	#category : #'Toplo-Core'
}

{ #category : #hook }
ToTripletElementConfiguration >> applyOn: anElement [

	"'onInnerConfigurationApplied in ' trace. owner traceCr."

	self configureChildrenIn: anElement.
	self configureEndContainerIn: anElement.
	self configureEndFillerIn: anElement.
	self configureEndGapIn: anElement.
	self configureStartContainerIn: anElement.
	self configureStartFillerIn: anElement.
	self configureStartGapIn: anElement.

]

{ #category : #initialization }
ToTripletElementConfiguration >> initialize [ 

	super initialize.
	startFlexible := false.
	endFlexible := false.
	startInterspace := 0.
	endInterspace := 0
]

{ #category : #hook }
ToTripletElementConfiguration >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	middleContainer ifNotNil: [ BlImmutableObjectChangeError signal ].
	middleContainer := anElement newMiddleContainer
		                   id: #'middle-container';
		                   yourself.
	anElement addChild: middleContainer.
	anElement addEventHandler: anElement defaultTripletEventHandler.

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
