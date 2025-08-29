Trait {
	#name : #TToTripletElementConfiguration,
	#instVars : [
		'endGap',
		'startGap',
		'startAlignment',
		'endAlignment',
		'endInterspace',
		'startInterspace',
		'alignCenter'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> alignCenter [

	^ alignCenter
]

{ #category : #'t - triplet element accessing' }
TToTripletElementConfiguration >> alignCenter: aBoolean [

	alignCenter := aBoolean
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> applyTripletElementConfigurationOn: anElement [

	self configureChildrenIn: anElement.
	self configureEndContainerIn: anElement.
	self configureEndGapIn: anElement.
	self configureStartContainerIn: anElement.
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
						child constraints linear vertical alignCenter.
						child constraints frame vertical alignCenter ] ]
		ifFalse: [
				allChildren do: [ :child |
						child constraints linear horizontal alignCenter.
						child constraints frame horizontal alignCenter ] ].
	alignCenter
		ifTrue: [ anElement layout alignCenter ]
		ifFalse: [ anElement layout alignCenterLeft ].
	anElement requestLayout
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureEndContainerIn: anElement [

	anElement endContainer ifNil: [ ^ self ].
	anElement isHorizontal
		ifTrue: [
				endAlignment
					ifNil: [ anElement endContainer hFitContent ]
					ifNotNil: [ anElement endContainer hExact: endAlignment ].
				anElement endContainer vFitContent ]
		ifFalse: [
				endAlignment
					ifNil: [ anElement endContainer vFitContent ]
					ifNotNil: [ anElement endContainer vExact: endAlignment ].
				anElement endContainer hFitContent ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureEndElementIn: anElement [

	anElement endElement ifNil: [ ^ self ].
	anElement isHorizontal
		ifTrue: [
			anElement endElement constraints frame horizontal alignRight.
			anElement endElement constraints linear horizontal alignRight ]
		ifFalse: [
			anElement endElement constraints frame vertical alignBottom.
			anElement endElement constraints linear vertical alignBottom ]
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
							endGap vExact: 0.
							endGap hExact: endInterspace ]
					ifFalse: [
							endGap hExact: 0.
							endGap vExact: endInterspace ] ]
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
				startAlignment
					ifNil: [ anElement startContainer hFitContent ]
					ifNotNil: [ anElement startContainer hExact: startAlignment ].
				anElement startContainer vFitContent ]
		ifFalse: [
				startAlignment
					ifNil: [ anElement startContainer vFitContent ]
					ifNotNil: [ anElement startContainer vExact: startAlignment ].
				anElement startContainer hFitContent ]
]

{ #category : #'t - triplet element configuration' }
TToTripletElementConfiguration >> configureStartElementIn: anElement [

	anElement startElement ifNil: [ ^ self ].
	anElement isHorizontal
		ifTrue: [
			anElement startElement constraints frame horizontal alignLeft.
			anElement startElement constraints linear horizontal alignLeft ]
		ifFalse: [
			anElement startElement constraints frame vertical alignBottom.
			anElement startElement constraints linear vertical alignBottom ]
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
							startGap vExact: 0.
							startGap hExact: startInterspace ]
					ifFalse: [
							startGap hExact: 0.
							startGap vExact: startInterspace ] ]
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

	alignCenter := false.
	startInterspace := 0.
	endInterspace := 0
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
