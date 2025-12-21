Class {
	#name : #ToTabPaneHeaderElement,
	#superclass : #ToTripletContainer,
	#instVars : [
		'alignment',
		'compactLayoutMode',
		'layoutModeCheckRequested'
	],
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #accessing }
ToTabPaneHeaderElement >> alignEnd [

	self alignment: BlElementAlignment end
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignMiddle [

	self alignment: BlElementAlignment middle
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignStart [ 

	self alignment: BlElementAlignment start
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignment [ 

	^ alignment
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignment: anElementAlignment [ 

	alignment := anElementAlignment.
	self requestConfiguration
]

{ #category : #configuration }
ToTabPaneHeaderElement >> checkLayoutMode [

	compactLayoutMode ifFalse: [ ^ self ].
	self matchParentMode
		ifFalse: [
				| w |
				" If fitContent, the invisible nodes list is always empty.
				one have to check the geometry "
				w := self isHorizontal
					     ifTrue: [ self width - self tabGroup width ]
					     ifFalse: [ self height - self tabGroup height ].
				w < 0.0 ifTrue: [ self matchParentMode: true ] ]
		ifTrue: [ " just check the invisible nodes, if it is empty, 
			then one can switch to a fitContent"
			self invisibleNodeContainers ifEmpty: [ self matchParentMode: false ] ]
]

{ #category : #accessing }
ToTabPaneHeaderElement >> compactLayoutMode: aBoolean [

	compactLayoutMode = aBoolean ifTrue: [ ^ self ].
	compactLayoutMode := aBoolean.
	aBoolean
		ifTrue: [ self requestLayoutModeCheck ]
		ifFalse: [ self matchParentMode: true ]
]

{ #category : #accessing }
ToTabPaneHeaderElement >> endExtraBuilder: aValuable [

	aValuable value: self endContainer
]

{ #category : #initialization }
ToTabPaneHeaderElement >> initialize [

	super initialize.
	compactLayoutMode := false.
	layoutModeCheckRequested := false.
	self createStartContainer.
	self createMiddleContainer.
	self createEndContainer.
	self startContainer id: #'start-extra-container'.
	self endContainer id: #'end-extra-container'.
	self noAlignment.
	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ self requestLayoutModeCheck ]
]

{ #category : #accessing }
ToTabPaneHeaderElement >> invisibleNodeContainers [ 

	^ self tabGroup invisibleNodeContainers
]

{ #category : #accessing }
ToTabPaneHeaderElement >> invisibleNodes [ 

	^ self tabGroup invisibleNodeContainers
]

{ #category : #accessing }
ToTabPaneHeaderElement >> isAlignEnd [

	^ self alignment = BlElementAlignment end
]

{ #category : #accessing }
ToTabPaneHeaderElement >> isAlignMiddle [

	^ self alignment = BlElementAlignment middle
]

{ #category : #accessing }
ToTabPaneHeaderElement >> isAlignStart [

	^ self alignment = BlElementAlignment start
]

{ #category : #configuration }
ToTabPaneHeaderElement >> matchParentMode [

	^ self toConfiguration matchParentMode
]

{ #category : #configuration }
ToTabPaneHeaderElement >> matchParentMode: aBoolean [

	self toConfiguration matchParentMode = aBoolean ifTrue: [ ^ self ].
	self toConfiguration matchParentMode: aBoolean.
	self requestConfiguration
]

{ #category : #'t - triplet container - instance creation' }
ToTabPaneHeaderElement >> newEndContainer [ 

	^ self newLinearContainer
]

{ #category : #'t - triplet container - instance creation' }
ToTabPaneHeaderElement >> newMiddleContainer [ 

	^ self newTabGroupElement
]

{ #category : #'instance creation' }
ToTabPaneHeaderElement >> newRawSkin [ 

	^ ToTabPaneHeaderElementSkin new
]

{ #category : #'t - triplet container - instance creation' }
ToTabPaneHeaderElement >> newStartContainer [ 

	^ self newLinearContainer
]

{ #category : #'instance creation' }
ToTabPaneHeaderElement >> newTabGroupElement [

	^ ToTabPaneGroupElement new
		  matchParent;
		  yourself
]

{ #category : #configuration }
ToTabPaneHeaderElement >> newToConfiguration [ 

	^ ToTabPaneHeaderConfiguration new
]

{ #category : #accessing }
ToTabPaneHeaderElement >> noAlignment [

	self alignment: BlElementAlignment null
]

{ #category : #'hooks - layout' }
ToTabPaneHeaderElement >> onLayoutDone [ 

	super onLayoutDone.
	layoutModeCheckRequested ifFalse: [ ^ self ].
	self checkLayoutMode.
	layoutModeCheckRequested := false

]

{ #category : #'hooks - layout' }
ToTabPaneHeaderElement >> requestLayoutModeCheck [

	compactLayoutMode ifFalse: [ ^ self ].
	layoutModeCheckRequested := true
]

{ #category : #accessing }
ToTabPaneHeaderElement >> startExtraBuilder: aValuable [

	aValuable value: self startContainer
]

{ #category : #accessing }
ToTabPaneHeaderElement >> tabGroup [ 

	^ self middleContainer 
]

{ #category : #accessing }
ToTabPaneHeaderElement >> trackElement [

	^ self tabGroup innerElement trackElement
]
