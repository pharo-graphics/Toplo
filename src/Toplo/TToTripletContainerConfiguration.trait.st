Trait {
	#name : #TToTripletContainerConfiguration,
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

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> alignCenter [

	^ alignCenter
]

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> alignCenter: aBoolean [

	alignCenter := aBoolean
]

{ #category : #'t - triplet container configuration' }
TToTripletContainerConfiguration >> applyTripletContainerConfigurationOn: anElement [

	self configureChildrenIn: anElement.
	self configureEndContainerIn: anElement.
	self configureEndGapIn: anElement.
	self configureStartContainerIn: anElement.
	self configureStartGapIn: anElement
]

{ #category : #'t - triplet container configuration' }
TToTripletContainerConfiguration >> configureChildrenIn: anElement [

	| allChildren |
	allChildren := Array streamContents: [ :stream |
			               stream nextPutAll: anElement startChildren.
			               stream nextPut: anElement middleContainer.
			               stream nextPutAll: anElement endChildren ].
	anElement isHorizontal
		ifTrue: [
				allChildren do: [ :child |
						child constraints linear vertical alignCenter ] ]
		ifFalse: [
				allChildren do: [ :child |
						child constraints linear horizontal alignCenter ] ].
	alignCenter ifTrue: [ anElement layout alignCenter ].
	anElement requestLayout
]

{ #category : #'t - triplet container configuration' }
TToTripletContainerConfiguration >> configureEndContainerIn: anElement [

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

{ #category : #'t - triplet container configuration' }
TToTripletContainerConfiguration >> configureEndGapIn: anElement [

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

{ #category : #'t - triplet container configuration' }
TToTripletContainerConfiguration >> configureStartContainerIn: anElement [

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

{ #category : #'t - triplet container configuration' }
TToTripletContainerConfiguration >> configureStartGapIn: anElement [

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

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> endAlignment [

	^ endAlignment

]

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> endAlignment: aNumber [

	endAlignment := aNumber.

]

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> endGap [

	^ endGap
]

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> endInterspace [

	^ endInterspace 
]

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> endInterspace: aNumber [

	endInterspace := aNumber
]

{ #category : #'t - triplet container initialization' }
TToTripletContainerConfiguration >> initializeAsTripletContainerConfiguration [

	alignCenter := false.
	startInterspace := 0.
	endInterspace := 0
]

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> startAlignment [

	^ startAlignment
]

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> startAlignment: aNumber [

	startAlignment := aNumber
]

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> startGap [

	^ startGap
]

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> startInterspace [

	^ startInterspace
]

{ #category : #'t - triplet container accessing' }
TToTripletContainerConfiguration >> startInterspace: aNumber [

	startInterspace := aNumber
]
