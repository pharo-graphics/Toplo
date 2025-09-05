Class {
	#name : #ToIntrinsicState,
	#superclass : #ToIntrinsicStateBase,
	#instVars : [
		'enqueued',
		'enabled',
		'checked',
		'focused',
		'selectionState'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToIntrinsicState >> applyOn: anElement fromQueue: aQueue [

	" enabled can be nil, in that case no event dispatching is required"
	enabled = true ifTrue: [  self dispatchEnablementEventOn: anElement fromQueue: aQueue ].
	selectionState ifNotNil: [ :ses | ses applyOn: anElement fromQueue: aQueue ].
	self dispatchCheckEventOn: anElement fromQueue: aQueue.
	self dispatchFocusEventOn: anElement fromQueue: aQueue.
	enabled = false ifTrue: [  self dispatchEnablementEventOn: anElement fromQueue: aQueue ].
	enqueued := false

]

{ #category : #accessing }
ToIntrinsicState >> checked [

	^ checked
]

{ #category : #accessing }
ToIntrinsicState >> checked: aBoolean [

	checked := aBoolean
]

{ #category : #'look event sending' }
ToIntrinsicState >> dispatchCheckEventOn: anElement fromQueue: aQueue [

	| skinEvtCls |
	checked ifNil: [ ^ self ].
	skinEvtCls := checked isSymbol
		              ifTrue: [ ToIndeterminateSkinEvent ]
		              ifFalse: [
				              checked
					              ifTrue: [ ToCheckedSkinEvent ]
					              ifFalse: [ ToUncheckedSkinEvent ] ].
	self dispatchSkinEvent: skinEvtCls new on: anElement fromQueue: aQueue
]

{ #category : #'look event sending' }
ToIntrinsicState >> dispatchEnablementEventOn: anElement fromQueue: aQueue [

	| skinEvtCls |
	enabled ifNil: [ ^ self ].
	skinEvtCls := enabled
		              ifTrue: [ ToEnabledSkinEvent ]
		              ifFalse: [ ToDisabledSkinEvent ].
	self dispatchSkinEvent: skinEvtCls new on: anElement fromQueue: aQueue
]

{ #category : #'look event sending' }
ToIntrinsicState >> dispatchFocusEventOn: anElement fromQueue: aQueue [

	| skinEvtCls |
	focused ifNil: [ ^ self ].
	skinEvtCls := focused
		              ifTrue: [ ToFocusedSkinEvent ]
		              ifFalse: [ ToUnfocusedSkinEvent ].
	self dispatchSkinEvent: skinEvtCls new on: anElement fromQueue: aQueue
]

{ #category : #accessing }
ToIntrinsicState >> enabled [

	^ enabled
]

{ #category : #accessing }
ToIntrinsicState >> enabled: aBoolean [

	enabled := aBoolean
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
ToIntrinsicState >> focused [

	^ focused
]

{ #category : #accessing }
ToIntrinsicState >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #accessing }
ToIntrinsicState >> selectionState [

	^ selectionState
]

{ #category : #accessing }
ToIntrinsicState >> selectionState: aSelectionState [

	selectionState := aSelectionState
]
