Class {
	#name : #ToIntrinsicState,
	#superclass : #ToElementState,
	#instVars : [
		'enqueued',
		'enabled',
		'checked',
		'focused',
		'selected',
		'selectionOption'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToIntrinsicState >> applyOn: anElement fromQueue: aQueue [

	" enabled can be nil, in that case no event dispatching is required"
	enabled = true ifTrue: [  self dispatchEnablementEventOn: anElement fromQueue: aQueue ].
	self dispatchSelectionEventOn: anElement fromQueue: aQueue.
	self dispatchCheckEventOn: anElement fromQueue: aQueue.
	self dispatchFocusEventOn: anElement fromQueue: aQueue.
	enabled = false ifTrue: [  self dispatchEnablementEventOn: anElement fromQueue: aQueue ].
	enqueued := false

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

{ #category : #'look event sending' }
ToIntrinsicState >> dispatchSelectionEventOn: anElement fromQueue: aQueue [

	| skinEvtCls skinEvt |
	selected ifNil: [ ^ self ].
	skinEvtCls := selected
		              ifTrue: [ ToSelectedSkinEvent ]
		              ifFalse: [ ToDeselectedSkinEvent ].
	skinEvt := skinEvtCls new.
	skinEvt focused: focused.
	skinEvt selectionOption: selectionOption.
	self dispatchSkinEvent: skinEvt on: anElement fromQueue: aQueue
]

{ #category : #'look event sending' }
ToIntrinsicState >> dispatchSkinEvent: anEvent on: anElement fromQueue: aQueue [

	anElement spaceDo: [ :sp | anEvent fillFromTime: anElement space time ].
	anElement dispatchEvent: anEvent
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
ToIntrinsicState >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #accessing }
ToIntrinsicState >> selected: aBoolean [

	selected := aBoolean
]

{ #category : #accessing }
ToIntrinsicState >> selectionOption: anObject [

	selectionOption := anObject
]
