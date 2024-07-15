Class {
	#name : #ToMultiSelectBarNode,
	#superclass : #ToTripletElement,
	#traits : 'TToEnableable + TToListNode + TToBarNode',
	#classTraits : 'TToEnableable classTrait + TToListNode classTrait + TToBarNode classTrait',
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'private configurating' }
ToMultiSelectBarNode >> addRemoveButton [

	| but |
	but := ToButton new.
	but applySkinInstallerOnFirstRequest: true.
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
	self startElement: but
]

{ #category : #configurating }
ToMultiSelectBarNode >> beRemovable [

	self removable: true
]

{ #category : #configurating }
ToMultiSelectBarNode >> beUnremovable [

	self removable: false
]

{ #category : #'t - list node' }
ToMultiSelectBarNode >> clickEventHandlerClasses [

	^  { ToListNodeMultiSelectionClickEventHandler } 
]

{ #category : #initialization }
ToMultiSelectBarNode >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	removable := true
]

{ #category : #skin }
ToMultiSelectBarNode >> installRawStyle [

	super installRawStyle.
	self isRemovable ifTrue: [ self addRemoveButton ].
	self constraintsDo: [ :c | c linear vertical alignCenter ].
	self middleContainer padding: (BlInsets left: 3 right: 3).
	self padding: (BlInsets horizontal: 2 vertical: 2).
	self isFake
		ifTrue: [ self margin: (BlInsets vertical: 2) ]
		ifFalse: [ self margin: (BlInsets all: 2) ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: (Color lightGray alpha: 0.3).
	self holder dataItem isComposite ifTrue: [
		self tooltipBuilder: [ :win :theElement |
			| pane |
			pane := ToPane vertical.
			self holder dataItem dataItems do: [ :item | | t |
				t := self holder dataAccessor at: item index.
				pane addChild: (ToLabel text: t asString) ].
			win root addChild: pane ] ]
]

{ #category : #testing }
ToMultiSelectBarNode >> isRemovable [

	^ removable and: [  self nodesCount = 1 ]
]

{ #category : #accessing }
ToMultiSelectBarNode >> nodesCount [ 

	^ self holder dataItem nodesCount
]

{ #category : #accessing }
ToMultiSelectBarNode >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable ifTrue: [ self removeRemoveButton ].
	removable := aBoolean.
	self isRemovable ifTrue: [ self addRemoveButton ]
	
]

{ #category : #'private configurating' }
ToMultiSelectBarNode >> removeButton [

	^ self childWithId: #removeButton ifNone: [  ]
]

{ #category : #private }
ToMultiSelectBarNode >> removeFromBar [
	" 
	First, remove the node by deselecting the corresponding list node in the list (if found). 
	Second, if the data is not one of the actual list element data, remove the data through the select "

	self holder selecter deselectIndex: self holder dataItem index
]

{ #category : #'private configurating' }
ToMultiSelectBarNode >> removeRemoveButton [

	| but |
	but := self removeButton.
	but ifNil: [ ^ self ].
	but removeFromParent
]
