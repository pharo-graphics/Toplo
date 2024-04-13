Class {
	#name : #ToVisibleSelectHeaderNode,
	#superclass : #ToMultipleSelectHeaderNode,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #'private configurating' }
ToVisibleSelectHeaderNode >> addRemoveButton [

	| but |
	but := ToButton new.
	but defaultRawSkin: ToSelectHeaderNodeInnerCloseButtonSkin new.
	but icon: (ToImage inner: (self iconNamed: #windowClose)).
	but constraintsDo: [ :c | c linear vertical alignCenter ].

	but addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :event |
				 event consume.
				 " remove the button by deselecting the corresponding list node in the list "
				 self removeFromSelect ]).

	" consume mouseUp/mouseDown to avoid unwanted opening/closing of the popup list element"
	but addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :event | event consume ]).
	but addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :event | event consume ]).

	but id: #removeButton.
	self endContainer addChild: but
]

{ #category : #configurating }
ToVisibleSelectHeaderNode >> beRemovable [

	self removable: true
]

{ #category : #configurating }
ToVisibleSelectHeaderNode >> beUnremovable [

	self removable: false
]

{ #category : #initialization }
ToVisibleSelectHeaderNode >> initialize [ 

	super initialize.
	removable := false.
]

{ #category : #testing }
ToVisibleSelectHeaderNode >> isRemovable [

	^ removable
]

{ #category : #accessing }
ToVisibleSelectHeaderNode >> removable [

	^ removable 
]

{ #category : #accessing }
ToVisibleSelectHeaderNode >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable ifTrue: [ self removeRemoveButton ].
	removable := aBoolean.
	removable ifTrue: [ self addRemoveButton ]
	
]

{ #category : #'private configurating' }
ToVisibleSelectHeaderNode >> removeRemoveButton [

	| but |
	but := self endContainer childWithId: #removeButton.
	but removeFromParent
]
