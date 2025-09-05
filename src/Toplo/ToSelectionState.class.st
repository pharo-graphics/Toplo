Class {
	#name : #ToSelectionState,
	#superclass : #ToIntrinsicStateBase,
	#instVars : [
		'focused',
		'selected',
		'selectionOption'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToSelectionState >> applyOn: anElement fromQueue: aQueue [

	| skinEvtCls skinEvt |
	skinEvtCls := selected
		              ifTrue: [ ToSelectedSkinEvent ]
		              ifFalse: [ ToDeselectedSkinEvent ].
	skinEvt := skinEvtCls new.
	skinEvt focused: focused.
	skinEvt selectionOption: selectionOption.
	self dispatchSkinEvent: skinEvt on: anElement fromQueue: aQueue
]

{ #category : #accessing }
ToSelectionState >> focused [

	^ focused
]

{ #category : #accessing }
ToSelectionState >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #accessing }
ToSelectionState >> selected [

	^ selected
]

{ #category : #accessing }
ToSelectionState >> selected: aBoolean [

	selected := aBoolean
]

{ #category : #accessing }
ToSelectionState >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToSelectionState >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]
