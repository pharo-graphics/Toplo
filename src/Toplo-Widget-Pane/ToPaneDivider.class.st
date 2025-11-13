Class {
	#name : #ToPaneDivider,
	#superclass : #ToElement,
	#instVars : [
		'thickness',
		'firstResizedElement',
		'secondResizedElement'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'instance creation' }
ToPaneDivider class >> between: aFirstElement and: aSecondElement [

	^ self basicNew
		  firstResizedElement: aFirstElement;
		  secondResizedElement: aSecondElement;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
ToPaneDivider class >> new [

	^ self error: 'Use between:and:'
]

{ #category : #accessing }
ToPaneDivider >> bottomResizedElement [

	^ self topResizedElement = self firstResizedElement
		  ifTrue: [ self secondResizedElement ]
		  ifFalse: [ self firstResizedElement ]
]

{ #category : #layout }
ToPaneDivider >> canApplyLayoutOnPanes [

	^ self isAttachedToSceneGraph and: [ self parent width isZero not ]
]

{ #category : #initialization }
ToPaneDivider >> defaultEventHandler [ 

	^ ToPaneDividerEventHandler new
]

{ #category : #initialization }
ToPaneDivider >> defaultLayout [

	^ BlBasicLayout new 
]

{ #category : #initialization }
ToPaneDivider >> defaultThickness [

	^ 3
]

{ #category : #accessing }
ToPaneDivider >> firstResizedElement [

	^ firstResizedElement
]

{ #category : #accessing }
ToPaneDivider >> firstResizedElement: anElement [

	firstResizedElement := anElement
]

{ #category : #initialization }
ToPaneDivider >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self addEventHandler: self defaultEventHandler 
]

{ #category : #testing }
ToPaneDivider >> isHorizontal [

	^ self parent isVertical
]

{ #category : #testing }
ToPaneDivider >> isVertical [

	^ self isHorizontal not
]

{ #category : #layout }
ToPaneDivider >> layoutInHorizontalPane [

	| firstY secondY gap firstX secondX position |
	firstX := self leftResizedElement bounds right
	          + self leftResizedElement margin right.
	firstY := self leftResizedElement bounds top
	          + self leftResizedElement margin top.

	secondX := self rightResizedElement bounds left
	           - self rightResizedElement margin left.
	secondY := self rightResizedElement bounds top
	           + self rightResizedElement margin top.

	gap := secondX - firstX - self thickness / 2.
	position := firstX + gap @ (firstY min: secondY).
	" since I'm ignored by layout, I can set my position explicitely here "
	self position: position
]

{ #category : #layout }
ToPaneDivider >> layoutInVerticalPane [

	| firstY secondY gap firstX secondX x position |
	firstY := self topResizedElement bounds bottom
	          + self topResizedElement margin bottom.
	secondY := self bottomResizedElement bounds top
	           - self bottomResizedElement margin bottom.

	firstX := self topResizedElement bounds left
	          + self topResizedElement margin left.
	secondX := self bottomResizedElement bounds left
	           + self bottomResizedElement margin left.

	gap := secondY - firstY / 2 - (self thickness / 2).
	x := self parent direction isLeftToRight
		     ifTrue: [ firstX max: secondX ]
		     ifFalse: [ firstX min: secondX ].

	position := x @ firstY + gap.
	" since I'm ignored by layout, I can set my position explicitely here "
	self position: position
]

{ #category : #accessing }
ToPaneDivider >> leftResizedElement [

	^ self firstResizedElement bounds left < self secondResizedElement bounds left
		  ifTrue: [ self firstResizedElement ]
		  ifFalse: [ self secondResizedElement ]
]

{ #category : #layout }
ToPaneDivider >> measureInHorizontalPane [

	| firstH secondH w |
	firstH := self topResizedElement measuredHeight.
	secondH := self bottomResizedElement measuredHeight.
	self measuredExtent: self thickness @ (firstH max: secondH).

	w := self resizedElementWeightFromWidth:
		     self firstResizedElement measuredWidth.
	self firstResizedElement constraints linear weight: w.

	w := self resizedElementWeightFromWidth:
		     self secondResizedElement measuredWidth.
	self secondResizedElement constraints linear weight: w
]

{ #category : #layout }
ToPaneDivider >> measureInVerticalPane [

	| firstW secondW w |
	firstW := self topResizedElement measuredWidth.
	secondW := self bottomResizedElement measuredWidth.
		
	self measuredExtent: (firstW max: secondW) @ self thickness.

	w := self resizedElementWeightFromHeight:
		     self firstResizedElement measuredHeight.
	self firstResizedElement constraints linear weight: w.

	w := self resizedElementWeightFromHeight:
		     self secondResizedElement measuredHeight.
	self secondResizedElement constraints linear weight: w
]

{ #category : #skin }
ToPaneDivider >> newRawSkin [

	^ ToDividerSkin new
]

{ #category : #layout }
ToPaneDivider >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self canApplyLayoutOnPanes ifFalse: [ ^ self ].

	self isHorizontal
		ifTrue: [ self layoutInVerticalPane ]
		ifFalse: [ self layoutInHorizontalPane ].


]

{ #category : #layout }
ToPaneDivider >> onMeasure: anExtentMeasurementSpec [

	super onMeasure: anExtentMeasurementSpec.
	self canApplyLayoutOnPanes ifFalse: [ ^ self ].

	self isHorizontal
		ifTrue: [ self measureInVerticalPane ]
		ifFalse: [ self measureInHorizontalPane ]
]

{ #category : #accessing }
ToPaneDivider >> resizedElementWeightFromHeight: aWidth [

	^ aWidth / self parent height
]

{ #category : #accessing }
ToPaneDivider >> resizedElementWeightFromWidth: aWidth [

	^ aWidth / self parent width
]

{ #category : #accessing }
ToPaneDivider >> rightResizedElement [

	^ self leftResizedElement = self firstResizedElement
		  ifTrue: [ self secondResizedElement ]
		  ifFalse: [ self firstResizedElement ]
]

{ #category : #accessing }
ToPaneDivider >> secondResizedElement [

	^ secondResizedElement
]

{ #category : #accessing }
ToPaneDivider >> secondResizedElement: anElement [

	secondResizedElement := anElement
]

{ #category : #accessing }
ToPaneDivider >> thickness [

	^ thickness ifNil: [ thickness := self defaultThickness ]
]

{ #category : #accessing }
ToPaneDivider >> thickness: aNumber [

	thickness := aNumber.
	self requestLayout
]

{ #category : #accessing }
ToPaneDivider >> topResizedElement [

	^ self firstResizedElement bounds top < self secondResizedElement bounds top
		  ifTrue: [ self firstResizedElement ]
		  ifFalse: [ self secondResizedElement ]
]

{ #category : #accessing }
ToPaneDivider >> weight: aFloat [

	self constraints linear weight: aFloat.
	self firstResizedElement constraints linear weight: aFloat.
]
