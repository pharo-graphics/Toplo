Class {
	#name : #ToDividerEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'startPosition',
		'startBounds',
		'firstTargetPositionChangeHandler',
		'secondTargetPositionChangeHandler',
		'paneExtentHandler',
		'divider'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'dnd handlers' }
ToDividerEventHandler >> appliedDragDeltaFromPosition: aPoint [

	| dragDelta |
	dragDelta := aPoint - startPosition.
	( divider isVertical and: [ self pane isLeftToRight ]) ifTrue: [
		dragDelta := dragDelta negated ].
	^ dragDelta
]

{ #category : #accessing }
ToDividerEventHandler >> divider [

	^ divider
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent [

	| firstTargetBounds secondTargetBounds dragDelta |
	
	anEvent consume.

	firstTargetBounds := startBounds first copy.
	secondTargetBounds := startBounds second copy.

	dragDelta := self appliedDragDeltaFromPosition: anEvent position.

	self
		dragEvent: anEvent
		resizedElement: self firstResizedElement
		bounds: firstTargetBounds
		by: dragDelta.

	self
		dragEvent: anEvent
		resizedElement: self secondResizedElement
		bounds: secondTargetBounds
		by: dragDelta negated.

	 divider requestLayout
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent resizedElement: aResizedElement bounds: aTargetBounds by: aDelta [

	| targetOriginalBounds widthChanged heightChanged |
	targetOriginalBounds := aTargetBounds copy.

	self resizeBounds: aTargetBounds by: aDelta.
	widthChanged := aTargetBounds width ~= targetOriginalBounds width.
	heightChanged := aTargetBounds height ~= targetOriginalBounds height.

	aResizedElement globalBoundsToLocal: aTargetBounds.
	aResizedElement localBoundsToParent: aTargetBounds.

	(widthChanged or: [ heightChanged ]) ifFalse: [ ^ self ].

	" in case of matchParent, the width/height must be converted as a weight "
	widthChanged ifTrue: [
		self
			horizontalDragEvent: anEvent
			resizedElement: aResizedElement
			width: aTargetBounds width ].

	heightChanged ifTrue: [
		self
			verticalDragEvent: anEvent
			resizedElement: aResizedElement
			height: aTargetBounds height ]
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragStartEvent: anEvent [

	" consume before super send to ensure dragged state "
	anEvent consume.

	"drag start position in parent"
	startPosition := anEvent position.

	"element's original bounds"
	startBounds := {
		               self firstResizedElement bounds.
		               self secondResizedElement bounds } collect: [ :bnds |
		               bnds inSpace bounds ]
]

{ #category : #'api - accessing' }
ToDividerEventHandler >> eventsToHandle [

	^ { BlDragEvent. BlDragStartEvent }
]

{ #category : #accessing }
ToDividerEventHandler >> firstResizedElement [

	^  divider firstResizedElement
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> horizontalDragEvent: anEvent resizedElement: aResizedElement width: aWidth [

	| w other |
	other := self otherResizedElementFrom: aResizedElement.
	((aResizedElement = self firstResizedElement and: [
		  other constraints horizontal resizer isExact ]) or: [
		 anEvent modifiers isShift ]) ifTrue: [
		aResizedElement width: aWidth.
		^ self ].
	"((aResizedElement = self secondResizedElement and: [
		  aResizedElement constraints horizontal resizer isExact ]) and: [
		 anEvent modifiers isShift ]) ifTrue: [
		aResizedElement width: aWidth.
		^ self ]."
	w := self resizedElementWeightFromWidth: aWidth.
	aResizedElement constraints linear weight: w
]

{ #category : #accessing }
ToDividerEventHandler >> leftResizedElement [

	^  divider leftResizedElement
]

{ #category : #accessing }
ToDividerEventHandler >> minimumExtent [

	^ 1@1
]

{ #category : #'api - hooks' }
ToDividerEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	divider := anElement.

	paneExtentHandler := BlEventHandler
		                     on: BlElementExtentChangedEvent
		                     do: [ :event | divider requestLayout ].
	firstTargetPositionChangeHandler := BlEventHandler
		                                    on:
		                                    BlElementPositionChangedEvent
		                                    do: [ divider requestLayout ].
	secondTargetPositionChangeHandler := BlEventHandler
		                                     on:
		                                     BlElementPositionChangedEvent
		                                     do: [ divider requestLayout ].

	anElement container addEventHandler: paneExtentHandler.
	anElement firstResizedElement addEventHandler:
		firstTargetPositionChangeHandler.
	anElement secondResizedElement addEventHandler:
		secondTargetPositionChangeHandler
]

{ #category : #'api - hooks' }
ToDividerEventHandler >> onUninstalledIn: anElement [

	anElement pane removeEventHandler: paneExtentHandler.
	anElement firstResizedElement removeEventHandler: firstTargetPositionChangeHandler.
	anElement secondResizedElement removeEventHandler: secondTargetPositionChangeHandler.
	
	divider := nil.
	
	super onUninstalledIn: anElement.	

]

{ #category : #accessing }
ToDividerEventHandler >> otherResizedElementFrom: aResizedElement [

	^ aResizedElement = self firstResizedElement
		  ifTrue: [ self secondResizedElement ]
		  ifFalse: [ self firstResizedElement ]
]

{ #category : #accessing }
ToDividerEventHandler >> pane [

	^ divider container
]

{ #category : #resizer }
ToDividerEventHandler >> resizeBounds: aBlBounds by: aPoint [

	 divider isHorizontal
		ifTrue: [
			aBlBounds extent: (aBlBounds extent + (0.0 @ aPoint y) max: self minimumExtent) ]
		ifFalse: [
			aBlBounds extent: (aBlBounds extent + (aPoint x negated @ 0.0) max: self minimumExtent) ]
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> resizedElementWeightFromWidth: aWidth [

	^  divider resizedElementWeightFromWidth: aWidth
]

{ #category : #accessing }
ToDividerEventHandler >> secondResizedElement [

	^  divider secondResizedElement
]

{ #category : #accessing }
ToDividerEventHandler >> topResizedElement [

	^  divider topResizedElement
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> verticalDragEvent: anEvent resizedElement: aResizedElement height: aHeight [

	| w |
	(aResizedElement constraints vertical resizer isExact or: [
		 anEvent modifiers isShift ]) ifTrue: [
		aResizedElement = self topResizedElement ifTrue: [
			aResizedElement height: aHeight.
			^ self ] ].
	w := self resizedElementWeightFromWidth: aHeight.
	aResizedElement constraints linear weight: w
]
