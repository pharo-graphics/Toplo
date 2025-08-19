Class {
	#name : #ToBadge,
	#superclass : #ToAnchoredElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadge class >> initializeRawToploTheme: aTheme [

	<toploThemeInstallerFor: #ToTheme>
	aTheme addTokenNamed: #'badge-padding' withValue: (BlInsets all: 2).
	aTheme addTokenNamed: #'badge-horizontal-gap' withValue: 4.
	aTheme addTokenNamed: #'badge-font-size' withValue: 12.
	aTheme addTokenNamed: #'badge-text-foreground' withValue: Color white
]

{ #category : #initialization }
ToBadge >> defaultBackground [

	^ Color red
]

{ #category : #initialization }
ToBadge >> defaultMinWidth [

	^ 16
]

{ #category : #initialization }
ToBadge >> defaultOffset [

	^ 10 @ -10
]

{ #category : #initialization }
ToBadge >> defaultPlacement [ 

	^ ToAnchoredAtTopRight new
]

{ #category : #initialization }
ToBadge >> initialize [

	super initialize.
	innerElement background: self defaultBackground.
	innerElement minWidth: self defaultMinWidth 
]

{ #category : #skin }
ToBadge >> installRawStyle [

	super installRawStyle.
	innerElement padding: (BlInsets horizontal:
			 (self valueOfTokenNamed: #'badge-horizontal-gap')).
	self padding: (self valueOfTokenNamed: #'badge-padding').
	self background: (self valueOfTokenNamed: #'background-color').
	self
		addTokenNamed: #'font-size'
		withValue: (self valueOfTokenNamed: #'badge-font-size').
	self
		addTokenNamed: #'color-text'
		withValue: (self valueOfTokenNamed: #'badge-text-foreground')
]

{ #category : #layout }
ToBadge >> onMeasure: anExtentMeasurementSpec [

	| prevHeight |
	prevHeight := self measuredHeight.
	super onMeasure: anExtentMeasurementSpec.
	prevHeight ~= self measuredHeight ifFalse: [ ^ self ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 self measuredHeight - self margin height / 2).
	innerElement geometry: (BlRoundedRectangleGeometry cornerRadius:
			 innerElement measuredHeight - innerElement margin height / 2)
]
