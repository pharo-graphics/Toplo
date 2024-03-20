Class {
	#name : #ToSelectTextField,
	#superclass : #ToTextField,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #accessing }
ToSelectTextField >> headerNodeBefore [

	| holders |
	" the strategy must be a multiple one "
	holders := self select headerNodeContainer headerNodeHolders.
	holders ifNotEmpty: [
		^ holders last node ].
	^ nil
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

{ #category : #accessing }
ToSelectTextField >> select [

	^ select
]

{ #category : #accessing }
ToSelectTextField >> select: aSelect [

	select := aSelect
]
