Class {
	#name : #ToTabBarElement,
	#superclass : #ToCheckableBarElement,
	#instVars : [
		'withCloseButton'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - item list - accessing' }
ToTabBarElement >> defaultNodeManagerClass [

	^ ToTabNodeManager
]

{ #category : #skin }
ToTabBarElement >> newRawSkin [ 

	^ ToTabBarElementSkin new
]

{ #category : #'t - bar element' }
ToTabBarElement >> onInvisibleNodes: theInvisibleNodes [

	nodeWrapping ifTrue: [ ^ self ].
	nodeScrolling ifTrue: [ ^ self ].
	nodeAutoDistribution ifFalse: [ ^ self ].
	" ok the node menu can be shown "
]

{ #category : #accessing }
ToTabBarElement >> withCloseButton [

	^ withCloseButton ifNil: [ withCloseButton := false ]
]

{ #category : #accessing }
ToTabBarElement >> withCloseButton: aBoolean [

	withCloseButton := aBoolean
]
