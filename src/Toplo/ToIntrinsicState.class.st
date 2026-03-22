Class {
	#name : #ToIntrinsicState,
	#superclass : #ToElementState,
	#instVars : [
		'previousPattern',
		'enqueued',
		'enabledSkinEvent',
		'checkedSkinEvent',
		'focusedSkinEvent',
		'selectedSkinEvent',
		'otherSelectionSkinEventMap'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'skin dispatching' }
ToIntrinsicState >> applyOn: anElement fromQueue: aQueue [
	" dispatch intrinsic state events in the predefined order: 
	[ enabled ] focused? checked? selected* [ disabled ] "

	| newPattern |
	newPattern := self currentPattern.
	previousPattern = newPattern ifTrue: [
			enqueued := false.
			^ self ].
	previousPattern := newPattern.

	self prepareSkinEventsForDispatchingOn: anElement.

	enabledSkinEvent enabled ifTrue: [
		self dispatchSkinEvent: enabledSkinEvent on: anElement ].

	focusedSkinEvent ifNotNil: [ :evt |
		self dispatchSkinEvent: evt on: anElement ].
	checkedSkinEvent ifNotNil: [ :evt |
		self dispatchSkinEvent: evt on: anElement ].
	selectedSkinEvent ifNotNil: [ :evt |
		self dispatchSkinEvent: evt on: anElement ].
	otherSelectionSkinEventMap valuesDo: [ :skinEvent |
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
ToIntrinsicState >> currentPattern [

	^ Array new: 15 streamContents: [ :stream |
			  stream nextPut: enabledSkinEvent enabled.
			  stream nextPut: (focusedSkinEvent ifNotNil: [ :e | e focused ]).
			  stream nextPut: (checkedSkinEvent ifNotNil: [ :e | e checked ]).
			  stream nextPut: (selectedSkinEvent ifNotNil: [ :e | e selected ]).
			  stream nextPut: otherSelectionSkinEventMap keys ]
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
	otherSelectionSkinEventMap := OrderedIdentityDictionary new.
	enabledSkinEvent := ToEnabledSkinEvent new.
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> prepareSkinEventsForDispatchingOn: anElement [

	anElement spaceDo: [ :space |
			enabledSkinEvent fillFromTime: space time.
			checkedSkinEvent ifNotNil: [ :evt | evt fillFromTime: space time ].
			focusedSkinEvent ifNotNil: [ :evt | evt fillFromTime: space time ].
			selectedSkinEvent ifNotNil: [ :evt | evt fillFromTime: space time ].
			otherSelectionSkinEventMap valuesDo: [ :evt |
				evt fillFromTime: space time ] ]
]

{ #category : #initialization }
ToIntrinsicState >> reset [

	enqueued := false.
	previousPattern := nil
]

{ #category : #accessing }
ToIntrinsicState >> selectedSkinEvent: aSkinEvent [

	aSkinEvent isPrimary ifTrue: [
			selectedSkinEvent := aSkinEvent.
			^ self ].
	otherSelectionSkinEventMap
		at: aSkinEvent selectionOption
		put: aSkinEvent
]
