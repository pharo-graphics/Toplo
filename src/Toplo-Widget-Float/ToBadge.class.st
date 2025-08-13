Class {
	#name : #ToBadge,
	#superclass : #ToAnchoredElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadge class >> initializeRawToploTheme: aTheme [

	<toploThemeInstallerFor: #ToTheme>
	aTheme addTokenNamed: #'badge-min-width' withValue: 16.
	aTheme addTokenNamed: #'badge-background' withValue: Color red.
	aTheme addTokenNamed: #'badge-font-size' withValue: 12.
	aTheme addTokenNamed: #'badge-text-foreground' withValue: Color white.
	aTheme addTokenNamed: #'badge-offset' withValue: 10 @ -10
]

{ #category : #configuration }
ToBadge >> applyConfiguration [

	super applyConfiguration.

	self whenLayoutedDoOnce: [
			self geometry: (BlRoundedRectangleGeometry cornerRadius:
					 self measuredHeight - self margin height / 2).
			innerElement geometry: (BlRoundedRectangleGeometry cornerRadius:
					 innerElement measuredHeight - innerElement margin height / 2) ]
]

{ #category : #initialization }
ToBadge >> defaultOffset [

	^ 8 @ -8
]

{ #category : #initialization }
ToBadge >> defaultPlacement [ 

	^ ToAnchoredAtTopRight new
]

{ #category : #initialization }
ToBadge >> initialize [

	super initialize.
	innerElement padding: (BlInsets horizontal: 4).
	self padding: (BlInsets all: 2)
]

{ #category : #skin }
ToBadge >> installRawStyle [

	super installRawStyle.
	innerElement minWidth: (self valueOfTokenNamed: #'badge-min-width').
	innerElement background: (self valueOfTokenNamed: #'badge-background').	
	self background: (self valueOfTokenNamed: #'background-color').
	self addTokenNamed: #'font-size' withValue: (self valueOfTokenNamed: #'badge-font-size').
	self addTokenNamed: #'color-text' withValue: (self valueOfTokenNamed: #'badge-text-foreground').
	self offset: (self valueOfTokenNamed: #'badge-offset').
]
