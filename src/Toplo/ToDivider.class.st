Class {
	#name : #ToDivider,
	#superclass : #ToElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'thickness',
		'pane',
		'firstTarget',
		'secondTarget'
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

	^ (self pane isLeftToRight or: [ self pane isVertical ]) 
		  ifTrue: [ self secondTarget ]
		  ifFalse: [ self firstTarget ]
]

{ #category : #'t - initialization dresser' }
ToDivider >> defaultDresser [

	^ ToDividerDresser new
]

{ #category : #'t - initialization' }
ToDivider >> defaultLayout [

	^ BlBasicLayout new 
]

{ #category : #accessing }
ToDivider >> firstTarget [

	^ firstTarget
]

{ #category : #accessing }
ToDivider >> firstTarget: anElement [

	firstTarget := anElement
]

{ #category : #initialization }
ToDivider >> initialize [

	super initialize.
	self initializeDresser.
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
		
	firstX := self leftTarget bounds right.
	secondX := self rightTarget bounds left.
	firstY := self leftTarget bounds top.
	secondY := self rightTarget bounds top.
	gap := (((secondX - firstX)  - (self thickness )) / 2) rounded.
	position := (firstX + gap) @ (firstY min: secondY).
	self constraints position: position.
	self measuredBounds position: position.
	
	


]

{ #category : #layout }
ToDivider >> layoutInVerticalPane [

	| firstY secondY gap firstX secondX x position |
	
	firstY := self topTarget bounds bottom.
	secondY := self bottomTarget bounds top.

	firstX := self topTarget bounds left.
	secondX := self bottomTarget bounds left.

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

	^ self pane isLeftToRight ifTrue: [  self firstTarget ] ifFalse: [ self secondTarget ]
]

{ #category : #layout }
ToDivider >> measureInHorizontalPane [

	| firstH secondH w |
	
	firstH := self topTarget measuredBounds height.
	secondH := self bottomTarget measuredBounds height.
	
	self measuredExtent: self thickness @ (firstH max: secondH).	
	w := self weightFromWidth: self firstTarget measuredWidth.
	self firstTarget constraints linear weight: w.
	w := self weightFromWidth: self secondTarget measuredWidth.
	self secondTarget constraints linear weight: w
]

{ #category : #layout }
ToDivider >> measureInVerticalPane [

	| firstW secondW w |
	
	firstW := self topTarget measuredWidth.
	secondW := self bottomTarget measuredWidth.

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
ToDivider >> rightTarget [

	^ self pane isLeftToRight
		  ifTrue: [ self secondTarget ]
		  ifFalse: [ self firstTarget ]
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

	^ (self pane isLeftToRight or: [ self pane isVertical ]) 
		  ifTrue: [ self firstTarget ]
		  ifFalse: [ self secondTarget ]
]

{ #category : #accessing }
ToDivider >> weightFromWidth: aWidth [

	self pane width isZero ifTrue: [ ^ 1 ].
	^ ((aWidth ) / self pane width) asFloat
]
