Class {
	#name : #ToDivider,
	#superclass : #ToElement,
	#instVars : [
		'thickness',
		'firstResizedElement',
		'secondResizedElement'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'instance creation' }
ToDivider class >> between: aFirstElement and: aSecondElement [

	^ self basicNew
		  firstResizedElement: aFirstElement;
		  secondResizedElement: aSecondElement;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
ToDivider class >> new [

	^ self error: 'Use between:and:'
]

{ #category : #accessing }
ToDivider >> bottomResizedElement [

	^ self topResizedElement = self firstResizedElement
		  ifTrue: [ self secondResizedElement ]
		  ifFalse: [ self firstResizedElement ]
]

{ #category : #layout }
ToDivider >> canApplyLayoutOnPanes [

	^ self isAttachedToSceneGraph and: [ self parent width isZero not ]
]

{ #category : #initialization }
ToDivider >> defaultEventHandler [ 

	^ ToDividerEventHandler new
]

{ #category : #initialization }
ToDivider >> defaultLayout [

	^ BlBasicLayout new 
]

{ #category : #initialization }
ToDivider >> defaultThickness [

	^ 3
]

{ #category : #accessing }
ToDivider >> firstResizedElement [

	^ firstResizedElement
]

{ #category : #accessing }
ToDivider >> firstResizedElement: anElement [

	firstResizedElement := anElement
]

{ #category : #initialization }
ToDivider >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self addEventHandler: self defaultEventHandler 
]

{ #category : #testing }
ToDivider >> isHorizontal [

	^ self parent isVertical
]

{ #category : #testing }
ToDivider >> isVertical [

	^ self isHorizontal not
]

{ #category : #layout }
ToDivider >> layoutInHorizontalPane [

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
ToDivider >> layoutInVerticalPane [

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
ToDivider >> leftResizedElement [

	^ self firstResizedElement bounds left < self secondResizedElement bounds left
		  ifTrue: [ self firstResizedElement ]
		  ifFalse: [ self secondResizedElement ]
]

{ #category : #layout }
ToDivider >> measureInHorizontalPane [

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
ToDivider >> measureInVerticalPane [

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
ToDivider >> newRawSkin [

	^ ToDividerSkin new
]

{ #category : #layout }
ToDivider >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self canApplyLayoutOnPanes ifFalse: [ ^ self ].

	self isHorizontal
		ifTrue: [ self layoutInVerticalPane ]
		ifFalse: [ self layoutInHorizontalPane ].


]

{ #category : #layout }
ToDivider >> onMeasure: anExtentMeasurementSpec [

	super onMeasure: anExtentMeasurementSpec.
	self canApplyLayoutOnPanes ifFalse: [ ^ self ].

	self isHorizontal
		ifTrue: [ self measureInVerticalPane ]
		ifFalse: [ self measureInHorizontalPane ]
]

{ #category : #accessing }
ToDivider >> resizedElementWeightFromHeight: aWidth [

	^ aWidth / self parent height
]

{ #category : #accessing }
ToDivider >> resizedElementWeightFromWidth: aWidth [

	^ aWidth / self parent width
]

{ #category : #accessing }
ToDivider >> rightResizedElement [

	^ self leftResizedElement = self firstResizedElement
		  ifTrue: [ self secondResizedElement ]
		  ifFalse: [ self firstResizedElement ]
]

{ #category : #accessing }
ToDivider >> secondResizedElement [

	^ secondResizedElement
]

{ #category : #accessing }
ToDivider >> secondResizedElement: anElement [

	secondResizedElement := anElement
]

{ #category : #accessing }
ToDivider >> thickness [

	^ thickness ifNil: [ thickness := self defaultThickness ]
]

{ #category : #accessing }
ToDivider >> thickness: aNumber [

	thickness := aNumber.
	self requestLayout
]

{ #category : #accessing }
ToDivider >> topResizedElement [

	^ self firstResizedElement bounds top < self secondResizedElement bounds top
		  ifTrue: [ self firstResizedElement ]
		  ifFalse: [ self secondResizedElement ]
]

{ #category : #accessing }
ToDivider >> weight: aFloat [

	self constraints linear weight: aFloat.
	self firstResizedElement constraints linear weight: aFloat.
]
