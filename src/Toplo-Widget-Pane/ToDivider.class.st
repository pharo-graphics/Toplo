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
ToDivider >> layoutInHorizontalPaneWithContext: aContext [

	| firstY secondY gap firstX secondX position |
	
	firstX := self leftResizedElement measuredBounds inParent right + self leftResizedElement constraints margin right.
	firstY := self leftResizedElement measuredBounds inParent top + self leftResizedElement constraints margin top.

	secondX := self rightResizedElement measuredBounds inParent left - self rightResizedElement constraints margin left.	
	secondY := self rightResizedElement measuredBounds inParent top + self rightResizedElement constraints margin top.
	
	gap := (((secondX - firstX)  - (self thickness )) / 2).
	position := (firstX + gap) @ (firstY min: secondY).

	self constraints position: position.
	self measuredBounds position: position
]

{ #category : #layout }
ToDivider >> layoutInVerticalPaneWithContext: aContext [

	| firstY secondY gap firstX secondX x position |
	firstY := self topResizedElement bounds bottom
	          + self topResizedElement constraints margin bottom.
	secondY := self bottomResizedElement bounds top
	           - self bottomResizedElement constraints margin bottom.

	firstX := self topResizedElement bounds left + self topResizedElement constraints margin left.
	secondX := self bottomResizedElement bounds left + self bottomResizedElement constraints margin left.

	gap := secondY - firstY / 2 - (self thickness / 2).
	x := self parent direction isLeftToRight
		     ifTrue: [ firstX max: secondX ]
		     ifFalse: [ firstX min: secondX ].

	position := x @ firstY + gap.
	self constraints position: position.
	self measuredBounds position: position
]

{ #category : #accessing }
ToDivider >> leftResizedElement [

	^ self firstResizedElement bounds left < self secondResizedElement bounds left
		  ifTrue: [ self firstResizedElement ]
		  ifFalse: [ self secondResizedElement ]
]

{ #category : #layout }
ToDivider >> measureInHorizontalPane: anExtentMeasurementSpec [

	| firstH secondH w |
	firstH := self topResizedElement measuredBounds height.
	secondH := self bottomResizedElement measuredBounds height.
	self measuredExtent: self thickness @ (firstH max: secondH).
	w := self resizedElementWeightFromWidth: self firstResizedElement measuredWidth.
	(self firstResizedElement constraints linear weight closeTo: w) ifFalse: [
		self firstResizedElement constraintsDo: [ :c | c linear weight: w ] ].
	self weight: w.
	w := self resizedElementWeightFromWidth: self secondResizedElement measuredWidth.
	(self secondResizedElement constraints linear weight closeTo: w) ifFalse: [
		self secondResizedElement constraintsDo: [ :c | c linear weight: w ] ]
]

{ #category : #layout }
ToDivider >> measureInVerticalPane: anExtentMeasurementSpec [

	| firstW secondW w |
	firstW := self topResizedElement measuredWidth. 
	secondW := self bottomResizedElement measuredWidth. 
	self measuredExtent: (firstW max: secondW) @ self thickness.
	w := self resizedElementWeightFromWidth: self firstResizedElement measuredHeight.
	(self firstResizedElement constraints linear weight closeTo: w) ifFalse: [
		self firstResizedElement constraintsDo: [ :c | c linear weight: w ] ].
	self weight: w.
	w := self resizedElementWeightFromWidth: self secondResizedElement measuredHeight.
	(self secondResizedElement constraints linear weight closeTo: w) ifFalse: [
		self secondResizedElement constraintsDo: [ :c | c linear weight: w ] ]
]

{ #category : #skin }
ToDivider >> newRawSkin [

	^ ToDividerSkin new
]

{ #category : #layout }
ToDivider >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	self canApplyLayoutOnPanes ifFalse: [ ^ self ].
	self isHorizontal
		ifTrue: [
		self layoutInVerticalPaneWithContext: aBlElementBoundsUpdateContext ]
		ifFalse: [
			self layoutInHorizontalPaneWithContext:
				aBlElementBoundsUpdateContext ].
	super onLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
ToDivider >> onMeasure: anExtentMeasurementSpec [


	super onMeasure: anExtentMeasurementSpec.
	self canApplyLayoutOnPanes ifFalse: [ ^ self ].

	self isHorizontal
		ifTrue: [ self measureInVerticalPane: anExtentMeasurementSpec]
		ifFalse: [ self measureInHorizontalPane: anExtentMeasurementSpec ].
	

	
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
ToDivider >> weight [

	^ self constraints linear weight
]

{ #category : #accessing }
ToDivider >> weight: aFloat [

	self constraints linear weight: aFloat
]
