Class {
	#name : #ToBadge,
	#superclass : #ToElement,
	#instVars : [
		'label',
		'offset'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadge class >> initializeToploThemeFor: aTheme [

	<toploThemeInstaller>
	aTheme addTokenNamed: #'badge-size' withValue: 16 asPoint.
	aTheme addTokenNamed: #'badge-background' withValue: Color red.
	aTheme addTokenNamed: #'badge-geometry' withValue: (BlRoundedRectangleGeometry  cornerRadius: 8).
	aTheme addTokenNamed: #'badge-font-size' withValue: 10.
	aTheme addTokenNamed: #'badge-text-foreground' withValue: Color white.
	aTheme addTokenNamed: #'badge-lag' withValue: 8
]

{ #category : #initialization }
ToBadge >> defaultElevation [

	^ BlRelativeElevation elevation: 1
]

{ #category : #initialization }
ToBadge >> initialize [

	super initialize.
	self focusability: BlFocusability none.
	self elevation: self defaultElevation.
	label := ToLabel text: ''.
	label bold.
	label constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	self addChild: label.
	self fitContent.
	self minWidth: 16.
	self padding: (BlInsets all: 2).
	self setUpAnchors.
	self tooltipBuilder: [ :window :request |
			window root addChild: ((ToLabel text: label text copy)
					 defaultRawSkin: ToLabelInTooltipSkin new;
					 yourself) ]
]

{ #category : #skin }
ToBadge >> installRawStyle [

	super installRawStyle.
	"self extent: (self valueOfTokenNamed: #'badge-size')."
	self background: (self valueOfTokenNamed: #'badge-background').	
	self geometry: (self valueOfTokenNamed: #'badge-geometry').
	self addTokenNamed: #'font-size' withValue: (self valueOfTokenNamed: #'badge-font-size').
	self addTokenNamed: #'color-text' withValue: (self valueOfTokenNamed: #'badge-text-foreground').
]

{ #category : #accessing }
ToBadge >> offset [

	^ offset ifNil: [ offset := 8 @ -8 ]
]

{ #category : #accessing }
ToBadge >> offset: aPoint [

	offset := aPoint.
	self setUpAnchors
]

{ #category : #initialization }
ToBadge >> setUpAnchors [

	self constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors removeAll.
			c anchors add: (c anchors topRightAnchor on:
					 c anchors parent topRightAnchor + self offset) ]
]
