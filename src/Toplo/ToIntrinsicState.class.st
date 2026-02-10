Class {
	#name : #ToIntrinsicState,
	#superclass : #ToElementState,
	#instVars : [
		'enqueued',
		'skinEvents'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'skin dispatching' }
ToIntrinsicState >> applyOn: anElement fromQueue: aQueue [
	" dispatch intrinsic state events in the right order "

	self prepareSkinEventsForDispatchingOn: anElement.

	self enabledSkinEvent enabled ifTrue: [
		self dispatchSkinEvent: self enabledSkinEvent on: anElement ].

	2 to: skinEvents size do: [ :p |
	self dispatchSkinEvent: (skinEvents at: p) on: anElement ].

	self enabledSkinEvent enabled ifFalse: [
		self dispatchSkinEvent: self enabledSkinEvent on: anElement ].

	enqueued := false
]

{ #category : #accessing }
ToIntrinsicState >> checkedSkinEvent: aSkinEvent [

	skinEvents at: 3 put: aSkinEvent
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> dispatchSkinEvent: anEvent on: anElement [

	anEvent ifNil: [ ^ self ].
	anElement dispatchEvent: anEvent
]

{ #category : #accessing }
ToIntrinsicState >> enabledSkinEvent [

	^ skinEvents first
]

{ #category : #accessing }
ToIntrinsicState >> enabledSkinEvent: aSkinEvent [

	skinEvents at: 1 put: aSkinEvent
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

	skinEvents at: 2 put: aSkinEvent
]

{ #category : #initialization }
ToIntrinsicState >> initialize [ 

	super initialize.
	skinEvents := Array new: 4.
	self enabledSkinEvent: ToEnabledSkinEvent new.
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> prepareSkinEventsForDispatchingOn: anElement [

	anElement spaceDo: [ :space |
			skinEvents do: [ :evt |
				evt ifNotNil: [ evt fillFromTime: space time ] ] ]
]

{ #category : #accessing }
ToIntrinsicState >> selectedSkinEvent: aSkinEvent [

	skinEvents at: 4 put: aSkinEvent
]
