Class {
	#name : #ToButtonState,
	#superclass : #Object,
	#instVars : [
		'name',
		'next',
		'buttonStencil',
		'beginAnimation',
		'endAnimation'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #processing }
ToButtonState >> applyOn: aButton [

	self exitOn: aButton
]

{ #category : #accessing }
ToButtonState >> beginAnimation: anAnimation [

	beginAnimation := anAnimation
]

{ #category : #accessing }
ToButtonState >> buttonStencil: aBlock [

	buttonStencil := aBlock
]

{ #category : #accessing }
ToButtonState >> endAnimation: anAnimation [

	endAnimation := anAnimation
]

{ #category : #processing }
ToButtonState >> enterOn: aButton [

	beginAnimation ifNotNil: [ :anim | aButton addAnimation: anim value ]
]

{ #category : #processing }
ToButtonState >> exitOn: aButton [

	self exitOn: aButton nextState: next
]

{ #category : #processing }
ToButtonState >> exitOn: aButton nextState: aState [

	endAnimation
		ifNil: [ aState startOn: aButton ]
		ifNotNil: [ :animStencyl | 
			| anim |
			anim := animStencyl value.
			anim onFinishedDo: [ aState startOn: aButton ].
			aButton addAnimation: anim ]
]

{ #category : #accessing }
ToButtonState >> name [

	^ name
]

{ #category : #accessing }
ToButtonState >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToButtonState >> next [

	^ next
]

{ #category : #accessing }
ToButtonState >> next: anEngineStep [

	next := anEngineStep
]

{ #category : #processing }
ToButtonState >> startOn: aButton [

	buttonStencil value: aButton.
	self enterOn: aButton
]
