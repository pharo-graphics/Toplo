Class {
	#name : #ToDividerEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'divider',
		'dragStartPosition',
		'firstTargetOriginalExtent',
		'secondTargetOriginalExtent',
		'firstTargetOriginalPosition',
		'secondTargetOriginalPosition'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #accessing }
ToDividerEventHandler >> divider [

	^ divider
]

{ #category : #accessing }
ToDividerEventHandler >> divider: aDivider [

	divider := aDivider
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEndEvent: anEvent [
	
	self dragEvent: anEvent
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent [

	| dragPosition dragDelta widthChanged heightChanged firstTargetBounds secondTargetBounds firstTargetOriginalBounds secondTargetOriginalBounds appliedDragDelta |
	anEvent consumed: true.

	dragPosition := anEvent position.
	dragDelta := dragPosition - dragStartPosition.

	firstTargetBounds := BlBounds
		                     origin: firstTargetOriginalPosition
		                     extent: firstTargetOriginalExtent.
	secondTargetBounds := BlBounds
		                      origin: secondTargetOriginalPosition
		                      extent: secondTargetOriginalExtent.

	firstTargetOriginalBounds := firstTargetBounds copy.
	secondTargetOriginalBounds := secondTargetBounds copy.

	appliedDragDelta := (self divider isVertical)
			 ifTrue: [ dragDelta negated ]
			 ifFalse: [ dragDelta ].
	(self divider isVertical and: [self pane isRightToLeft ]) ifTrue: [ appliedDragDelta := appliedDragDelta negated ].
	self resizeBounds: firstTargetBounds by: (appliedDragDelta).
	self resizeBounds: secondTargetBounds by: (appliedDragDelta negated).
	widthChanged := firstTargetBounds width ~= firstTargetOriginalBounds width.
	heightChanged := firstTargetBounds height ~= firstTargetOriginalBounds height.

	self firstTarget globalBoundsToLocal: firstTargetBounds.
	self secondTarget globalBoundsToLocal: secondTargetBounds.
	self firstTarget localBoundsToParent: firstTargetBounds.
	self secondTarget localBoundsToParent: secondTargetBounds.

	anEvent currentTarget mouseCursor: self resizerCursor.
	(widthChanged or: [ heightChanged ]) ifFalse: [ ^ self ].

	" in case of matchParent, the width/height must be converted as a weight "
	widthChanged ifTrue: [
		| w |
		self firstTarget constraints horizontal resizer isExact
			ifTrue: [ self firstTarget width: firstTargetBounds width ]
			ifFalse: [
				w := self weightFromWidth: firstTargetBounds width.
				self firstTarget constraints linear weight: w ].
		self secondTarget constraints horizontal resizer isExact
			ifTrue: [ self secondTarget width: secondTargetBounds width ]
			ifFalse: [
				w := self weightFromWidth: secondTargetBounds width.
				self secondTarget constraints linear weight: w ] ].

	heightChanged ifTrue: [
		| w |
		self firstTarget constraints vertical resizer isExact
			ifTrue: [ self firstTarget height: firstTargetBounds height ]
			ifFalse: [
				w := self weightFromWidth: firstTargetBounds height.
				self firstTarget constraints linear weight: w ].
		self secondTarget constraints vertical resizer isExact
			ifTrue: [ self secondTarget height: secondTargetBounds height ]
			ifFalse: [
				w := self weightFromWidth: secondTargetBounds height.
				self secondTarget constraints linear weight: w ] ].

	self divider requestLayout
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in parent"
	dragStartPosition := anEvent position.

	"element's original extent"
	firstTargetOriginalExtent := self firstTarget bounds inSpace extent.
	secondTargetOriginalExtent := self secondTarget bounds inSpace extent.
	firstTargetOriginalPosition := self firstTarget bounds inSpace position.
	secondTargetOriginalPosition := self secondTarget bounds inSpace position
]

{ #category : #'api - accessing' }
ToDividerEventHandler >> eventsToHandle [

	^ { BlDragEndEvent. BlDragStartEvent. BlDragEvent. BlMouseDownEvent. BlMouseEnterEvent. BlMouseLeaveEvent. BlMouseUpEvent }
]

{ #category : #accessing }
ToDividerEventHandler >> firstTarget [

	^ self divider firstTarget
]

{ #category : #accessing }
ToDividerEventHandler >> minimumExtent [

	^ 10@10
]

{ #category : #'mouse handlers' }
ToDividerEventHandler >> mouseDownEvent: anEvent [

	anEvent consumed: true
]

{ #category : #'mouse handlers' }
ToDividerEventHandler >> mouseEnterEvent: anEvent [

	anEvent currentTarget mouseCursor: self resizerCursor.
	anEvent consumed: true
]

{ #category : #'mouse handlers' }
ToDividerEventHandler >> mouseLeaveEvent: anEvent [

	anEvent consumed: true.
	anEvent anyButtonPressed ifFalse: [ ^ self ].
	anEvent currentTarget mouseCursor: BlCursor default.
]

{ #category : #'mouse handlers' }
ToDividerEventHandler >> mouseUpEvent: anEvent [
	
]

{ #category : #accessing }
ToDividerEventHandler >> pane [

	^ self divider pane
]

{ #category : #resizer }
ToDividerEventHandler >> resizeBounds: aBlBounds by: aPoint [

	self divider isHorizontal
		ifTrue: [
			aBlBounds extent: (aBlBounds extent + (0 @ aPoint y) max: self minimumExtent) ]
		ifFalse: [
			aBlBounds extent: (aBlBounds extent + (aPoint negated x @ 0.0) max: self minimumExtent) ]
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
ToDividerEventHandler >> weightFromWidth: aWidth [

	^ self divider weightFromWidth: aWidth
]
