Class {
	#name : #ToWidgetState,
	#superclass : #Object,
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
	#instVars : [
		'name',
		'next',
		'enterAnimationStencyl',
		'exitAnimationStencyl'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToWidgetState >> enterAnimationStencyl: anAnimation [

	enterAnimationStencyl := anAnimation
]

{ #category : #processing }
ToWidgetState >> enterOn: aWidget previousState: aPreviousState [

	self announce: (ToEnterStateAnnouncement new
			 widget: aWidget;
			 previousState: aPreviousState;
			 yourself).
	enterAnimationStencyl ifNotNil: [ :animStencyl | 
		| anim |
		anim := animStencyl cull: aWidget.
		aWidget addAnimation: anim ]
]

{ #category : #accessing }
ToWidgetState >> exitAnimationStencyl: anAnimation [

	exitAnimationStencyl := anAnimation
]

{ #category : #processing }
ToWidgetState >> exitOn: aWidget nextState: aState [

	self announce: (ToExitStateAnnouncement new
			 widget: aWidget;
			 nextState: aState;
			 yourself).

	exitAnimationStencyl
		ifNil: [ aState enterOn: aWidget previousState: self ]
		ifNotNil: [ :animStencyl | 
			| anim |
			anim := animStencyl cull: aWidget.
			anim onFinishedDo: [ aState enterOn: aWidget previousState: self ].
			aWidget addAnimation: anim ]
]

{ #category : #accessing }
ToWidgetState >> name [

	^ name
]

{ #category : #accessing }
ToWidgetState >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToWidgetState >> next [

	^ next
]

{ #category : #accessing }
ToWidgetState >> next: aWidgetState [

	next := aWidgetState
]

{ #category : #accessing }
ToWidgetState >> whenEnterDo: aBlock [

	self whenAnnouncement: ToEnterStateAnnouncement do: [ :ann | aBlock cull: ann widget cull: ann widget currentState cull: ann previousState ].
]

{ #category : #accessing }
ToWidgetState >> whenExitDo: aBlock [

	self whenAnnouncement: ToExitStateAnnouncement do: [ :ann | aBlock cull: ann widget cull: ann widget currentState cull: ann nextState ].
]
