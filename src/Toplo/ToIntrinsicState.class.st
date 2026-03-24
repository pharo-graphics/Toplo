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

	(self isUnchangedOn: anElement) ifTrue: [
			enqueued := false.
			^ self ].
	previousPattern := self currentPatternOn: anElement.

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

{ #category : #'private - accessing' }
ToIntrinsicState >> checkState [

	^ checkedSkinEvent ifNotNil: [ :e | e checked ]
]

{ #category : #accessing }
ToIntrinsicState >> checkedSkinEvent: aSkinEvent [

	checkedSkinEvent := aSkinEvent
]

{ #category : #'private - accessing' }
ToIntrinsicState >> currentPatternOn: anElement [

	^ {
		  self enablementState.
		  (self focusStateOn: anElement).
		  self checkState.
		  self selectionState.
		  self otherSelectionsState }
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> dispatchSkinEvent: anEvent on: anElement [

	anEvent ifNil: [ ^ self ].
	anElement skinManager dispatchSkinEvent: anEvent
]

{ #category : #accessing }
ToIntrinsicState >> enabledSkinEvent: aSkinEvent [

	enabledSkinEvent := aSkinEvent
]

{ #category : #'private - accessing' }
ToIntrinsicState >> enablementState [

	^ enabledSkinEvent enabled
]

{ #category : #accessing }
ToIntrinsicState >> enqueued [

	^ enqueued ifNil: [ enqueued := false ]
]

{ #category : #accessing }
ToIntrinsicState >> enqueued: aBoolean [

	enqueued := aBoolean
]

{ #category : #'private - accessing' }
ToIntrinsicState >> focusStateOn: anElement [

	^ anElement hasFocusedParent
]

{ #category : #accessing }
ToIntrinsicState >> focusedSkinEvent: aSkinEvent [

	focusedSkinEvent := aSkinEvent
]

{ #category : #initialization }
ToIntrinsicState >> initialize [ 

	super initialize.
	otherSelectionSkinEventMap := SmallIdentityDictionary new.
	enabledSkinEvent := ToEnabledSkinEvent new.
]

{ #category : #'private - testing' }
ToIntrinsicState >> isOtherSelectionsStateUnchangedOn: anElement [

	| prev |
	prev := previousPattern at: 5.
	prev size = otherSelectionSkinEventMap size ifFalse: [ ^ false ].
	prev associationsDo: [ :each |
			(otherSelectionSkinEventMap at: each key ifAbsent: [ ^ false ])
				class = each value class ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'private - testing' }
ToIntrinsicState >> isUnchangedOn: anElement [

	^ previousPattern notNil and: [
			  previousPattern first = self enablementState and: [
					  (previousPattern at: 2) = (self focusStateOn: anElement) and: [
							  (previousPattern at: 3) = self checkState and: [
									  (previousPattern at: 4) = self selectionState and: [
										  self isOtherSelectionsStateUnchangedOn: anElement ] ] ] ] ]
]

{ #category : #'private - accessing' }
ToIntrinsicState >> otherSelectionsState [

	^ otherSelectionSkinEventMap copy
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

{ #category : #'private - accessing' }
ToIntrinsicState >> selectionState [

	^ selectedSkinEvent ifNotNil: [ :e | e selected ]
]
