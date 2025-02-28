Class {
	#name : #ToTabBarElement,
	#superclass : #ToCheckableBarElement,
	#instVars : [
		'withCloseButton'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - triplet element - configuration' }
ToTabBarElement >> applyInnerConfiguration [ 

	super applyInnerConfiguration.
	" need to renew the nodes item skin because the foreground 
	of a selected label can be different according to the #isWrapping property  "
	self nodesDo: [ :node | node item requestNewSkin ]
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

"	theVisibleNodes do: [ :n | n visibility: BlVisibility visible ].
	theInvisibleNodes do: [ :n | n visibility: BlVisibility hidden ]"
]

{ #category : #accessing }
ToTabBarElement >> withCloseButton [

	^ withCloseButton ifNil: [ withCloseButton := false ]
]

{ #category : #accessing }
ToTabBarElement >> withCloseButton: aBoolean [

	withCloseButton := aBoolean
]
