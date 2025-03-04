Class {
	#name : #ToTabBarElement,
	#superclass : #ToCheckableBarElement,
	#instVars : [
		'invisibleNodes',
		'visibleNodes'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #configuration }
ToTabBarElement >> configureLayout [

	super configureLayout.
	"self isScrolling
		ifTrue: [ self enableScrolledEvent ]
		ifFalse: [ self disableScrolledEvent ]."
	" need to renew the nodes item skin because the foreground 
	of a selected label can be different according to the #isWrapping property  "
	self nodesDo: [ :n |
		n item requestNewSkin ]
]

{ #category : #'t - bar element' }
ToTabBarElement >> defaultInnerElement [

	^ ToTabInnerBarElement onBarElement: self
]

{ #category : #'t - item list - accessing' }
ToTabBarElement >> defaultNodeManagerClass [

	^ ToTabNodeManager
]

{ #category : #accessing }
ToTabBarElement >> invisibleNodes [

	^ invisibleNodes ifNil: [ invisibleNodes := #() ]
]

{ #category : #skin }
ToTabBarElement >> newRawSkin [ 

	^ ToTabBarElementSkin new
]

{ #category : #accessing }
ToTabBarElement >> nodeMenu [

	^ self userData at: #nodeMenu ifAbsent: [  ]
]

{ #category : #'t - bar element' }
ToTabBarElement >> onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes [

	(theInvisibleNodes = self invisibleNodes and: [
		 theVisibleNodes = self visibleNodes ]) ifTrue: [ ^ self ].
	invisibleNodes := theInvisibleNodes asArray.
	visibleNodes := theVisibleNodes asArray.
	self requestNewSkin.
	self nodeMenu ifNil: [ ^ self ].
	self nodeMenu requestNewSkin
]

{ #category : #accessing }
ToTabBarElement >> visibleNodes [

	^ visibleNodes ifNil: [ visibleNodes := #() ]
]
