Class {
	#name : #ToPaneDivider,
	#superclass : #ToDivider,
	#instVars : [
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

	^ self hasParent and: [ self parent width isZero not ]
]

{ #category : #initialization }
ToPaneDivider >> defaultEventHandler [ 

	^ ToPaneDividerEventHandler new
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

{ #category : #layout }
ToPaneDivider >> layoutHorizontally [

	| firstY secondY gap |
	firstY := self topResizedElement bounds bottom
	          + self topResizedElement margin bottom.
	secondY := self bottomResizedElement bounds top
	           - self bottomResizedElement margin bottom.

	gap := secondY - firstY / 2 - (self thickness / 2).
	" since I'm ignored by layout, I can set my position explicitely here "
	self position: 0 @ (firstY + gap)
]

{ #category : #layout }
ToPaneDivider >> layoutVertically [

	| gap firstX secondX |
	firstX := self leftResizedElement bounds right
	          + self leftResizedElement margin right.

	secondX := self rightResizedElement bounds left
	           - self rightResizedElement margin left.

	gap := secondX - firstX - self thickness / 2.
	" since I'm ignored by layout, I can set my position explicitely here "
	self position: (firstX + gap) @ 0
]

{ #category : #accessing }
ToPaneDivider >> leftResizedElement [

	^ self firstResizedElement bounds left < self secondResizedElement bounds left
		  ifTrue: [ self firstResizedElement ]
		  ifFalse: [ self secondResizedElement ]
]

{ #category : #layout }
ToPaneDivider >> measureHorizontally [

	| w |
		
	w := self resizedElementWeightFromHeight:
		     self firstResizedElement measuredHeight.
	self firstResizedElement constraints linear weight: w.

	w := self resizedElementWeightFromHeight:
		     self secondResizedElement measuredHeight.
	self secondResizedElement constraints linear weight: w
]

{ #category : #layout }
ToPaneDivider >> measureVertically [

	| w |

	w := self resizedElementWeightFromWidth:
		     self firstResizedElement measuredWidth.
	self firstResizedElement constraints linear weight: w.

	w := self resizedElementWeightFromWidth:
		     self secondResizedElement measuredWidth.
	self secondResizedElement constraints linear weight: w
]

{ #category : #layout }
ToPaneDivider >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self canApplyLayoutOnPanes ifFalse: [ ^ self ].

	self isHorizontal
		ifTrue: [ self layoutHorizontally ]
		ifFalse: [ self layoutVertically ].


]

{ #category : #layout }
ToPaneDivider >> onMeasure: anExtentMeasurementSpec [

	super onMeasure: anExtentMeasurementSpec.
	self canApplyLayoutOnPanes ifFalse: [ ^ self ].

	self isHorizontal
		ifTrue: [ self measureHorizontally ]
		ifFalse: [ self measureVertically ]
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
