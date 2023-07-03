Class {
	#name : #ToElementState,
	#superclass : #ToCompanion,
	#instVars : [
		'name',
		'next',
		'counter'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToElementState >> counter [

	^ counter ifNil: [ counter := 0 ]
]

{ #category : #accessing }
ToElementState >> counter: aNumber [

	counter := aNumber
]

{ #category : #processing }
ToElementState >> enterOn: aWidget previousState: aPreviousState [

	self fireEvent: (ToEnterStateEvent new
			 widget: aWidget;
			 state: self;
			 previousState: aPreviousState;
			 yourself).
]

{ #category : #processing }
ToElementState >> exitOn: aWidget nextState: aState [

	self fireEvent: (ToExitStateEvent new
			 widget: aWidget;
			 state: self;
			 nextState: aState;
			 yourself).

	aState enterOn: aWidget previousState: self
]

{ #category : #accessing }
ToElementState >> name [

	^ name
]

{ #category : #accessing }
ToElementState >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToElementState >> next [

	^ next
]

{ #category : #accessing }
ToElementState >> next: aWidgetState [

	next := aWidgetState
]

{ #category : #accessing }
ToElementState >> whenEnterDo: aBlock [

	self when: ToEnterStateEvent do: [ :ann | aBlock cull: ann ]
]

{ #category : #accessing }
ToElementState >> whenExitDo: aBlock [

	self when: ToExitStateEvent do: [ :ann | aBlock cull: ann ]
]
