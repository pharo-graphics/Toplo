Trait {
	#name : #TToTripletElementConfiguration,
	#instVars : [
		'startFiller',
		'endFiller',
		'startFlexible',
		'endFlexible',
		'endGap',
		'startGap',
		'startAlignment',
		'endAlignment',
		'endInterspace',
		'startInterspace'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> applyTripletElementConfigurationOn: anElement [

	self configureChildrenIn: anElement.
	self configureEndContainerIn: anElement.
	self configureEndFillerIn: anElement.
	self configureEndGapIn: anElement.
	self configureStartContainerIn: anElement.
	self configureStartFillerIn: anElement.
	self configureStartGapIn: anElement
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureChildrenIn: anElement [

	| allChildren |
	self configureStartElementIn: anElement.
	self configureEndElementIn: anElement.
	allChildren := Array streamContents: [ :stream |
			               stream nextPutAll: anElement startChildren.
			               stream nextPutAll: anElement endChildren ].
	anElement isHorizontal
		ifTrue: [
				allChildren do: [ :child |
					child constraints triplet vertical alignCenter ] ]
		ifFalse: [
				allChildren do: [ :child |
					child constraints triplet horizontal alignCenter ] ].
			
	anElement requestLayout
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureEndContainerIn: anElement [

	anElement endContainer ifNil: [ ^ self ].
	anElement isHorizontal
		ifTrue: [
			self on: anElement endContainer resizerDo: [ :c |
				endAlignment
					ifNil: [ c horizontal fitContent ]
					ifNotNil: [ c horizontal exact: endAlignment ].
				c vertical fitContent ] ]
		ifFalse: [
			self on: anElement endContainer resizerDo: [ :c |
				endAlignment
					ifNil: [ c vertical fitContent ]
					ifNotNil: [ c vertical exact: endAlignment ].
				c horizontal fitContent ] ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureEndElementIn: anElement [

	anElement endElement ifNil: [ ^ self ].
	anElement isHorizontal
		ifTrue: [
		anElement endElement constraints linear horizontal alignRight ]
		ifFalse: [
		anElement endElement constraints linear vertical alignBottom ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureEndFillerIn: anElement [

	endFlexible
		ifTrue: [
				endFiller ifNotNil: [ ^ self ].
				endFiller := anElement newFiller
					             id: #'end-filler';
					             yourself.
				endFiller constraints vertical matchParent.
				endFiller constraints horizontal matchParent.
				anElement addChild: endFiller after: anElement middleContainer ]
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
				anElement addChild: endGap after: anElement middleContainer ].
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
TToTripletElementConfiguration >> configureStartContainerIn: anElement [

	anElement startContainer ifNil: [ ^ self ].
	anElement isHorizontal
		ifTrue: [
			self on: anElement startContainer resizerDo: [ :c |
				startAlignment
					ifNil: [ c horizontal fitContent ]
					ifNotNil: [ c horizontal exact: startAlignment ].
				c vertical fitContent ] ]
		ifFalse: [
			self on: anElement startContainer resizerDo: [ :c |
				startAlignment
					ifNil: [ c vertical fitContent ]
					ifNotNil: [ c vertical exact: startAlignment ].
				c horizontal fitContent ] ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureStartElementIn: anElement [

	anElement startElement ifNil: [ ^ self ].
	anElement isHorizontal
		ifTrue: [
		anElement startElement constraints linear horizontal alignLeft ]
		ifFalse: [
		anElement startElement constraints linear vertical alignBottom ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureStartFillerIn: anElement [

	startFlexible
		ifTrue: [
				startFiller ifNotNil: [ ^ self ].
				startFiller := anElement newFiller
					               id: #'start-filler';
					               yourself.
				startFiller constraints vertical matchParent.
				startFiller constraints horizontal matchParent.
				anElement addChild: startFiller before: anElement middleContainer ]
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
				anElement addChild: startGap before: anElement middleContainer ].
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
TToTripletElementConfiguration >> endGap [

	^ endGap
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endInterspace [

	^ endInterspace 
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> endInterspace: aNumber [

	endInterspace := aNumber
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> initializeAsTripletElementConfiguration [

	startFlexible := false.
	endFlexible := false.
	startInterspace := 0.
	endInterspace := 0
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

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startAlignment [

	^ startAlignment
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startAlignment: aNumber [

	startAlignment := aNumber
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
TToTripletElementConfiguration >> startGap [

	^ startGap
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startInterspace [

	^ startInterspace
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> startInterspace: aNumber [

	startInterspace := aNumber
]
