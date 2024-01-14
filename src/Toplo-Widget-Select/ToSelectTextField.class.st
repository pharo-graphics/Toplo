Class {
	#name : #ToSelectTextField,
	#superclass : #ToTextField,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectTextField >> initialize [

	super initialize.
	self fitContent.
	self withSaveCapability.
	self withoutEditsFeedback.
	self constraintsDo: [ :c |
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
	self addEditorShortcut: ToSelectTextFieldBackspaceShortcut new
]

{ #category : #skin }
ToSelectTextField >> newRawSkin [ 

	^ ToSelectTextFieldSkin new
]

{ #category : #accessing }
ToSelectTextField >> nodeBefore [

	| holders |
	holders := self select strategy nodeHolders.
	holders size > 0 ifTrue: [
		^ holders last node ].
	^ nil
]

{ #category : #accessing }
ToSelectTextField >> nodeBeforeDo: aBlock [

	self nodeBefore ifNotNil: [ :n | aBlock value: n ]
]

{ #category : #accessing }
ToSelectTextField >> select [

	^ select
]

{ #category : #accessing }
ToSelectTextField >> select: aSelect [

	select := aSelect
]
