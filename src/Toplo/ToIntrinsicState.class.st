Class {
	#name : #ToIntrinsicState,
	#superclass : #ToElementState,
	#instVars : [
		'enqueued',
		'focusedSkinEvent',
		'selectionSkinEvent',
		'checkedSkinEvent',
		'enabledSkinEvent'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'skin dispatching' }
ToIntrinsicState >> applyOn: anElement fromQueue: aQueue [

	" enabled can be nil, in that case no event dispatching is required"
	enabledSkinEvent enabled ifTrue: [  self dispatchEnabledSkinEventOn: anElement fromQueue: aQueue ].
	self dispatchSelectionSkinEventOn: anElement fromQueue: aQueue.
	self dispatchCheckedSkinEventOn: anElement fromQueue: aQueue.
	self dispatchFocusedSkinEventOn: anElement fromQueue: aQueue.
	enabledSkinEvent enabled ifFalse: [  self dispatchEnabledSkinEventOn: anElement fromQueue: aQueue ].
	enqueued := false
]

{ #category : #accessing }
ToIntrinsicState >> checkedSkinEvent [

	^ checkedSkinEvent
]

{ #category : #accessing }
ToIntrinsicState >> checkedSkinEvent: aSkinEvent [

	checkedSkinEvent := aSkinEvent
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> dispatchCheckedSkinEventOn: anElement fromQueue: aQueue [

	checkedSkinEvent ifNil: [ ^ self ].
	self dispatchSkinEvent: checkedSkinEvent on: anElement fromQueue: aQueue
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> dispatchEnabledSkinEventOn: anElement fromQueue: aQueue [

	enabledSkinEvent ifNil: [ ^ self ].
	self
		dispatchSkinEvent: enabledSkinEvent
		on: anElement
		fromQueue: aQueue
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> dispatchFocusedSkinEventOn: anElement fromQueue: aQueue [

	focusedSkinEvent ifNil: [ ^ self ].
	self dispatchSkinEvent: focusedSkinEvent on: anElement fromQueue: aQueue
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> dispatchSelectionSkinEventOn: anElement fromQueue: aQueue [

	selectionSkinEvent ifNil: [ ^ self ].
	self dispatchSkinEvent: selectionSkinEvent on: anElement fromQueue: aQueue
]

{ #category : #'skin dispatching' }
ToIntrinsicState >> dispatchSkinEvent: anEvent on: anElement fromQueue: aQueue [

	anElement spaceDo: [ :sp | anEvent fillFromTime: sp time ].
	anElement dispatchEvent: anEvent
]

{ #category : #accessing }
ToIntrinsicState >> enabledSkinEvent [

	^ enabledSkinEvent
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
ToIntrinsicState >> focusedSkinEvent [

	^ focusedSkinEvent
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

{ #category : #accessing }
ToIntrinsicState >> selectionSkinEvent [

	^ selectionSkinEvent
]

{ #category : #accessing }
ToIntrinsicState >> selectionSkinEvent: aSelectionEvent [

	selectionSkinEvent := aSelectionEvent
]
