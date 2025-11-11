Class {
	#name : #ToDividerEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'startPosition',
		'startBounds',
		'additionalHandlers'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent [

	| firstTargetBounds secondTargetBounds dragDelta divider |
	anEvent consume.

	divider := anEvent currentTarget.
	firstTargetBounds := startBounds first copy.
	secondTargetBounds := startBounds second copy.

	dragDelta := anEvent position - startPosition.
	(divider isVertical and: [
		 divider parent isLeftToRight ]) ifTrue: [
		dragDelta := dragDelta negated ].

	self
		dragEvent: anEvent
		resizedElement: divider firstResizedElement
		bounds: firstTargetBounds
		by: dragDelta.

	self
		dragEvent: anEvent
		resizedElement: divider secondResizedElement
		bounds: secondTargetBounds
		by: dragDelta negated.

	divider requestLayout
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent resizedElement: aResizedElement bounds: aTargetBounds by: aDelta [

	| targetOriginalBounds widthChanged heightChanged |
	targetOriginalBounds := aTargetBounds copy.

	self resizeBounds: aTargetBounds by: aDelta onEvent: anEvent.
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

	| divider |
	anEvent consume.
	divider := anEvent currentTarget.

	"drag start position in parent"
	startPosition := anEvent position.

	"element's original bounds"
	startBounds := {
		               divider firstResizedElement bounds.
		               divider secondResizedElement bounds } collect: [
		               :bnds | bnds inSpace bounds ]
]

{ #category : #'event handling' }
ToDividerEventHandler >> elementAddedToParentEvent: anEvent [

	additionalHandlers := OrderedCollection new.
	additionalHandlers add: anEvent currentTarget parent -> (BlEventHandler
			 on: BlElementExtentChangedEvent
			 do: [ anEvent currentTarget requestLayout ]).
	additionalHandlers add: anEvent currentTarget parent -> (BlEventHandler
			 on: ToLayoutOrientationChangedEvent
			 do: [ anEvent currentTarget requestNewSkin ]).
	additionalHandlers add:
		anEvent currentTarget firstResizedElement -> (BlEventHandler
			 on: BlElementPositionChangedEvent
			 do: [ anEvent currentTarget requestLayout ]).
	additionalHandlers add:
		anEvent currentTarget secondResizedElement -> (BlEventHandler
			 on: BlElementPositionChangedEvent
			 do: [ anEvent currentTarget requestLayout ]).
	additionalHandlers do: [ :assoc | assoc key addEventHandler: assoc value ]
]

{ #category : #'event handling' }
ToDividerEventHandler >> elementRemovedFromParentEvent: anEvent [

	additionalHandlers do: [ :assoc | assoc key removeEventHandler: assoc value ].
	additionalHandlers := nil
]

{ #category : #'api - accessing' }
ToDividerEventHandler >> eventsToHandle [

	^ {
		  BlDragEvent.
		  BlDragStartEvent.
		  BlElementAddedToParentEvent.
		  BlElementRemovedFromParentEvent }
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> horizontalDragEvent: anEvent resizedElement: aResizedElement width: aWidth [

	| w other divider |
	divider := anEvent currentTarget.
	other := self otherResizedElementFrom: aResizedElement event: anEvent.
	((aResizedElement = divider firstResizedElement and: [
		  other constraints horizontal resizer isExact ]) or: [
		 anEvent modifiers isShift ]) ifTrue: [
			aResizedElement width: aWidth.
			^ self ].

	w := divider resizedElementWeightFromWidth: aWidth.
	aResizedElement constraints linear weight: w
]

{ #category : #accessing }
ToDividerEventHandler >> minimumExtent [

	^ 1@1
]

{ #category : #accessing }
ToDividerEventHandler >> otherResizedElementFrom: aResizedElement event: anEvent [

	| divider |
	divider := anEvent currentTarget.
	^ aResizedElement = divider firstResizedElement
		  ifTrue: [ divider secondResizedElement ]
		  ifFalse: [ divider firstResizedElement ]
]

{ #category : #resizer }
ToDividerEventHandler >> resizeBounds: aBlBounds by: aPoint onEvent: anEvent [

	| divider |
	divider := anEvent currentTarget.
	divider isHorizontal
		ifTrue: [
				aBlBounds extent:
					(aBlBounds extent + (0.0 @ aPoint y) max: self minimumExtent) ]
		ifFalse: [
				aBlBounds extent:
					(aBlBounds extent + (aPoint x negated @ 0.0) max:
						 self minimumExtent) ]
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> verticalDragEvent: anEvent resizedElement: aResizedElement height: aHeight [

	| w other divider |
	divider := anEvent currentTarget.
	other := self otherResizedElementFrom: aResizedElement event: anEvent.
	((aResizedElement = divider firstResizedElement and: [
		  other constraints vertical resizer isExact ]) or: [
		 anEvent modifiers isShift ]) ifTrue: [
			aResizedElement height: aHeight.
			^ self ].

	w := divider resizedElementWeightFromHeight: aHeight.
	aResizedElement constraints linear weight: w
]
