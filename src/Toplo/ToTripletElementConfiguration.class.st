Class {
	#name : #ToTripletElementConfiguration,
	#superclass : #ToElementConfiguration,
	#instVars : [
		'startFlexible',
		'endFlexible',
		'endGap',
		'startGap',
		'startAlignment',
		'endAlignment',
		'endInterspace',
		'startInterspace',
		'isHorizontal'
	],
	#category : #'Toplo-Core'
}

{ #category : #configuration }
ToTripletElementConfiguration >> applyOn: anElement [

	"'onInnerConfigurationApplied in ' trace. owner traceCr."

	self configureChildrenIn: anElement.
	self configureEndContainerIn: anElement.
	self configureEndFillerIn: anElement.
	self configureEndGapIn: anElement.
	self configureStartContainerIn: anElement.
	self configureStartFillerIn: anElement.
	self configureStartGapIn: anElement.
	self configureEndElementIn: anElement.
	self configureMiddleElementIn: anElement.

]

{ #category : #configuration }
ToTripletElementConfiguration >> checkEndContainer [

	endContainer ifNotNil: [ ^ self ].
	endContainer := owner newBaseContainer
		                  id: #'end-container';
		                  yourself.
	owner addChild: endContainer.
	self configureChildren.
	self configureEndContainer 
]

{ #category : #configuration }
ToTripletElementConfiguration >> checkStartContainer [

	startContainer ifNotNil: [ ^ self ].
	startContainer := owner newBaseContainer
		                  id: #'start-container';
		                  yourself.
	owner addChild: startContainer at: 1.
	self configureChildren.
	self configureStartContainer 
]

{ #category : #configuration }
ToTripletElementConfiguration >> configureChildren [

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
ToTripletElementConfiguration >> configureChildrenIn: anElement [

	self isHorizontal
		ifTrue: [
			anElement childrenDo: [ :child |
				child constraints linear vertical alignCenter.
				child constraints frame vertical alignCenter ] ]
		ifFalse: [
			anElement childrenDo: [ :child |
				child constraints linear horizontal alignCenter.
				child constraints frame horizontal alignCenter ] ]
]

{ #category : #configuration }
ToTripletElementConfiguration >> configureEndContainer [

	endContainer ifNil: [ ^ self ].
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
ToTripletElementConfiguration >> configureEndElement [

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
ToTripletElementConfiguration >> configureEndFiller [

	endFlexible
		ifTrue: [
			endFiller ifNil: [
				endFiller := owner newFiller
					               id: #'end-filler';
					               yourself.
				owner addChild: endFiller after: middleContainer ].
			self on: endFiller resizerDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent ] ]
		ifFalse: [
			endFiller ifNil: [ ^ self ].
			endFiller removeFromParent.
			endFiller := nil ]
]

{ #category : #configuration }
ToTripletElementConfiguration >> configureEndGap [

	endInterspace isZero
		ifFalse: [
			endGap ifNil: [
				endGap := owner newFiller
					          id: #'end-gap';
					          yourself.
				owner addChild: endGap after: middleContainer ].
			owner isHorizontal
				ifTrue: [
					self on: endGap resizerDo: [ :c |
						c vertical exact: 0.
						c horizontal exact: endInterspace ] ]
				ifFalse: [
					self on: endGap resizerDo: [ :c |
						c horizontal exact: 0.
						c vertical exact: endInterspace ] ] ]
		ifTrue: [
			endGap ifNil: [ ^ self ].
			endGap removeFromParent.
			endGap := nil ]
]

{ #category : #configuration }
ToTripletElementConfiguration >> configureMiddleElement [

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
ToTripletElementConfiguration >> configureStartContainer [

	startContainer ifNil: [ ^ self ].
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
ToTripletElementConfiguration >> configureStartFiller [

	startFlexible
		ifTrue: [
			startFiller ifNil: [
				startFiller := owner newFiller
					               id: #'start-filler';
					               yourself.
				owner addChild: startFiller before: middleContainer ].
			self on: startFiller resizerDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent ] ]
		ifFalse: [
			startFiller ifNil: [ ^ self ].
			startFiller removeFromParent.
			startFiller := nil ]
]

{ #category : #configuration }
ToTripletElementConfiguration >> configureStartGap [

	startInterspace isZero
		ifFalse: [
			startGap ifNil: [
				startGap := owner newFiller
					            id: #'start-gap';
					            yourself.
				owner addChild: startGap before: middleContainer ].
			owner isHorizontal
				ifTrue: [
					self on: startGap resizerDo: [ :c |
						c vertical exact: 0.
						c horizontal exact: startInterspace ] ]
				ifFalse: [
					self on: startGap resizerDo: [ :c |
						c horizontal exact: 0.
						c vertical exact: startInterspace ] ] ]
		ifTrue: [
			startGap ifNil: [ ^ self ].
			startGap removeFromParent.
			startGap := nil ]
]

{ #category : #accessing }
ToTripletElementConfiguration >> endAlignment: aNumber [

	endAlignment = aNumber ifTrue: [ ^ self ].
	endAlignment := aNumber.
	self checkEndContainer.
	owner requestNewConfigurationPass
]

{ #category : #accessing }
ToTripletElementConfiguration >> endContainer [

	^ endContainer
]

{ #category : #accessing }
ToTripletElementConfiguration >> endElement [

	^ endElement
]

{ #category : #accessing }
ToTripletElementConfiguration >> endElement: anElement [

	anElement = endElement ifTrue: [ ^ self ].
	endElement ifNotNil: [ :s | s removeFromParent ].
	endElement := anElement.
	endElement ifNil: [ ^ self ].
	self checkEndContainer.
	endContainer addChild: anElement
]

{ #category : #accessing }
ToTripletElementConfiguration >> endFiller [

	^ endFiller
]

{ #category : #accessing }
ToTripletElementConfiguration >> endFlexible [

	^ endFlexible
]

{ #category : #accessing }
ToTripletElementConfiguration >> endFlexible: aBoolean [

	endFlexible = aBoolean ifTrue: [ ^ self ].
	endFlexible := aBoolean.
	owner requestNewConfigurationPass
]

{ #category : #accessing }
ToTripletElementConfiguration >> endInterspace: aNumber [

	endInterspace = aNumber ifTrue: [ ^ self ].
	endInterspace := aNumber.
	owner requestNewConfigurationPass
]

{ #category : #initialization }
ToTripletElementConfiguration >> initialize [ 

	super initialize.
	startFlexible := false.
	endFlexible := false.
	startInterspace := 0.
	endInterspace := 0
]

{ #category : #accessing }
ToTripletElementConfiguration >> isHorizontal [ 

	^ isHorizontal
]

{ #category : #accessing }
ToTripletElementConfiguration >> isHorizontal: aBoolean [

	isHorizontal := aBoolean
]

{ #category : #accessing }
ToTripletElementConfiguration >> middleContainer [

	^ middleContainer
]

{ #category : #accessing }
ToTripletElementConfiguration >> middleContainer: anElement [

	middleContainer := anElement
]

{ #category : #accessing }
ToTripletElementConfiguration >> middleElement [

	^ middleElement
]

{ #category : #accessing }
ToTripletElementConfiguration >> middleElement: anElement [

	anElement = middleElement ifTrue: [ ^ self ].
	middleElement ifNotNil: [ :s | s removeFromParent ].
	middleElement := anElement.
	anElement ifNil: [ ^ self ].
	middleContainer addChild: anElement
]

{ #category : #initialization }
ToTripletElementConfiguration >> on: anElement [

	owner := anElement.
	middleContainer := anElement newMiddleContainer
		                   id: #'middle-container';
		                   yourself.
	owner addChild: middleContainer.
	owner addEventHandler: owner defaultTripletEventHandler.
	owner fitContent
]

{ #category : #private }
ToTripletElementConfiguration >> on: anElement resizerDo: aBlock [ 
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

{ #category : #configuration }
ToTripletElementConfiguration >> onToploConfigurationApplied [

	"'onInnerConfigurationApplied in ' trace. owner traceCr."

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

{ #category : #dependencies }
ToTripletElementConfiguration >> release [ 

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
ToTripletElementConfiguration >> startAlignment [

	^ startAlignment
]

{ #category : #accessing }
ToTripletElementConfiguration >> startAlignment: aNumber [

	startAlignment = aNumber ifTrue: [ ^ self ].
	startAlignment := aNumber.
	self checkStartContainer.
	owner requestNewConfigurationPass
]

{ #category : #accessing }
ToTripletElementConfiguration >> startContainer [

	^ startContainer
]

{ #category : #accessing }
ToTripletElementConfiguration >> startElement [

	^ startElement
]

{ #category : #accessing }
ToTripletElementConfiguration >> startElement: anElement [

	anElement = startElement ifTrue: [ ^ self ].
	startElement ifNotNil: [ :s | s removeFromParent ].
	startElement := anElement.
	startElement ifNil: [ ^ self ].
	self checkStartContainer.
	startContainer addChild: anElement
]

{ #category : #accessing }
ToTripletElementConfiguration >> startFiller [

	^ startFiller
]

{ #category : #accessing }
ToTripletElementConfiguration >> startFlexible [

	^ startFlexible
]

{ #category : #accessing }
ToTripletElementConfiguration >> startFlexible: aBoolean [

	startFlexible = aBoolean ifTrue: [ ^ self ].
	startFlexible := aBoolean.
	owner requestNewConfigurationPass
]

{ #category : #accessing }
ToTripletElementConfiguration >> startInterspace [

	^ startInterspace
]

{ #category : #accessing }
ToTripletElementConfiguration >> startInterspace: aNumber [

	startInterspace = aNumber ifTrue: [ ^ self ].
	startInterspace := aNumber.
	owner requestNewConfigurationPass
]
