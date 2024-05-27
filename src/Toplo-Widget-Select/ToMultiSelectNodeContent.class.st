Class {
	#name : #ToMultiSelectNodeContent,
	#superclass : #ToTripletElement,
	#instVars : [
		'removable',
		'holderInList'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'private configurating' }
ToMultiSelectNodeContent >> addRemoveButton [

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
ToMultiSelectNodeContent >> autoDistribute [

	self startFlexible: true.
	self endFlexible: true.
	self constraintsDo: [ :c |
		self holder elementBar isHorizontal
			ifTrue: [ c horizontal matchParent ]
			ifFalse: [ c vertical matchParent ].
		c linear weight: 1.
		c flow weight: 1 ]
]

{ #category : #configurating }
ToMultiSelectNodeContent >> beRemovable [

	self removable: true
]

{ #category : #configurating }
ToMultiSelectNodeContent >> beUnremovable [

	self removable: false
]

{ #category : #initialization }
ToMultiSelectNodeContent >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	removable := false.
]

{ #category : #skin }
ToMultiSelectNodeContent >> installRawStyle [ 

	super installRawStyle.
	self middleContainer padding: (BlInsets left: 3 right: 3).
	self padding: (BlInsets horizontal: 2 vertical: 4).
	self margin: (BlInsets all: 2).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: (Color lightGray alpha: 0.3)
]

{ #category : #layout }
ToMultiSelectNodeContent >> isFullyVisible [

	holderInList node isFullyVisible
]

{ #category : #layout }
ToMultiSelectNodeContent >> isPartlyVisible [

	^ holderInList node isPartlyVisible
]

{ #category : #testing }
ToMultiSelectNodeContent >> isRemovable [

	^ removable
]

{ #category : #accessing }
ToMultiSelectNodeContent >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable ifTrue: [ self removeRemoveButton ].
	removable := aBoolean.
	removable ifTrue: [ self addRemoveButton ]
	
]

{ #category : #'private configurating' }
ToMultiSelectNodeContent >> removeButton [

	^ self childWithId: #removeButton ifNone: [  ]
]

{ #category : #private }
ToMultiSelectNodeContent >> removeFromBar [
	" 
	First, try to remove the node by deselecting the corresponding list node in the list (if found). 
	Second, if the data is not one of the actual list element data, remove the data through the select "

	holderInList listElement dataAccessor removeAt: holderInList position
]

{ #category : #'private configurating' }
ToMultiSelectNodeContent >> removeRemoveButton [

	| but |
	but := self removeButton.
	but ifNil: [ ^ self ].
	but removeFromParent
]

{ #category : #layout }
ToMultiSelectNodeContent >> rightWidthGap [

	| bar |
	bar := self holder elementBar.
	^ bar textInputElement measuredWidth
]
