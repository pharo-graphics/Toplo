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
	"anEvent consumed: true"
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent [

	| dragPosition dragDelta widthChanged heightChanged firstTargetBounds secondTargetBounds firstTargetOriginalBounds secondTargetOriginalBounds dividerPosition |
	anEvent consumed: true.

	dividerPosition := self divider position.
	dragPosition := anEvent position.
	dragDelta := dragPosition - dragStartPosition.

	firstTargetBounds := BlBounds origin: firstTargetOriginalPosition extent: firstTargetOriginalExtent.
	secondTargetBounds := BlBounds origin: secondTargetOriginalPosition extent: secondTargetOriginalExtent.

	firstTargetOriginalBounds := firstTargetBounds copy.
	secondTargetOriginalBounds := secondTargetBounds copy.

	self resizeBounds: firstTargetBounds by: (self divider isVertical ifTrue: [dragDelta negated] ifFalse: [dragDelta]).
	self resizeBounds: secondTargetBounds by: (self divider isHorizontal ifTrue: [dragDelta negated] ifFalse: [dragDelta]).
	widthChanged := firstTargetBounds width ~= firstTargetOriginalBounds width.
	heightChanged := firstTargetBounds height ~= firstTargetOriginalBounds height.

	self firstTarget globalBoundsToLocal: firstTargetBounds.
	self secondTarget globalBoundsToLocal: secondTargetBounds.
	self firstTarget localBoundsToParent: firstTargetBounds.
	self secondTarget localBoundsToParent: secondTargetBounds.

	anEvent currentTarget mouseCursor: self resizerCursor.
	(widthChanged or: [ heightChanged ]) ifFalse: [ ^ self ].

	widthChanged ifTrue: [ | w |
		self firstTarget constraints horizontal resizer isExact ifTrue: [
			self firstTarget width: firstTargetBounds width ].
		self secondTarget constraints horizontal resizer isExact ifTrue: [
			self secondTarget width: secondTargetBounds width ].
		w := self weightFromWidth: firstTargetBounds width.
		self firstTarget constraints linear weight: w.
		w := self weightFromWidth: secondTargetBounds width.
		self secondTarget constraints linear weight: w].

	heightChanged ifTrue: [ | w |
		self firstTarget constraints vertical resizer isExact ifTrue: [
			self firstTarget height: firstTargetBounds height ].
		self secondTarget constraints vertical resizer isExact ifTrue: [
			self secondTarget height: secondTargetBounds height ].
		w := self weightFromWidth: firstTargetBounds height.
		self firstTarget constraints linear weight: w.
		w := self weightFromWidth: secondTargetBounds height.
		self secondTarget constraints linear weight: w].

	self divider adaptToPane
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

	"anEvent consumed: true"
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
	anEvent currentTarget mouseCursor: self resizerCursor
]

{ #category : #'mouse handlers' }
ToDividerEventHandler >> mouseUpEvent: anEvent [

	anEvent currentTarget mouseCursor: BlCursor default.
	"anEvent consumed: true"
	
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
