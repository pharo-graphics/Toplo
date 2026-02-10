Class {
	#name : #ToIntrinsicState,
	#superclass : #ToElementState,
	#instVars : [
		'enqueued',
		'focusedSkinEvent',
		'checkedSkinEvent',
		'enabledSkinEvent',
		'selectedSkinEvent'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'skin dispatching' }
ToIntrinsicState >> applyOn: anElement fromQueue: aQueue [
	" dispatch intrinsic state event in the right order "

	self prepareSkinEventsForDispatchingOn: anElement.

	enabledSkinEvent enabled ifTrue: [
			self
				dispatchSkinEvent: enabledSkinEvent
				on: anElement
				fromQueue: aQueue ].
			
	{
		focusedSkinEvent.
		checkedSkinEvent.
		selectedSkinEvent } do: [ :evt |
		self dispatchSkinEvent: evt on: anElement fromQueue: aQueue ].

	enabledSkinEvent enabled ifFalse: [
			self
				dispatchSkinEvent: enabledSkinEvent
				on: anElement
				fromQueue: aQueue ].

	enqueued := false
]

{ #category : #accessing }
ToIntrinsicState >> checkedSkinEvent: aSkinEvent [

	checkedSkinEvent := aSkinEvent
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> dispatchSkinEvent: anEvent on: anElement fromQueue: aQueue [

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
	enabledSkinEvent := ToEnabledSkinEvent new
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> prepareSkinEventsForDispatchingOn: anElement [

	anElement spaceDo: [ :space |
			{
				enabledSkinEvent.
				focusedSkinEvent.
				checkedSkinEvent.
				selectedSkinEvent } do: [ :evt |
				evt ifNotNil: [ evt fillFromTime: space time ] ] ]
]

{ #category : #accessing }
ToIntrinsicState >> selectedSkinEvent: aSelectionEvent [

	selectedSkinEvent := aSelectionEvent
]
