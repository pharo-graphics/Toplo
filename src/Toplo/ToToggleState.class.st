Class {
	#name : #ToToggleState,
	#superclass : #Object,
	#instVars : [
		'name',
		'next',
		'buttonStencil',
		'beginAnimation',
		'endAnimation'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #processing }
ToToggleState >> applyStartStateOn: aButton [

	buttonStencil value: aButton.
	self enterOn: aButton
]

{ #category : #processing }
ToToggleState >> applyStateTransitionOn: aButton [

	self exitOn: aButton
]

{ #category : #accessing }
ToToggleState >> beginAnimation: anAnimation [

	beginAnimation := anAnimation
]

{ #category : #accessing }
ToToggleState >> buttonStencil: aBlock [

	buttonStencil := aBlock
]

{ #category : #accessing }
ToToggleState >> endAnimation: anAnimation [

	endAnimation := anAnimation
]

{ #category : #processing }
ToToggleState >> enterOn: aButton [

	beginAnimation ifNotNil: [ :anim | aButton addAnimation: anim value ]
]

{ #category : #processing }
ToToggleState >> exitOn: aButton [

	self exitOn: aButton nextState: next
]

{ #category : #processing }
ToToggleState >> exitOn: aButton nextState: aState [

	endAnimation
		ifNil: [ aState applyStartStateOn: aButton ]
		ifNotNil: [ :animStencyl | 
			| anim |
			anim := animStencyl value.
			anim onFinishedDo: [ aState applyStartStateOn: aButton ].
			aButton addAnimation: anim ]
]

{ #category : #accessing }
ToToggleState >> name [

	^ name
]

{ #category : #accessing }
ToToggleState >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToToggleState >> next [

	^ next
]

{ #category : #accessing }
ToToggleState >> next: anEngineStep [

	next := anEngineStep
]
