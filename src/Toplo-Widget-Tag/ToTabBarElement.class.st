Class {
	#name : #ToTabBarElement,
	#superclass : #ToCheckableBarElement,
	#instVars : [
		'parentTabsElement',
		'atStartSide'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #configuration }
ToTabBarElement >> applyWidgetConfiguration [

	super applyWidgetConfiguration.
	self refreshAllSelections.
	"self uniformNodeHeight: true.
	self isVertical
		ifTrue: [ self uniformNodeWidth: true ]
		ifFalse: [
		self isWrapping ifFalse: [ self uniformNodeWidth: false ] ]."
	self requestNewSkin
]

{ #category : #accessing }
ToTabBarElement >> atStartSide [

	^ atStartSide
]

{ #category : #accessing }
ToTabBarElement >> atStartSide: aBoolean [

	atStartSide = aBoolean ifTrue: [ ^ self ].
	atStartSide := aBoolean.
	self requestNewConfigurationPass 
]

{ #category : #'t - item list - accessing' }
ToTabBarElement >> defaultNodeManagerClass [

	^ ToTabNodeManager
]

{ #category : #initialization }
ToTabBarElement >> initialize [ 

	super initialize.
	atStartSide := true
]

{ #category : #testing }
ToTabBarElement >> isAtEndSide [ 

	^ self isAtStartSide not
]

{ #category : #testing }
ToTabBarElement >> isAtStartSide [

	^ atStartSide
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
