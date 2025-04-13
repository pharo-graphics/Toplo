Class {
	#name : #ToTabBarElement,
	#superclass : #ToCheckableBarElement,
	#instVars : [
		'atStartSide',
		'parentTabGroupElement'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #configuration }
ToTabBarElement >> applyWidgetConfiguration [ 

	super applyWidgetConfiguration.
	self nodesDo: [ :node | node item requestNewConfiguration ]
]

{ #category : #accessing }
ToTabBarElement >> atStartSide [

	^ atStartSide
]

{ #category : #accessing }
ToTabBarElement >> atStartSide: aBoolean [

	atStartSide = aBoolean ifTrue: [ ^ self ].
	atStartSide := aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item list - accessing' }
ToTabBarElement >> defaultNodeManagerClass [

	^ ToTabNodeManager
]

{ #category : #initialization }
ToTabBarElement >> initialize [ 

	super initialize.
	atStartSide := true.
	"self addEventHandlerOn: ToInfiniteScrollFinishedEvent do: [ :evt | evt traceCr ]"
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

	parentTabGroupElement ifNotNil: [ :p |
		p onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes ]
]

{ #category : #accessing }
ToTabBarElement >> parentTabGroupElement: anObject [

	parentTabGroupElement := anObject
]
