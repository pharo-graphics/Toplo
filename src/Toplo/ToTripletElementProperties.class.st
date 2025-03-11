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
ToTripletElementProperties >> checkEndContainer [

	endContainer ifNotNil: [ ^ self ].
	endContainer := owner newBaseContainer
		                  id: #'end-container';
		                  yourself.
	owner addChild: endContainer.
	self configureChildren.
	self configureEndContainer 
]

{ #category : #configuration }
ToTripletElementProperties >> checkStartContainer [

	startContainer ifNotNil: [ ^ self ].
	startContainer := owner newBaseContainer
		                  id: #'start-container';
		                  yourself.
	owner addChild: startContainer at: 1.
	self configureChildren.
	self configureStartContainer 
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
ToTripletElementProperties >> configureEndGap [

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
ToTripletElementProperties >> configureStartFiller [

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
ToTripletElementProperties >> configureStartGap [

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
ToTripletElementProperties >> endAlignment: aNumber [

	endAlignment = aNumber ifTrue: [ ^ self ].
	endAlignment := aNumber.
	self checkEndContainer.
	owner requestNewConfiguration
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
	endElement ifNil: [ ^ self ].
	self checkEndContainer.
	endContainer addChild: anElement
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
	owner requestNewConfiguration
]

{ #category : #accessing }
ToTripletElementProperties >> endInterspace: aNumber [

	endInterspace = aNumber ifTrue: [ ^ self ].
	endInterspace := aNumber.
	owner requestNewConfiguration
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
	middleContainer := anElement newMiddleContainer
		                   id: #'middle-container';
		                   yourself.
	owner addChild: middleContainer.
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

{ #category : #configuration }
ToTripletElementProperties >> onInnerConfigurationApplied [

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
	self checkStartContainer.
	owner requestNewConfiguration
]

{ #category : #accessing }
ToTripletElementProperties >> startContainer [

	^ startContainer
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
	startElement ifNil: [ ^ self ].
	self checkStartContainer.
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
	owner requestNewConfiguration
]

{ #category : #accessing }
ToTripletElementProperties >> startInterspace [

	^ startInterspace
]

{ #category : #accessing }
ToTripletElementProperties >> startInterspace: aNumber [

	startInterspace = aNumber ifTrue: [ ^ self ].
	startInterspace := aNumber.
	owner requestNewConfiguration
]
