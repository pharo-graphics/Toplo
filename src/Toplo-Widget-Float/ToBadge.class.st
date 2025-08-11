Class {
	#name : #ToBadge,
	#superclass : #ToElement,
	#instVars : [
		'innerElement',
		'offset',
		'placement'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadge class >> initializeRawToploTheme: aTheme [

	<toploThemeInstallerFor: #ToTheme>
	aTheme addTokenNamed: #'badge-min-width' withValue: 20.
	aTheme addTokenNamed: #'badge-background' withValue: Color red.
	aTheme
		addTokenNamed: #'badge-geometry'
		withValue: (BlRoundedRectangleGeometry cornerRadius: 10).
	aTheme
		addTokenNamed: #'badge-inner-geometry'
		withValue: (BlRoundedRectangleGeometry cornerRadius: 9).
	aTheme addTokenNamed: #'badge-font-size' withValue: 12.
	aTheme addTokenNamed: #'badge-text-foreground' withValue: Color white.
	aTheme addTokenNamed: #'badge-offset' withValue: 14 @ -14
]

{ #category : #configuration }
ToBadge >> applyConfiguration [ 

	super applyConfiguration.
	placement configureBadge: self
]

{ #category : #configuration }
ToBadge >> atBottom [

	self placement: ToBadgeAtBottom new
]

{ #category : #configuration }
ToBadge >> atBottomLeft [

	self placement: ToBadgeAtBottomLeft new
]

{ #category : #configuration }
ToBadge >> atBottomRight [

	self placement: ToBadgeAtBottomRight new
]

{ #category : #configuration }
ToBadge >> atLeft [

	self placement: ToBadgeAtLeft new
]

{ #category : #configuration }
ToBadge >> atRight [

	self placement: ToBadgeAtRight new
]

{ #category : #configuration }
ToBadge >> atTop [

	self placement: ToBadgeAtTop new
]

{ #category : #configuration }
ToBadge >> atTopLeft [

	self placement: ToBadgeAtTopLeft new
]

{ #category : #configuration }
ToBadge >> atTopRight [

	self placement: ToBadgeAtTopRight new
]

{ #category : #accessing }
ToBadge >> builder: aValuable [

	aValuable value: innerElement
]

{ #category : #initialization }
ToBadge >> defaultElevation [

	^ BlRelativeElevation elevation: 1
]

{ #category : #initialization }
ToBadge >> defaultPlacement [

	^ ToBadgeAtTopRight new
]

{ #category : #initialization }
ToBadge >> initialize [

	super initialize.
	innerElement := ToElement new.
	innerElement fitContent.
	innerElement padding: (BlInsets all: 2).
	innerElement constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	self addChild: innerElement.
	self focusability: BlFocusability none.
	self elevation: self defaultElevation.
	self fitContent.
	self padding: (BlInsets all: 3).
	self constraintsDo: [ :c | c ignoreByLayout ].
	placement := self defaultPlacement
]

{ #category : #skin }
ToBadge >> installRawStyle [

	super installRawStyle.
	innerElement minWidth: (self valueOfTokenNamed: #'badge-min-width').
	innerElement background: (self valueOfTokenNamed: #'badge-background').	
	innerElement geometry: (self valueOfTokenNamed: #'badge-inner-geometry').
	self background: (self valueOfTokenNamed: #'background-color').
	self geometry: (self valueOfTokenNamed: #'badge-geometry').
	self addTokenNamed: #'font-size' withValue: (self valueOfTokenNamed: #'badge-font-size').
	self addTokenNamed: #'color-text' withValue: (self valueOfTokenNamed: #'badge-text-foreground').
	self offset: (self valueOfTokenNamed: #'badge-offset').
]

{ #category : #accessing }
ToBadge >> offset [

	^ offset ifNil: [ offset := 8 @ -8 ]
]

{ #category : #accessing }
ToBadge >> offset: aPoint [

	offset := aPoint.
	self requestConfiguration 
]

{ #category : #accessing }
ToBadge >> placement [

	^ placement
]

{ #category : #accessing }
ToBadge >> placement: aPlacement [

	placement := aPlacement.
	self requestConfiguration 
]
