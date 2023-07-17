Class {
	#name : #ToElementStateDep,
	#superclass : #ToCompanion,
	#instVars : [
		'name',
		'next',
		'counter'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToElementStateDep >> counter [

	^ counter ifNil: [ counter := 0 ]
]

{ #category : #accessing }
ToElementStateDep >> counter: aNumber [

	counter := aNumber
]

{ #category : #processing }
ToElementStateDep >> enterOn: aWidget previousState: aPreviousState [

	self fireEvent: (ToEnterStateEvent new
			 widget: aWidget;
			 state: self;
			 previousState: aPreviousState;
			 yourself).
]

{ #category : #processing }
ToElementStateDep >> exitOn: aWidget nextState: aState [

	self fireEvent: (ToExitStateEvent new
			 widget: aWidget;
			 state: self;
			 nextState: aState;
			 yourself).

	aState enterOn: aWidget previousState: self
]

{ #category : #accessing }
ToElementStateDep >> name [

	^ name
]

{ #category : #accessing }
ToElementStateDep >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToElementStateDep >> next [

	^ next
]

{ #category : #accessing }
ToElementStateDep >> next: aWidgetState [

	next := aWidgetState
]

{ #category : #accessing }
ToElementStateDep >> whenEnterDo: aBlock [

	self when: ToEnterStateEvent do: [ :ann | aBlock cull: ann ]
]

{ #category : #accessing }
ToElementStateDep >> whenExitDo: aBlock [

	self when: ToExitStateEvent do: [ :ann | aBlock cull: ann ]
]
