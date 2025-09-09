Class {
	#name : #ToActionLink,
	#superclass : #ToWidgetLink,
	#instVars : [
		'action',
		'runCount'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #accessing }
ToActionLink >> action: anAction [

	action := anAction
]

{ #category : #initialization }
ToActionLink >> initialize [

	super initialize.
	runCount := 0.
	action := [  ]
]

{ #category : #initialization }
ToActionLink >> linkWith: anElement [

	super linkWith: anElement.
	anElement registerAction: self
]

{ #category : #running }
ToActionLink >> onActionRunnedDo: aValuable [

	self
		addedHandler: (self
				 addEventHandlerOn: ToActionRunnedEvent
				 do: [ :evt | aValuable cull: evt sourceEvent ])
		in: self
]

{ #category : #running }
ToActionLink >> onNextRunActionRequest: anEvent [

	| evt |
	self dispatchEvent: ToActionRunRequest new.
	action cull: anEvent.
	evt := ToActionRunnedEvent new
		       sourceEvent: anEvent;
		       actionLink: self;
		       yourself.

	widget ifNotNil: [
			| space |
			space := widget space.
			space ifNotNil: [ :sp | evt fillFromTime: space time ] ].

	runCount := runCount + 1.
	self dispatchEvent: evt
]

{ #category : #running }
ToActionLink >> requestNextRun [

	self requestNextRunWithEvent: nil
]

{ #category : #running }
ToActionLink >> requestNextRunWithEvent: anEvent [

	widget ifNil: [
			self onNextRunActionRequest: anEvent.
			^ self ].
	widget isDisabled ifTrue: [ ^ self ].
	widget isAttachedToSceneGraph
		ifTrue: [ self onNextRunActionRequest: anEvent ]
		ifFalse: [
		widget inUIProcessDo: [ self onNextRunActionRequest: anEvent ] ]
]

{ #category : #running }
ToActionLink >> run [

	self deprecated: 'use #requestNextRun instead' transformWith: '`@rcvr run' -> '`@rcvr requestNextRun'.
	self requestNextRun
]

{ #category : #accessing }
ToActionLink >> runCount [ 

	^ runCount
]

{ #category : #running }
ToActionLink >> runWithEvent: anEvent [

	self
		deprecated: 'use #requestNextRunWithEvent: instead'
		transformWith:
		'`@rcvr runWithEvent: `@arg' -> '`@rcvr requestNextRunWithEvent: `@arg'.
	self requestNextRunWithEvent: anEvent
]

{ #category : #initialization }
ToActionLink >> unlink [

	widget unregisterAction: self.
	super unlink
]
