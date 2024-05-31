Class {
	#name : #ToSelectTextField,
	#superclass : #ToTextField,
	#instVars : [
		'headerNodeContainer'
	],
	#category : #'Toplo-Widget-Select-textInput'
}

{ #category : #accessing }
ToSelectTextField >> headerNodeBefore [

	^ headerNodeContainer nodes ifEmpty: [] ifNotEmpty: [:nodes | nodes last]
]

{ #category : #accessing }
ToSelectTextField >> headerNodeContainer: aHeaderNodeContainer [

	headerNodeContainer := aHeaderNodeContainer 
]

{ #category : #initialization }
ToSelectTextField >> initialize [

	super initialize.
	self fitContent.
	self withSaveCapability.
	self withoutEditsFeedback.
	self constraintsDo: [ :c |
		c frame vertical alignCenter.
		c flow vertical alignCenter.
		c linear vertical alignCenter ]
]

{ #category : #skin }
ToSelectTextField >> newRawSkin [ 

	^ ToSelectTextFieldSkin new
]

{ #category : #accessing }
ToSelectTextField >> nodeBeforeDo: aBlock [

	self headerNodeBefore ifNotNil: [ :n | aBlock value: n ]
]
