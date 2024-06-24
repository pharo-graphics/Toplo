Class {
	#name : #ToDivider,
	#superclass : #ToElement,
	#instVars : [
		'thickness',
		'hasBeenLayouted',
		'container',
		'firstResizedElement',
		'secondResizedElement'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'instance creation' }
ToDivider class >> between: aFirstElement and: aSecondElement in: aPane [

	^ self basicNew
		  container: aPane;
		  firstResizedElement: aFirstElement;
		  secondResizedElement: aSecondElement;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
ToDivider class >> new [

	^ self error: 'Use between:and:in'
]

{ #category : #accessing }
ToDivider >> bottomResizedElement [

	^ self topResizedElement = self firstResizedElement
		  ifTrue: [ self secondResizedElement ]
		  ifFalse: [ self firstResizedElement ]
]

{ #category : #layout }
ToDivider >> canApplyLayoutOnPanes [

	^ self isAttachedToSceneGraph and: [ self container width isZero not ]
]

{ #category : #layout }
ToDivider >> checkFirstLayout [

	hasBeenLayouted ifFalse: [
		| w |
		w := self constraints linear weight.
		w ~= 1 ifTrue: [ 
			self firstResizedElement constraints linear weight: w ] ].
	hasBeenLayouted := true
]

{ #category : #accessing }
ToDivider >> container [

	^ container
]

{ #category : #accessing }
ToDivider >> container: aPane [

	container := aPane
]

{ #category : #initialization }
ToDivider >> defaultBackground [

	^ Color transparent
]

{ #category : #initialization }
ToDivider >> defaultBorder [

	^ BlBorder empty
]

{ #category : #initialization }
ToDivider >> defaultEventHandler [ 

	^ ToDividerEventHandler new
]

{ #category : #initialization }
ToDivider >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 2
]

{ #category : #initialization }
ToDivider >> defaultLayout [

	^ BlBasicLayout new 
]

{ #category : #initialization }
ToDivider >> defaultMargins [ 

	^ BlInsets empty
]

{ #category : #initialization }
ToDivider >> defaultPadding [

	^ BlInsets empty
]

{ #category : #initialization }
ToDivider >> defaultThickness [

	^ 3
]

{ #category : #skin }
ToDivider >> draggedBackground [

	^ Color veryLightGray alpha: 0.6
]

{ #category : #accessing }
ToDivider >> firstResizedElement [

	^ firstResizedElement
]

{ #category : #accessing }
ToDivider >> firstResizedElement: anElement [

	firstResizedElement := anElement
]

{ #category : #skin }
ToDivider >> hoveredBackground [

	^ Color veryLightGray alpha: 0.3
]

{ #category : #skin }
ToDivider >> hoveredBorder [

	^ self defaultBorder
]

{ #category : #initialization }
ToDivider >> initialize [

	super initialize.
	hasBeenLayouted := false.
	self thickness: self defaultThickness.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self addEventHandler: self defaultEventHandler 
]

{ #category : #skin }
ToDivider >> installRawStyle [ 

	super installRawStyle.
	self geometry: self defaultGeometry.
	self margin: self defaultMargins.
	self padding: self defaultPadding

]

{ #category : #testing }
ToDivider >> isHorizontal [

	^ self container isVertical
]

{ #category : #testing }
ToDivider >> isVertical [

	^ self isHorizontal not
]

{ #category : #layout }
ToDivider >> layoutInHorizontalPane [

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
	x := self container direction isLeftToRight
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
	firstH := self topResizedElement measuredBounds height. "- (self topTarget constraints margin top + self topTarget constraints margin bottom)"
	secondH := self bottomResizedElement measuredBounds height. "- (self bottomTarget constraints margin top + self bottomTarget constraints margin bottom)"
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
	firstW := self topResizedElement measuredWidth. "- (self topTarget constraints margin left + self topTarget constraints margin right)"
	secondW := self bottomResizedElement measuredWidth. "- (self bottomTarget constraints margin left + self bottomTarget constraints margin right)"
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
	self checkFirstLayout.
	self isHorizontal
		ifTrue: [ self layoutInVerticalPaneWithContext: aBlElementBoundsUpdateContext ]
		ifFalse: [ self layoutInHorizontalPaneWithContext: aBlElementBoundsUpdateContext ].
	super onLayout: aBounds context: aBlElementBoundsUpdateContext.

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
ToDivider >> pane [

	self
		deprecated: 'Please use #container instead'
		transformWith: '`@rcvr pane' -> '`@rcvr container'.
	^ self container
]

{ #category : #accessing }
ToDivider >> pane: aPane [

	self
		deprecated: 'Please use #container: instead'
		transformWith: '`@rcvr pane: `@arg' -> '`@rcvr container: `@arg'.

	self container: aPane
]

{ #category : #skin }
ToDivider >> pressedBackground [

	^ Color veryLightGray alpha: 0.6
]

{ #category : #skin }
ToDivider >> pressedBorder [

	^ self defaultBorder
]

{ #category : #accessing }
ToDivider >> resizedElementWeightFromWidth: aWidth [

	^ aWidth / self container width
]

{ #category : #skin }
ToDivider >> resizerCursor [

	^ self isHorizontal
		  ifTrue: [ Cursor resizeTop ]
		  ifFalse: [ Cursor resizeRight ]
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

	^ thickness
]

{ #category : #accessing }
ToDivider >> thickness: aNumber [

	thickness := aNumber
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
