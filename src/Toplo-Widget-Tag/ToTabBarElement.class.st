Class {
	#name : #ToTabBarElement,
	#superclass : #ToCheckableBarElement,
	#instVars : [
		'parentTabsElement'
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
