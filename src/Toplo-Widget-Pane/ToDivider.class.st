Class {
	#name : #ToDivider,
	#superclass : #ToElement,
	#instVars : [
		'thickness',
		'pane',
		'firstTarget',
		'secondTarget',
		'hgap'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'instance creation' }
ToDivider class >> between: aFirstElement and: aSecondElement in: aPane [

	^ self basicNew
		  pane: aPane;
		  firstTarget: aFirstElement;
		  secondTarget: aSecondElement;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
ToDivider class >> new [

	^ self error: 'Use between:and:in'
]

{ #category : #accessing }
ToDivider >> bottomTarget [

	^ self topTarget == self firstTarget ifTrue: [ self secondTarget  ] ifFalse: [ self firstTarget ]
]

{ #category : #initialization }
ToDivider >> defaultBackground [

	^ Color veryLightGray alpha: 0.1
]

{ #category : #initialization }
ToDivider >> defaultBorder [

	^ Color veryLightGray alpha: 0.3
]

{ #category : #initialization }
ToDivider >> defaultEventHandler [ 

	^ ToDividerEventHandler new
]

{ #category : #initialization }
ToDivider >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 2
]

{ #category : #'t - widget - initialization' }
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

{ #category : #accessing }
ToDivider >> firstTarget [

	^ firstTarget
]

{ #category : #accessing }
ToDivider >> firstTarget: anElement [

	firstTarget := anElement
]

{ #category : #accessing }
ToDivider >> hoveredBackground [

	^ Color veryLightGray alpha: 0.3
]

{ #category : #accessing }
ToDivider >> hoveredBorder [

	^ Color veryLightGray alpha: 0.4
]

{ #category : #initialization }
ToDivider >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self addEventHandler: self defaultEventHandler 
]

{ #category : #skin }
ToDivider >> installRawStyle [ 

	super installRawStyle.
	self thickness: self defaultThickness.
	self geometry: self defaultGeometry.
	self margin: self defaultMargins.
	self padding: self defaultPadding
]

{ #category : #testing }
ToDivider >> isHorizontal [

	^ self pane isVertical
]

{ #category : #testing }
ToDivider >> isVertical [

	^ self isHorizontal not
]

{ #category : #layout }
ToDivider >> layoutInHorizontalPane [

	| firstY secondY gap firstX secondX position |
	
	firstX := self leftTarget measuredBounds inParent right + self leftTarget constraints margin right.
	secondX := self rightTarget measuredBounds inParent left - self rightTarget constraints margin left.
	
	firstY := self leftTarget measuredBounds inParent top + self leftTarget constraints margin top.
	secondY := self rightTarget measuredBounds inParent top + self rightTarget constraints margin top.
	gap := (((secondX - firstX)  - (self thickness )) / 2).
	position := (firstX + gap) @ (firstY min: secondY).
	
	self constraints position: position.
	self measuredBounds position: position.
	
	


]

{ #category : #layout }
ToDivider >> layoutInVerticalPane [

	| firstY secondY gap firstX secondX x position |
	
	firstY := self topTarget bounds bottom + self topTarget constraints margin bottom.
	secondY := self bottomTarget bounds top - self bottomTarget constraints margin bottom.

	firstX := self topTarget bounds left "+ self topTarget constraints margin left".
	secondX := self bottomTarget bounds left "+ self bottomTarget constraints margin left".

	gap := (secondY - firstY / 2) - (self thickness / 2).
	x := self pane direction isLeftToRight
		     ifTrue: [ firstX max: secondX ]
		     ifFalse: [ firstX min: secondX ].
	
	position := x @ firstY + gap.
	self constraints position: position.
	self measuredBounds position: position
]

{ #category : #accessing }
ToDivider >> leftTarget [

	^ (self firstTarget bounds left < self secondTarget bounds left) ifTrue: [ self firstTarget  ] ifFalse: [ self secondTarget  ]
]

{ #category : #layout }
ToDivider >> measureInHorizontalPane [

	| firstH secondH w |
	
	firstH := self topTarget measuredBounds height "- (self topTarget constraints margin top + self topTarget constraints margin bottom)".
	secondH := self bottomTarget measuredBounds height "- (self bottomTarget constraints margin top + self bottomTarget constraints margin bottom)".
	
	self measuredExtent: self thickness @ (firstH max: secondH).	
	w := self weightFromWidth: self firstTarget measuredWidth.
	self firstTarget constraints linear weight: w.
	w := self weightFromWidth: self secondTarget measuredWidth.
	self secondTarget constraints linear weight: w
]

{ #category : #layout }
ToDivider >> measureInVerticalPane [

	| firstW secondW w |
	
	firstW := self topTarget measuredWidth "- (self topTarget constraints margin left + self topTarget constraints margin right)".
	secondW := self bottomTarget measuredWidth "- (self bottomTarget constraints margin left + self bottomTarget constraints margin right)".

	self measuredExtent: (firstW max: secondW) @ self thickness.
	w := self weightFromWidth: self firstTarget measuredHeight.
	self firstTarget constraints linear weight: w.
	w := self weightFromWidth: self secondTarget measuredHeight.
	self secondTarget constraints linear weight: w
]

{ #category : #layout }
ToDivider >> onLayout: aBounds context: aBlElementBoundsUpdateContext [


	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self isHorizontal
		ifTrue: [ self layoutInVerticalPane ]
		ifFalse: [ self layoutInHorizontalPane ]
]

{ #category : #layout }
ToDivider >> onMeasure: anExtentMeasurementSpec [

	super onMeasure: anExtentMeasurementSpec.
	self isHorizontal
		ifTrue: [ self measureInVerticalPane ]
		ifFalse: [ self measureInHorizontalPane ]
]

{ #category : #accessing }
ToDivider >> pane [

	^ pane
]

{ #category : #accessing }
ToDivider >> pane: aPane [

	pane := aPane
]

{ #category : #accessing }
ToDivider >> pressedBackground [

	^ Color veryLightGray alpha: 0.6
]

{ #category : #accessing }
ToDivider >> pressedBorder [

	^ Color veryLightGray alpha: 0.6
]

{ #category : #skin }
ToDivider >> rawSkin [

	^ ToDividerSkin new
]

{ #category : #accessing }
ToDivider >> resizerCursor [

	^ self isHorizontal
		  ifTrue: [ BlCursor resizeTop ]
		  ifFalse: [ BlCursor resizeRight ]
]

{ #category : #accessing }
ToDivider >> rightTarget [

	^ self leftTarget == self firstTarget ifTrue: [ self secondTarget  ] ifFalse: [ self firstTarget ]
]

{ #category : #accessing }
ToDivider >> secondTarget [

	^ secondTarget
]

{ #category : #accessing }
ToDivider >> secondTarget: anElement [

	secondTarget := anElement
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
ToDivider >> topTarget [

	^ (self firstTarget bounds top < self secondTarget bounds top) ifTrue: [ self firstTarget  ] ifFalse: [ self secondTarget  ]
]

{ #category : #accessing }
ToDivider >> weightFromWidth: aWidth [

	self pane width isZero ifTrue: [ ^ 1 ].
	^ aWidth / self pane width
]
