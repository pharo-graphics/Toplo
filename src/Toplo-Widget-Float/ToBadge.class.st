Class {
	#name : #ToBadge,
	#superclass : #ToFloatElement,
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

{ #category : #initialization }
ToBadge >> defaultOffset [

	^ 8 @ -8
]

{ #category : #initialization }
ToBadge >> initialize [

	super initialize.
	innerElement padding: (BlInsets all: 2).
	self padding: (BlInsets all: 3)
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
