Class {
	#name : #ToMultipleSelectNode,
	#superclass : #ToElementBarNode,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #'private configurating' }
ToMultipleSelectNode >> addRemoveButton [

	| but |
	but := ToButton new.
	but defaultRawSkin: ToSelectNodeInnerCloseButtonSkin new.
	but icon: (ToImage inner: (self iconNamed: #windowClose)).
	but constraintsDo: [ :c | c linear vertical alignCenter ].

	but addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :event |
				 event consume.
				 " remove the button by deselecting the corresponding list node in the list "
				 self removeFromBar ]).

	" consume mouseUp/mouseDown to avoid unwanted opening/closing of the popup list element"
	but addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :event | event consume ]).
	but addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :event | event consume ]).

	but id: #removeButton.
	self startContainer addChild: but
]

{ #category : #configurating }
ToMultipleSelectNode >> beRemovable [

	self removable: true
]

{ #category : #configurating }
ToMultipleSelectNode >> beUnremovable [

	self removable: false
]

{ #category : #initialization }
ToMultipleSelectNode >> initialize [ 

	super initialize.
	removable := false.
]

{ #category : #testing }
ToMultipleSelectNode >> isRemovable [

	^ removable
]

{ #category : #accessing }
ToMultipleSelectNode >> removable [

	^ removable 
]

{ #category : #accessing }
ToMultipleSelectNode >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable ifTrue: [ self removeRemoveButton ].
	removable := aBoolean.
	removable ifTrue: [ self addRemoveButton ]
	
]

{ #category : #'private configurating' }
ToMultipleSelectNode >> removeRemoveButton [

	| but |
	but := self endContainer childWithId: #removeButton.
	but removeFromParent
]

{ #category : #layout }
ToMultipleSelectNode >> rightWidthGap [

	| bar |
	bar := self holder elementBar.
	^ bar textInputElement measuredWidth
]
