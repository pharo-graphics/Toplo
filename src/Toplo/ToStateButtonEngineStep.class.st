Class {
	#name : #ToStateButtonEngineStep,
	#superclass : #Object,
	#instVars : [
		'state',
		'next',
		'enterAnimation',
		'exitAnimation'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'instance creation' }
ToStateButtonEngineStep class >> state: aState transition: aTransition [

	^ self new state: aState transition: aTransition
]

{ #category : #processing }
ToStateButtonEngineStep >> applyOn: aButton [

	self exitOn: aButton
]

{ #category : #accessing }
ToStateButtonEngineStep >> enterAnimation: anAnimation [

	enterAnimation := anAnimation
]

{ #category : #accessing }
ToStateButtonEngineStep >> exitAnimation: anAnimation [

	exitAnimation := anAnimation
]

{ #category : #processing }
ToStateButtonEngineStep >> exitOn: aButton [

	exitAnimation ifNil: [next startOn: aButton] ifNotNil: [ :animStencyl | 
		| anim |
		anim := animStencyl value.
		anim onFinishedDo: [ 
			next startOn: aButton  ].
		aButton addAnimation: anim ]
]

{ #category : #accessing }
ToStateButtonEngineStep >> next [

	^ next
]

{ #category : #accessing }
ToStateButtonEngineStep >> next: anEngineStep [

	next := anEngineStep
]

{ #category : #processing }
ToStateButtonEngineStep >> startOn: aButton [

	state applyOn: aButton.
	enterAnimation ifNotNil: [ :anim | aButton addAnimation: anim value ]
]

{ #category : #accessing }
ToStateButtonEngineStep >> state: aState [

	state := aState
]

{ #category : #initialize }
ToStateButtonEngineStep >> state: aState transition: aTransition [

	self state: aState.
	self enterAnimation: aTransition enterAnimation.
	self exitAnimation: aTransition exitAnimation.
]
