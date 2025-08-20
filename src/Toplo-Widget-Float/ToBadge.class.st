Class {
	#name : #ToBadge,
	#superclass : #ToAnchoredElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadge class >> initializeRawToploTheme: aTheme [

	<toploThemeInstallerFor: #ToTheme>
	aTheme addTokenNamed: #'badge-horizontal-gap' withValue: 4.
	aTheme addTokenNamed: #'badge-font-size' withValue: 12.
	aTheme addTokenNamed: #'badge-text-foreground' withValue: Color white
]

{ #category : #'attaching  / detaching' }
ToBadge >> attachToElement: anElement [

	anElement addEventHandler: (ToBadgeableEventHandler new
			 badge: self;
			 yourself)
]

{ #category : #initialization }
ToBadge >> defaultInnerBackground [

	^ Color red
]

{ #category : #initialization }
ToBadge >> defaultInnerMinWidth [

	^ 16
]

{ #category : #initialization }
ToBadge >> defaultOffset [

	^ 10 @ 10
]

{ #category : #initialization }
ToBadge >> defaultPlacement [ 

	^ ToAnchoredAtTopRight new
]

{ #category : #'attaching  / detaching' }
ToBadge >> detachFromElement [

	self referenceElement dispatchEvent: (ToBadgeDetachedEvent new
			 badge: self;
			 yourself)
]

{ #category : #initialization }
ToBadge >> initialize [

	super initialize.
	innerElement minWidth: self defaultInnerMinWidth 
]

{ #category : #skin }
ToBadge >> installRawStyle [

	super installRawStyle.
	innerElement padding: (BlInsets horizontal:
			 (self valueOfTokenNamed: #'badge-horizontal-gap')).
	self
		addTokenNamed: #'font-size'
		withValue: (self valueOfTokenNamed: #'badge-font-size').
	self
		addTokenNamed: #'color-text'
		withValue: (self valueOfTokenNamed: #'badge-text-foreground')
]

{ #category : #'attaching  / detaching' }
ToBadge >> isAttached [

	^ self referenceElement notNil
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
