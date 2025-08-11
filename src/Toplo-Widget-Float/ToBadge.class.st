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
ToBadge class >> initializeRawToploTheme: aTheme [

	<toploThemeInstallerFor: #ToTheme>
	aTheme addTokenNamed: #'badge-min-width' withValue: 20.
	aTheme addTokenNamed: #'badge-background' withValue: Color red.
	aTheme
		addTokenNamed: #'badge-geometry'
		withValue: (BlRoundedRectangleGeometry cornerRadius: 10).
	aTheme addTokenNamed: #'badge-font-size' withValue: 12.
	aTheme addTokenNamed: #'badge-text-foreground' withValue: Color white.
	aTheme addTokenNamed: #'badge-offset' withValue: 10 @ -10
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
	self minWidth: (self valueOfTokenNamed: #'badge-min-width').
	self background: (self valueOfTokenNamed: #'badge-background').	
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
