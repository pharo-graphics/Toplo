Trait {
	#name : #TToTripletElementConfiguration,
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
		'hideStart',
		'hideMiddle',
		'hideEnd',
		'canHidePart'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> applyTripletElementConfigurationOn: anElement [

	self configureChildrenIn: anElement.
	self configureEndContainerIn: anElement.
	self configureEndFillerIn: anElement.
	self configureEndGapIn: anElement.
	self configureStartContainerIn: anElement.
	self configureStartFillerIn: anElement.
	self configureStartGapIn: anElement.
	self configureHiddenPartIn: anElement

]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> canHidePart [

	^ canHidePart
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> canHidePart: aBoolean [

	canHidePart := aBoolean
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> checkEndContainerIn: anElement [

	endContainer ifNotNil: [ ^ self ].
	endContainer := anElement newBaseContainer
		                  id: #'end-container';
		                  yourself.
	anElement addChild: endContainer.
	self configureChildrenIn: anElement.
	self configureEndContainerIn: anElement
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> checkStartContainerIn: anElement [

	startContainer ifNotNil: [ ^ self ].
	startContainer := anElement newBaseContainer
		                  id: #'start-container';
		                  yourself.
	anElement addChild: startContainer at: 1.
	self configureChildrenIn: anElement.
	self configureStartContainerIn: anElement
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureChildrenIn: anElement [

	self configureStartElementIn: anElement.
	self configureMiddleElementIn: anElement.
	self configureEndElementIn: anElement.

	anElement isHorizontal
		ifTrue: [
			anElement childrenDo: [ :child |
				child constraints linear vertical alignCenter.
				child constraints frame vertical alignCenter ] ]
		ifFalse: [
			anElement childrenDo: [ :child |
				child constraints linear horizontal alignCenter.
				child constraints frame horizontal alignCenter ] ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureEndContainerIn: anElement [

	endContainer ifNil: [ ^ self ].
	anElement isHorizontal
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

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureEndElementIn: anElement [

	endElement ifNil: [ ^ self ].
	self checkEndContainerIn: anElement.
	endElement parent = endContainer ifFalse: [
		endContainer addChild: endElement ].
	anElement isHorizontal
		ifTrue: [
			endElement constraints frame horizontal alignRight.
			endElement constraints linear horizontal alignRight ]
		ifFalse: [
			endElement constraints frame vertical alignBottom.
			endElement constraints linear vertical alignBottom ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureEndFillerIn: anElement [

	endFlexible
		ifTrue: [
			endFiller ifNil: [
				endFiller := anElement newFiller
					               id: #'end-filler';
					               yourself.
				anElement addChild: endFiller after: middleContainer ].
			self on: endFiller resizerDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent ] ]
		ifFalse: [
			endFiller ifNil: [ ^ self ].
			endFiller removeFromParent.
			endFiller := nil ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureEndGapIn: anElement [

	endInterspace isZero
		ifFalse: [
			endGap ifNil: [
				endGap := anElement newFiller
					          id: #'end-gap';
					          yourself.
				anElement addChild: endGap after: middleContainer ].
			anElement isHorizontal
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

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureHiddenPartIn: anElement [

	hideStart
		ifTrue: [
			self startChildren do: [ :child |
				child visibility: BlVisibility gone ] ]
		ifFalse: [
			self startChildren do: [ :child |
				child visibility: BlVisibility visible ] ].
	hideMiddle
		ifTrue: [
			self middleChildren do: [ :child |
				child visibility: BlVisibility gone ] ]
		ifFalse: [
			self middleChildren do: [ :child |
				child visibility: BlVisibility visible ] ].
	hideEnd
		ifTrue: [
			self endChildren do: [ :child |
				child visibility: BlVisibility gone ] ]
		ifFalse: [
			self endChildren do: [ :child |
				child visibility: BlVisibility visible ] ]

]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureMiddleElementIn: anElement [

	middleElement ifNil: [ ^ self ].
	middleElement parent = middleContainer ifFalse: [
		middleContainer addChild: middleElement ].
	anElement isHorizontal
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

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureStartContainerIn: anElement [

	startContainer ifNil: [ ^ self ].
	anElement isHorizontal
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

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureStartElementIn: anElement [

	startElement ifNil: [ ^ self ].
	startElement parent = startContainer ifFalse: [
		startContainer addChild: startElement ].
	anElement isHorizontal
		ifTrue: [
			startElement constraints frame horizontal alignLeft.
			startElement constraints linear horizontal alignLeft ]
		ifFalse: [
			startElement constraints frame vertical alignBottom.
			startElement constraints linear vertical alignBottom ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureStartFillerIn: anElement [

	startFlexible
		ifTrue: [
			startFiller ifNil: [
				startFiller := anElement newFiller
					               id: #'start-filler';
					               yourself.
				anElement addChild: startFiller before: middleContainer ].
			self on: startFiller resizerDo: [ :c |
				c vertical matchParent.
				c horizontal matchParent ] ]
		ifFalse: [
			startFiller ifNil: [ ^ self ].
			startFiller removeFromParent.
			startFiller := nil ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureStartGapIn: anElement [

	startInterspace isZero
		ifFalse: [
			startGap ifNil: [
				startGap := anElement newFiller
					            id: #'start-gap';
					            yourself.
				anElement addChild: startGap before: middleContainer ].
			anElement isHorizontal
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

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endAlignment [

	^ endAlignment

]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endAlignment: aNumber [

	endAlignment := aNumber.

]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> endChildren [

	^ Array streamContents: [ :stream |
		  endContainer ifNotNil: [ :s | stream nextPut: s ].
		  endGap ifNotNil: [ :s | stream nextPut: s ].
		  endFiller ifNotNil: [ :s | stream nextPut: s ] ]
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endContainer [

	^ endContainer
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endElement [

	^ endElement
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endElement: anElement in: anOwner [

	endElement ifNotNil: [ :s | s removeFromParent ].
	self checkEndContainerIn: anOwner.
	endElement := anElement.
	self configureEndElementIn: anOwner
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endFiller [

	^ endFiller
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endFlexible [

	^ endFlexible
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endFlexible: aBoolean [

	endFlexible := aBoolean
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endInterspace [

	^ endInterspace 
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endInterspace: aNumber [

	endInterspace := aNumber
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> hideEnd [

	^ hideEnd
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> hideEnd: aBoolean [

	hideEnd := aBoolean
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> hideMiddle [

	^ hideMiddle
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> hideMiddle: aBoolean [

	hideMiddle := aBoolean
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> hideStart [

	^ hideStart
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> hideStart: aBoolean [

	hideStart := aBoolean
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> initializeAsTripletElementConfiguration [

	hideStart := false.
	hideMiddle := false.
	hideEnd := false.
	startFlexible := false.
	endFlexible := false.
	startInterspace := 0.
	endInterspace := 0.
	canHidePart := false
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> middleChildren [

	^ { middleContainer }
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> middleContainer [

	^ middleContainer
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> middleContainer: anElement [

	middleContainer := anElement
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> middleElement [

	^ middleElement
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> middleElement: anElement in: anOwner [

	middleElement ifNotNil: [ :s | s removeFromParent ].
	middleElement := anElement.
	self configureMiddleElementIn: anOwner
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> on: anElement resizerDo: aBlock [ 
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
	anElement requestLayout

]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> onInstalledTripletElementConfigurationIn: anElement [

	middleContainer ifNotNil: [ BlImmutableObjectChangeError signal ].
	middleContainer := anElement newMiddleContainer
		                   id: #'middle-container';
		                   yourself.
	anElement addChild: middleContainer.
	anElement addEventHandler: anElement defaultTripletEventHandler.

]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startAlignment [

	^ startAlignment
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startAlignment: aNumber in: anOwner [

	startAlignment := aNumber.
	self checkStartContainerIn: anOwner
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> startChildren [

	^ Array streamContents: [ :stream |
		  startContainer ifNotNil: [ :s | stream nextPut: s ].
		  startGap ifNotNil: [ :s | stream nextPut: s ].
		  startFiller ifNotNil: [ :s | stream nextPut: s ] ]
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startContainer [

	^ startContainer
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startElement [

	^ startElement
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startElement: anElement in: anOwner [

	startElement ifNotNil: [ :s | s removeFromParent ].
	self checkStartContainerIn: anOwner.
	startElement := anElement.
	self configureStartElementIn: anOwner
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startFiller [

	^ startFiller
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startFlexible [

	^ startFlexible
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startFlexible: aBoolean [

	startFlexible := aBoolean
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startInterspace [

	^ startInterspace
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startInterspace: aNumber [

	startInterspace := aNumber
]
