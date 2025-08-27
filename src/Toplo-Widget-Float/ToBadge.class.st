Class {
	#name : #ToBadge,
	#superclass : #ToBaseBadge,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadge class >> initializeRawToploTheme: aTheme [

	<toploThemeInstallerFor: #ToTheme>
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
ToBadge >> initialize [

	super initialize.
	self minWidth: self defaultMinWidth.
	self background: self defaultBackground 
]

{ #category : #skin }
ToBadge >> installRawStyle [

	super installRawStyle.
	self padding: (BlInsets horizontal:
			 (self valueOfTokenNamed: #'badge-horizontal-gap')).
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
			 self measuredHeight - self margin height / 2)
]
