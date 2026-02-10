Class {
	#name : #ToIntrinsicState,
	#superclass : #ToElementState,
	#instVars : [
		'enqueued',
		'enabledSkinEvent',
		'selectionSkinEventMap',
		'checkedSkinEvent',
		'focusedSkinEvent'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'skin dispatching' }
ToIntrinsicState >> applyOn: anElement fromQueue: aQueue [
	" dispatch intrinsic state events in the predefined order: 
	[ enabled ] focused? checked? selected* [ disabled ] "

	self prepareSkinEventsForDispatchingOn: anElement.

	enabledSkinEvent enabled ifTrue: [
		self dispatchSkinEvent: enabledSkinEvent on: anElement ].

	focusedSkinEvent ifNotNil: [ :evt |
		self dispatchSkinEvent: evt on: anElement ].
	checkedSkinEvent ifNotNil: [ :evt |
		self dispatchSkinEvent: evt on: anElement ].
	selectionSkinEventMap valuesDo: [ :skinEvent |
		self dispatchSkinEvent: skinEvent on: anElement ].

	enabledSkinEvent enabled ifFalse: [
		self dispatchSkinEvent: enabledSkinEvent on: anElement ].

	enqueued := false
]

{ #category : #accessing }
ToIntrinsicState >> checkedSkinEvent: aSkinEvent [

	checkedSkinEvent := aSkinEvent
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> dispatchSkinEvent: anEvent on: anElement [

	anEvent ifNil: [ ^ self ].
	anElement dispatchEvent: anEvent
]

{ #category : #accessing }
ToIntrinsicState >> enabledSkinEvent: aSkinEvent [

	enabledSkinEvent := aSkinEvent
]

{ #category : #accessing }
ToIntrinsicState >> enqueued [

	^ enqueued ifNil: [ enqueued := false ]
]

{ #category : #accessing }
ToIntrinsicState >> enqueued: aBoolean [

	enqueued := aBoolean
]

{ #category : #accessing }
ToIntrinsicState >> focusedSkinEvent: aSkinEvent [

	focusedSkinEvent := aSkinEvent
]

{ #category : #initialization }
ToIntrinsicState >> initialize [ 

	super initialize.
	selectionSkinEventMap := SmallIdentityDictionary new.
	enabledSkinEvent := ToEnabledSkinEvent new.
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> prepareSkinEventsForDispatchingOn: anElement [

	anElement spaceDo: [ :space |
			enabledSkinEvent fillFromTime: space time.
			checkedSkinEvent ifNotNil: [ :evt | evt fillFromTime: space time ].
			focusedSkinEvent ifNotNil: [ :evt | evt fillFromTime: space time ].
			selectionSkinEventMap valuesDo: [ :evt |
				evt fillFromTime: space time ] ]
]

{ #category : #accessing }
ToIntrinsicState >> selectedSkinEvent: aSkinEvent [

	selectionSkinEventMap at: aSkinEvent selectionOption put: aSkinEvent
]
