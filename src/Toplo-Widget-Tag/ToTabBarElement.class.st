Class {
	#name : #ToTabBarElement,
	#superclass : #ToCheckableBarElement,
	#instVars : [
		'parentTabsElement',
		'tabPosition'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #configuration }
ToTabBarElement >> applyInnerConfiguration [ 

	super applyInnerConfiguration.
	self requestNewSkin
]

{ #category : #'t - item list - accessing' }
ToTabBarElement >> defaultNodeManagerClass [

	^ ToTabNodeManager
]

{ #category : #initialization }
ToTabBarElement >> defaultTabPosition [

	^ ToTabAtTop new
]

{ #category : #initialization }
ToTabBarElement >> initialize [ 

	super initialize.
	tabPosition := self defaultTabPosition
]

{ #category : #testing }
ToTabBarElement >> isAtBottom [

	^ tabPosition isAtBottom
]

{ #category : #testing }
ToTabBarElement >> isAtLeft [

	^ tabPosition isAtLeft
]

{ #category : #testing }
ToTabBarElement >> isAtRight [

	^ tabPosition isAtRight
]

{ #category : #testing }
ToTabBarElement >> isAtTop [

	^ tabPosition isAtTop
]

{ #category : #skin }
ToTabBarElement >> newRawSkin [ 

	^ ToTabBarElementSkin new
]

{ #category : #'t - bar element' }
ToTabBarElement >> onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes [

	parentTabsElement ifNotNil: [ :p |
		p onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes ]
]

{ #category : #accessing }
ToTabBarElement >> parentTabsElement: anObject [

	parentTabsElement := anObject
]

{ #category : #accessing }
ToTabBarElement >> tabPosition [

	^ tabPosition
]

{ #category : #accessing }
ToTabBarElement >> tabPosition: aTabPosition [

	aTabPosition = tabPosition ifTrue: [ ^ self ].
	tabPosition := aTabPosition.
	self requestInnerConfiguration 
]
