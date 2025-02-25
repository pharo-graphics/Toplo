Class {
	#name : #ToTripletElementProperties,
	#superclass : #Object,
	#instVars : [
		'startContainer',
		'middleContainer',
		'endContainer',
		'startFiller',
		'endFiller',
		'startElement',
		'middleElement',
		'endElement',
		'startFlexible',
		'endFlexible',
		'endGap',
		'startGap',
		'startAlignment',
		'endAlignment',
		'endInterspace',
		'startInterspace',
		'owner'
	],
	#category : #'Toplo-Core'
}

{ #category : #configuration }
ToTripletElementProperties >> applyInnerConfiguration [

	"'applyInnerConfiguration in ' trace. owner traceCr."
	
	self configureChildren.
	self configureEndContainer.
	self configureEndFiller.
	self configureEndGap.
	self configureStartContainer.
	self configureStartFiller.
	self configureStartGap.
	self configureEndElement.
	self configureMiddleElement.

]

{ #category : #configuration }
ToTripletElementProperties >> configureChildren [

	owner isHorizontal
		ifTrue: [
			owner childrenDo: [ :child |
				child constraints linear vertical alignCenter.
				child constraints frame vertical alignCenter ] ]
		ifFalse: [
			owner childrenDo: [ :child |
				child constraints linear horizontal alignCenter.
				child constraints frame horizontal alignCenter ] ]
]

{ #category : #configuration }
ToTripletElementProperties >> configureEndContainer [

	owner isHorizontal
		ifTrue: [
			self on: endContainer resizerDo: [ :c |
				endAlignment
					ifNil: [ c horizontal fitContent ]
					ifNotNil: [ c horizontal exact: endAlignment ].
				c vertical fitContent ] ]
		ifFalse: [
			self on: endContainer resizerDo: [ :c |
				endAlignment
					ifNil: [ c vertical fitContent ]
					ifNotNil: [ c vertical exact: endAlignment ].
				c horizontal fitContent ] ]
]

{ #category : #configuration }
ToTripletElementProperties >> configureEndElement [

	endElement ifNil: [ ^ self ].
	owner isHorizontal
		ifTrue: [
			endElement constraints frame horizontal alignRight.
			endElement constraints linear horizontal alignRight ]
		ifFalse: [
			endElement constraints frame vertical alignBottom.
			endElement constraints linear vertical alignBottom ]
]

{ #category : #configuration }
ToTripletElementProperties >> configureEndFiller [

	endFlexible
		ifTrue: [
			self on: endFiller resizerDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent ] ]
		ifFalse: [
			self on: endFiller resizerDo: [ :c |
				c vertical fitContent.
				c horizontal fitContent ] ]
]

{ #category : #configuration }
ToTripletElementProperties >> configureEndGap [

	owner isHorizontal
		ifTrue: [
			self on: endGap resizerDo: [ :c |
				c vertical exact: 0.
				c horizontal exact: endInterspace ] ]
		ifFalse: [
			self on: endGap resizerDo: [ :c |
				c horizontal exact: 0.
				c vertical exact: endInterspace ] ]
]

{ #category : #configuration }
ToTripletElementProperties >> configureMiddleElement [

	middleElement ifNil: [ ^ self ].
	owner isHorizontal
		ifTrue: [
			middleElement constraints frame vertical alignCenter.
			middleElement constraints linear vertical alignCenter.
			middleElement constraints frame horizontal alignCenter.
			middleElement constraints linear horizontal alignCenter ]
		ifFalse: [
			middleElement constraints frame horizontal alignCenter.
			middleElement constraints linear horizontal alignCenter.
			middleElement constraints frame vertical alignCenter.
			middleElement constraints linear vertical alignCenter ]
]

{ #category : #configuration }
ToTripletElementProperties >> configureStartContainer [

	owner isHorizontal
		ifTrue: [
			self on: startContainer resizerDo: [ :c |
				startAlignment
					ifNil: [ c horizontal fitContent ]
					ifNotNil: [ c horizontal exact: startAlignment ].
				c vertical fitContent ] ]
		ifFalse: [
			self on: startContainer resizerDo: [ :c |
				startAlignment
					ifNil: [ c vertical fitContent ]
					ifNotNil: [ c vertical exact: startAlignment ].
				c horizontal fitContent ] ]
]

{ #category : #configuration }
ToTripletElementProperties >> configureStartFiller [

	startFlexible
		ifTrue: [
			self on: startFiller resizerDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent ] ]
		ifFalse: [
			self on: startFiller resizerDo: [ :c |
				c vertical fitContent.
				c horizontal fitContent ] ]
]

{ #category : #configuration }
ToTripletElementProperties >> configureStartGap [

	owner isHorizontal
		ifTrue: [
			self on: startGap resizerDo: [ :c |
				c vertical exact: 0.
				c horizontal exact: startInterspace ] ]
		ifFalse: [
			self on: startGap resizerDo: [ :c |
				c horizontal exact: 0.
				c vertical exact: startInterspace ] ]
]

{ #category : #accessing }
ToTripletElementProperties >> endAlignment: aNumber [

	endAlignment = aNumber ifTrue: [ ^ self ].
	endAlignment := aNumber.
	owner requestInnerConfiguration
]

{ #category : #accessing }
ToTripletElementProperties >> endContainer [

	^ endContainer
]

{ #category : #accessing }
ToTripletElementProperties >> endElement [

	^ endElement
]

{ #category : #accessing }
ToTripletElementProperties >> endElement: anElement [

	anElement = endElement ifTrue: [ ^ self ].
	endElement ifNotNil: [ :s | s removeFromParent ].
	endElement := anElement.
	anElement ifNil: [ ^ self ].
	endContainer addChild: anElement.
	owner requestInnerConfiguration
]

{ #category : #accessing }
ToTripletElementProperties >> endFiller [

	^ endFiller
]

{ #category : #accessing }
ToTripletElementProperties >> endFlexible [

	^ endFlexible
]

{ #category : #accessing }
ToTripletElementProperties >> endFlexible: aBoolean [

	endFlexible = aBoolean ifTrue: [ ^ self ].
	endFlexible := aBoolean.
	owner requestInnerConfiguration
]

{ #category : #accessing }
ToTripletElementProperties >> endInterspace: aNumber [

	endInterspace = aNumber ifTrue: [ ^ self ].
	endInterspace := aNumber.
	owner requestInnerConfiguration
]

{ #category : #initialization }
ToTripletElementProperties >> initialize [ 

	super initialize.
	startFlexible := false.
	endFlexible := false.
	startInterspace := 0.
	endInterspace := 0
]

{ #category : #accessing }
ToTripletElementProperties >> middleContainer [

	^ middleContainer
]

{ #category : #accessing }
ToTripletElementProperties >> middleContainer: anElement [

	middleContainer := anElement
]

{ #category : #accessing }
ToTripletElementProperties >> middleElement [

	^ middleElement
]

{ #category : #accessing }
ToTripletElementProperties >> middleElement: anElement [

	anElement = middleElement ifTrue: [ ^ self ].
	middleElement ifNotNil: [ :s | s removeFromParent ].
	middleElement := anElement.
	anElement ifNil: [ ^ self ].
	middleContainer addChild: anElement
]

{ #category : #initialization }
ToTripletElementProperties >> on: anElement [

	owner := anElement.
	startGap := anElement newFiller
		            id: #'start-gap';
		            yourself.
	"startGap background: Color blue."
	endGap := anElement newFiller
		          id: #'end-gap';
		          yourself.
	"endGap background: Color blue."
	startFiller := anElement newFiller
		               id: #'start-filler';
		               yourself.
	"startFiller background: Color yellow."
	endFiller := anElement newFiller
		             id: #'end-filler';
		             yourself.
	"endFiller background: Color yellow."
	startContainer := anElement newBaseContainer
		                  id: #'start-container';
		                  yourself.
	middleContainer := anElement newMiddleContainer
		                   id: #'middle-container';
		                   yourself.
	endContainer := anElement newBaseContainer
		                id: #'end-container';
		                yourself.

	owner addChildren: {
			startContainer.
			startGap.
			startFiller.
			middleContainer.
			endFiller.
			endGap.
			endContainer }.

	owner addEventHandler: owner defaultTripletEventHandler.
	owner fitContent
]

{ #category : #private }
ToTripletElementProperties >> on: anElement resizerDo: aBlock [ 
	"Perform aBlock with anElement constraints as argument.
	Note: After evaluation my owner requests a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	owner can implement additional actions by handling the BlLayoutResizerChangedEvent
	"

	| hr vr |
	hr := anElement constraints horizontal resizer.
	vr := anElement constraints vertical resizer.
	aBlock value: anElement constraints.
	(hr = anElement constraints horizontal resizer and: [
		 vr = anElement constraints vertical resizer ]) ifTrue: [ ^ self ].
	owner requestLayout
]

{ #category : #dependencies }
ToTripletElementProperties >> release [ 

	super release.
	owner := nil.
	startContainer := nil.
	middleContainer := nil.
	endContainer := nil.
	startFiller := nil.
	endFiller := nil.
	startElement := nil.
	middleElement := nil.
	endElement := nil
]

{ #category : #accessing }
ToTripletElementProperties >> startAlignment [

	^ startAlignment
]

{ #category : #accessing }
ToTripletElementProperties >> startAlignment: aNumber [

	startAlignment = aNumber ifTrue: [ ^ self ].
	startAlignment := aNumber.
	owner requestInnerConfiguration
]

{ #category : #accessing }
ToTripletElementProperties >> startContainer [

	^ startContainer
]

{ #category : #accessing }
ToTripletElementProperties >> startContainer: anElement [

	startContainer := anElement
]

{ #category : #accessing }
ToTripletElementProperties >> startElement [

	^ startElement
]

{ #category : #accessing }
ToTripletElementProperties >> startElement: anElement [

	anElement = startElement ifTrue: [ ^ self ].
	startElement ifNotNil: [ :s | s removeFromParent ].
	startElement := anElement.
	anElement ifNil: [ ^ self ].
	startContainer addChild: anElement
]

{ #category : #accessing }
ToTripletElementProperties >> startFiller [

	^ startFiller
]

{ #category : #accessing }
ToTripletElementProperties >> startFlexible [

	^ startFlexible
]

{ #category : #accessing }
ToTripletElementProperties >> startFlexible: aBoolean [

	startFlexible = aBoolean ifTrue: [ ^ self ].
	startFlexible := aBoolean.
	owner requestInnerConfiguration
]

{ #category : #accessing }
ToTripletElementProperties >> startInterspace [

	^ startInterspace
]

{ #category : #accessing }
ToTripletElementProperties >> startInterspace: aNumber [

	startInterspace = aNumber ifTrue: [ ^ self ].
	startInterspace := aNumber.
	owner requestInnerConfiguration
]
