Class {
	#name : #ToDividerEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#instVars : [
		'startPosition',
		'startBounds',
		'firstTargetPositionChangeHandler',
		'secondTargetPositionChangeHandler',
		'paneExtentHandler'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'dnd handlers' }
ToDividerEventHandler >> appliedDragDeltaFromPosition: aPoint [

	| dragDelta |
	dragDelta := aPoint - startPosition.
	(self divider isVertical and: [ self pane isLeftToRight ]) ifTrue: [
		dragDelta := dragDelta negated ].
	^ dragDelta
]

{ #category : #accessing }
ToDividerEventHandler >> divider [

	^ target
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent [

	| firstTargetBounds secondTargetBounds dragDelta |
	
	super dragEvent: anEvent.
	anEvent consumed: true.

	firstTargetBounds := startBounds first copy.
	secondTargetBounds := startBounds second copy.

	dragDelta := self appliedDragDeltaFromPosition: anEvent position.

	self
		dragEvent: anEvent
		target: self firstTarget
		bounds: firstTargetBounds
		by: dragDelta.

	self
		dragEvent: anEvent
		target: self secondTarget
		bounds: secondTargetBounds
		by: dragDelta negated.

	self divider requestLayout
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent target: aTarget bounds: aTargetBounds by: aDelta [

	| targetOriginalBounds widthChanged heightChanged |
	targetOriginalBounds := aTargetBounds copy.

	self resizeBounds: aTargetBounds by: aDelta.
	widthChanged := aTargetBounds width ~= targetOriginalBounds width.
	heightChanged := aTargetBounds height ~= targetOriginalBounds height.

	aTarget globalBoundsToLocal: aTargetBounds.
	aTarget localBoundsToParent: aTargetBounds.

	(widthChanged or: [ heightChanged ]) ifFalse: [ ^ self ].

	" in case of matchParent, the width/height must be converted as a weight "
	widthChanged ifTrue: [
		self
			horizontalDragEvent: anEvent
			target: aTarget
			width: aTargetBounds width ].

	heightChanged ifTrue: [
		self
			verticalDragEvent: anEvent
			target: aTarget
			height: aTargetBounds height ]
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragStartEvent: anEvent [

	super dragStartEvent: anEvent.
	anEvent consumed: true.

	"drag start position in parent"
	startPosition := anEvent position.

	"element's original bounds"
	startBounds := {
		               self firstTarget bounds.
		               self secondTarget bounds } collect: [ :bnds |
		               bnds inSpace bounds copy ]
]

{ #category : #'api - accessing' }
ToDividerEventHandler >> eventsToHandle [

	^ {
		  BlDragEndEvent.
		  BlDragStartEvent.
		  BlDragEvent.
		  BlMouseDownEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseUpEvent }
]

{ #category : #accessing }
ToDividerEventHandler >> firstTarget [

	^ self divider firstTarget
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> horizontalDragEvent: anEvent target: aTarget width: aWidth [

	aTarget constraints horizontal resizer isExact
		ifTrue: [
			(aTarget == self leftTarget or: [ anEvent modifiers isShift ])
				ifTrue: [ aTarget width: aWidth ] ]
		ifFalse: [
			| w |
			w := self weightFromWidth: aWidth.
			aTarget constraints linear weight: w ]
]

{ #category : #'mouse handlers' }
ToDividerEventHandler >> leftMouseDownEvent: anEvent [

	super leftMouseDownEvent: anEvent.
	self divider border: (BlBorder paint: self divider colorProvider pressedBorderColor).
	self divider background: self divider colorProvider pressedBackgroundColor
]

{ #category : #'mouse handlers' }
ToDividerEventHandler >> leftMouseUpEvent: anEvent [

	super leftMouseUpEvent: anEvent.
	self divider border: (BlBorder paint: self divider colorProvider defaultBorderColor).
	self divider background: self divider colorProvider defaultBackgroundColor.
	self divider space mouseProcessor handleLastMouseMove.
	self divider mouseCursor: BlCursor default.
]

{ #category : #accessing }
ToDividerEventHandler >> leftTarget [

	^ self divider leftTarget
]

{ #category : #accessing }
ToDividerEventHandler >> minimumExtent [

	^ 10@10
]

{ #category : #'mouse handlers' }
ToDividerEventHandler >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	self divider mouseCursor: self resizerCursor.
	anEvent consumed: true.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self divider border: (BlBorder paint: self divider colorProvider hoveredBorderColor).
	self divider background: self divider colorProvider hoveredBackgroundColor
]

{ #category : #'mouse handlers' }
ToDividerEventHandler >> mouseLeaveEvent: anEvent [

	super mouseLeaveEvent: anEvent.
	anEvent consumed: true.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self divider border: (BlBorder paint: self divider colorProvider defaultBorderColor).
	self divider background: self divider colorProvider defaultBackgroundColor.
	self divider mouseCursor: BlCursor default.
]

{ #category : #'api - hooks' }
ToDividerEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	paneExtentHandler := BlEventHandler on: BlElementExtentChangedEvent do: [ :event | self divider requestLayout ].	
	firstTargetPositionChangeHandler := BlEventHandler on: BlElementPositionChangedEvent do: [ self divider requestLayout ].	
	secondTargetPositionChangeHandler := BlEventHandler on: BlElementPositionChangedEvent do: [ self divider requestLayout ].
	
	anElement pane addEventHandler: paneExtentHandler.
	anElement firstTarget addEventHandler: firstTargetPositionChangeHandler.
	anElement secondTarget addEventHandler: secondTargetPositionChangeHandler.
]

{ #category : #'api - hooks' }
ToDividerEventHandler >> onUninstalledIn: anElement [

	anElement pane removeEventHandler: paneExtentHandler.
	anElement firstTarget removeEventHandler: firstTargetPositionChangeHandler.
	anElement secondTarget removeEventHandler: secondTargetPositionChangeHandler.
	super onUninstalledIn: anElement.	

]

{ #category : #accessing }
ToDividerEventHandler >> pane [

	^ self divider pane
]

{ #category : #resizer }
ToDividerEventHandler >> resizeBounds: aBlBounds by: aPoint [

	self divider isHorizontal
		ifTrue: [
			aBlBounds extent: (aBlBounds extent + (0.0 @ aPoint y) max: self minimumExtent) ]
		ifFalse: [
			aBlBounds extent: (aBlBounds extent + (aPoint x negated @ 0.0) max: self minimumExtent) ]
]

{ #category : #resizer }
ToDividerEventHandler >> resizerCursor [

	^ self divider isHorizontal
		  ifTrue: [ BlCursor resizeTop ]
		  ifFalse: [ BlCursor resizeRight ]
]

{ #category : #accessing }
ToDividerEventHandler >> secondTarget [

	^ self divider secondTarget
]

{ #category : #accessing }
ToDividerEventHandler >> topTarget [

	^ self divider topTarget
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> verticalDragEvent: anEvent target: aTarget height: aHeight [

	aTarget constraints vertical resizer isExact
		ifTrue: [
			(aTarget == self topTarget or: [ anEvent modifiers isShift ])
				ifTrue: [ aTarget height: aHeight ] ]
		ifFalse: [
			| w |
			w := self weightFromWidth: aHeight.
			aTarget constraints linear weight: w ]
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> weightFromWidth: aWidth [

	^ self divider weightFromWidth: aWidth
]
