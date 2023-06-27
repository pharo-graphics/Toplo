Class {
	#name : #ToWidgetState,
	#superclass : #Object,
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
	#instVars : [
		'name',
		'next',
		'counter'
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

	self announce: (ToEnterStateAnnouncement new
			 widget: aWidget;
			 state: self;
			 previousState: aPreviousState;
			 yourself).
]

{ #category : #processing }
ToWidgetState >> exitOn: aWidget nextState: aState [

	self announce: (ToExitStateAnnouncement new
			 widget: aWidget;
			 state: self;
			 nextState: aState;
			 yourself).

	aState enterOn: aWidget previousState: self
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

	self resetAnnouncer 
]

{ #category : #accessing }
ToWidgetState >> whenEnterDo: aBlock [

	self whenAnnouncement: ToEnterStateAnnouncement do: [ :ann | aBlock cull: ann ]
]

{ #category : #accessing }
ToWidgetState >> whenExitDo: aBlock [

	self whenAnnouncement: ToExitStateAnnouncement do: [ :ann | aBlock cull: ann ]
]
