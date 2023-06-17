Class {
	#name : #ToWidgetState,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'name',
		'next',
		'counter',
		'eventDispatcher'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToWidgetState >> counter [

	^ counter ifNil: [ counter := 0 ]
]

{ #category : #accessing }
ToWidgetState >> counter: aNumber [

	counter := aNumber
]

{ #category : #processing }
ToWidgetState >> enterOn: aWidget previousState: aPreviousState [

	self fireEvent: (ToEnterStateEvent new
			 widget: aWidget;
			 state: self;
			 previousState: aPreviousState;
			 yourself).
]

{ #category : #'event management accessing' }
ToWidgetState >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #processing }
ToWidgetState >> exitOn: aWidget nextState: aState [

	self fireEvent: (ToExitStateEvent new
			 widget: aWidget;
			 state: self;
			 nextState: aState;
			 yourself).

	aState enterOn: aWidget previousState: self
]

{ #category : #initialization }
ToWidgetState >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
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

{ #category : #initialization }
ToWidgetState >> reset [

	eventDispatcher := nil
]

{ #category : #accessing }
ToWidgetState >> whenEnterDo: aBlock [

	self when: ToEnterStateEvent do: [ :ann | aBlock cull: ann ]
]

{ #category : #accessing }
ToWidgetState >> whenExitDo: aBlock [

	self when: ToExitStateEvent do: [ :ann | aBlock cull: ann ]
]
