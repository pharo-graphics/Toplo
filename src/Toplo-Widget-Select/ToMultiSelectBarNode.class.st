Class {
	#name : #ToMultiSelectBarNode,
	#superclass : #ToTripletElement,
	#traits : 'TToEnableable + TToListNode',
	#classTraits : 'TToEnableable classTrait + TToListNode classTrait',
	#instVars : [
		'removable',
		'holderInList'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'private configurating' }
ToMultiSelectBarNode >> addRemoveButton [

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
	self startElement: but
]

{ #category : #layout }
ToMultiSelectBarNode >> autoDistribute [

	self startFlexible: true.
	self endFlexible: true.
	self constraintsDo: [ :c |
		holderInList elementBar isHorizontal
			ifTrue: [ c horizontal matchParent ]
			ifFalse: [ c vertical matchParent ].
		c linear weight: 1.
		c flow weight: 1 ]
]

{ #category : #configurating }
ToMultiSelectBarNode >> beRemovable [

	self removable: true
]

{ #category : #configurating }
ToMultiSelectBarNode >> beUnremovable [

	self removable: false
]

{ #category : #accessing }
ToMultiSelectBarNode >> holderInList: anHolder [

	holderInList := anHolder
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
	removable ifTrue: [ self addRemoveButton ].
	self middleContainer padding: (BlInsets left: 3 right: 3).
	self padding: (BlInsets horizontal: 2 vertical: 2).
	self isFakeNode
		ifTrue: [ self margin: (BlInsets vertical: 2) ]
		ifFalse: [ self margin: (BlInsets all: 2) ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: (Color lightGray alpha: 0.3)
]

{ #category : #testing }
ToMultiSelectBarNode >> isFakeNode [

	^ self holder position isZero
]

{ #category : #testing }
ToMultiSelectBarNode >> isRemovable [

	^ removable
]

{ #category : #accessing }
ToMultiSelectBarNode >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable ifTrue: [ self removeRemoveButton ].
	removable := aBoolean.
	removable ifTrue: [ self addRemoveButton ]
	
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

	self holder listElement dataAccessor removeAt: self holder position
]

{ #category : #'private configurating' }
ToMultiSelectBarNode >> removeRemoveButton [

	| but |
	but := self removeButton.
	but ifNil: [ ^ self ].
	but removeFromParent
]

{ #category : #layout }
ToMultiSelectBarNode >> rightWidthGap [

	| bar |
	bar := self holder elementBar.
	^ bar textInputElement measuredWidth
]

{ #category : #'t - list node' }
ToMultiSelectBarNode >> setInitialConfiguration [

	self padding: (BlInsets horizontal: 4).
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]
