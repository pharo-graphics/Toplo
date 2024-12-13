Class {
	#name : #ToTabBarElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement',
	#classTraits : 'TToBarElement classTrait',
	#instVars : [
		'withCloseButton'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - bar element' }
ToTabBarElement >> configureLayout [

	self isHorizontal
		ifTrue: [ 
			self hMatchParent.
			self vFitContent ]
		ifFalse: [ 
			self vMatchParent.
			self hFitContent ].
	self innerElement configureLayoutIn: self
]

{ #category : #initialization }
ToTabBarElement >> defaultNodeManagerClass [

	^ ToTabNodeManager
]

{ #category : #'t - bar element' }
ToTabBarElement >> haveInvisibleNodes: theInvisibleNodes [

	theInvisibleNodes ifEmpty: [ ^ self ].
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
