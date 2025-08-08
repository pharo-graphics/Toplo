Class {
	#name : #ToBadge,
	#superclass : #ToElement,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadge class >> initializeToploThemeFor: aTheme [

	<toploThemeInstaller>
	aTheme addTokenNamed: #'badge-size' withValue: 16 asPoint.
	aTheme addTokenNamed: #'badge-background' withValue: Color red.
	aTheme addTokenNamed: #'badge-geometry' withValue: BlCircleGeometry new.
	aTheme addTokenNamed: #'badge-font-size' withValue: 10.
	aTheme addTokenNamed: #'badge-text-foreground' withValue: Color white
]

{ #category : #initialization }
ToBadge >> initialize [

	super initialize.
	self focusability: BlFocusability none.
	self elevation: (BlRelativeElevation elevation: 10000).
	label := ToLabel text: ''.
	label bold.
	label constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	self addChild: label.
	self constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors add:
				(c anchors topRightAnchor on: c anchors parent topRightAnchor) ]
]

{ #category : #skin }
ToBadge >> installRawStyle [

	super installRawStyle.
	self extent: (self valueOfTokenNamed: #'badge-size').
	self background: (self valueOfTokenNamed: #'badge-background').	
	self geometry: (self valueOfTokenNamed: #'badge-geometry').
	self addTokenNamed: #'font-size' withValue: (self valueOfTokenNamed: #'badge-font-size').
	self addTokenNamed: #'color-text' withValue: (self valueOfTokenNamed: #'badge-text-foreground').
]
