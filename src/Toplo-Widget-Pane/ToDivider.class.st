Class {
	#name : #ToDivider,
	#superclass : #ToElement,
	#instVars : [
		'thickness'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

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


]

{ #category : #layout }
ToDivider >> layoutInVerticalPane [


]

{ #category : #layout }
ToDivider >> measureInHorizontalPane [


]

{ #category : #layout }
ToDivider >> measureInVerticalPane [


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
ToDivider >> thickness [

	^ thickness ifNil: [ thickness := self defaultThickness ]
]

{ #category : #accessing }
ToDivider >> thickness: aNumber [

	thickness := aNumber.
	self requestLayout
]
