Class {
	#name : #ToSelectHeaderNode,
	#superclass : #ToElement,
	#instVars : [
		'selectHolder',
		'startContainer',
		'middleContainer',
		'endContainer',
		'removable',
		'mouseUpHandler'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #'private configurating' }
ToSelectHeaderNode >> addRemoveButton [

	| but |
	but := ToButton new.
	but defaultRawSkin: ToSelectHeaderNodeInnerCloseButtonSkin new.
	but icon: (ToImage inner: (self iconNamed: #windowClose)).
	but constraintsDo: [ :c | c linear vertical alignCenter ].

	but addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :event |
				 | list |
				 event consumed: true.
				 " remove the button by deselecting the corresponding list node in the list "
				 self removeFromSelect ]).

	" consume mouseUp/mouseDown to avoid unwanted opening/closing of the popup list element"
	but addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :event | event consumed: true ]).
	but addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :event | event consumed: true ]).

	but id: #removeButton.
	self endContainer addChild: but
]

{ #category : #configurating }
ToSelectHeaderNode >> beRemovable [

	self removable: true
]

{ #category : #configurating }
ToSelectHeaderNode >> beUnremovable [

	self removable: false
]

{ #category : #accessing }
ToSelectHeaderNode >> endContainer [

	^ endContainer
]

{ #category : #initialization }
ToSelectHeaderNode >> initialize [

	super initialize.

	self layout: BlLinearLayout horizontal.

	startContainer := ToElement new
		                  fitContent;
		                  layout: BlLinearLayout horizontal;
		                  yourself.
	middleContainer := ToElement new
		                   hMatchParent;
		                   vFitContent;
		                   layout: BlLinearLayout horizontal;
		                   yourself.
	endContainer := ToElement new
		                fitContent;
		                layout: BlLinearLayout horizontal;
		                yourself.
	self addChildren: {
			startContainer.
			middleContainer.
			endContainer }.
			
	self childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ].

	removable := false.
	self fitContent
]

{ #category : #testing }
ToSelectHeaderNode >> isRemovable [

	^ removable
]

{ #category : #accessing }
ToSelectHeaderNode >> middleContainer [

	^ middleContainer
]

{ #category : #'api - hooks' }
ToSelectHeaderNode >> onInstalledIn: aSelect [

	" to avoid unwanted window closing (because of the flow 
	layout that can enlarge the select height when a node is added)"
	mouseUpHandler := BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :event | event consumed: true ].
	self addEventHandler: mouseUpHandler
]

{ #category : #'api - hooks' }
ToSelectHeaderNode >> onUninstalledIn: aSelectHeaderNodeContainer [

	self removeEventHandler: mouseUpHandler.
	mouseUpHandler := nil


]

{ #category : #accessing }
ToSelectHeaderNode >> removable [

	^ removable 
]

{ #category : #accessing }
ToSelectHeaderNode >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable ifTrue: [ self removeRemoveButton ].
	removable := aBoolean.
	removable ifTrue: [ self addRemoveButton ]
	
]

{ #category : #'private configurating' }
ToSelectHeaderNode >> removeFromSelect [
	" remove the node by deselecting the corresponding list node in the list "

	self selectHolder select deselectIndex: self selectHolder position.
	self selectHolder select strategy refreshHeaderNodeContainer
]

{ #category : #'private configurating' }
ToSelectHeaderNode >> removeRemoveButton [

	| but |
	but := self endContainer childWithId: #removeButton.
	but removeFromParent
]

{ #category : #accessing }
ToSelectHeaderNode >> selectHolder [

	^ selectHolder 
]

{ #category : #accessing }
ToSelectHeaderNode >> selectHolder: aSelectNodeHolder [

	selectHolder := aSelectNodeHolder
]

{ #category : #accessing }
ToSelectHeaderNode >> startContainer [

	^ startContainer
]
