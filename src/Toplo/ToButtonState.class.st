Class {
	#name : #ToButtonState,
	#superclass : #Object,
	#instVars : [
		'name',
		'next',
		'enterAnimation',
		'exitAnimation',
		'stencil'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #processing }
ToButtonState >> applyOn: aButton [

	self exitOn: aButton
]

{ #category : #accessing }
ToButtonState >> enterAnimation: anAnimation [

	enterAnimation := anAnimation
]

{ #category : #processing }
ToButtonState >> enterOn: aButton [

	enterAnimation ifNotNil: [ :anim | aButton addAnimation: anim value ]
]

{ #category : #accessing }
ToButtonState >> exitAnimation: anAnimation [

	exitAnimation := anAnimation
]

{ #category : #processing }
ToButtonState >> exitOn: aButton [

	exitAnimation ifNil: [next startOn: aButton] ifNotNil: [ :animStencyl | 
		| anim |
		anim := animStencyl value.
		anim onFinishedDo: [ 
			next startOn: aButton  ].
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

	stencil value: aButton.
	self enterOn: aButton
]

{ #category : #accessing }
ToButtonState >> stencil: aBlock [

	stencil := aBlock
]
