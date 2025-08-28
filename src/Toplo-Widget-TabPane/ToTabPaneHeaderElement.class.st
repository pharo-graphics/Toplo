Class {
	#name : #ToTabPaneHeaderElement,
	#superclass : #ToTripletElement,
	#instVars : [
		'tabGroup',
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
				| groupEndBnds tabPaneEndBnds w |
				groupEndBnds := tabGroup endContainer bounds inParent: self.
				tabPaneEndBnds := endContainer bounds.
				w := self isHorizontal
					     ifTrue: [ tabPaneEndBnds left - groupEndBnds right ]
					     ifFalse: [ tabPaneEndBnds top - groupEndBnds bottom ].
				w < 1 ifTrue: [ self matchParentMode: true ] ]
		ifTrue: [
			self invisibleNodes ifEmpty: [
				self matchParentMode: false ] ]
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

	aValuable value: self endElement
]

{ #category : #initialization }
ToTabPaneHeaderElement >> initialize [

	super initialize.
	compactLayoutMode := false.
	layoutModeCheckRequested := false.
	self startElement: self newLinearContainer.
	self startElement id: #'start-extra-container'.
	self endElement: self newLinearContainer.
	self endElement id: #'end-extra-container'.
	tabGroup := self newTabGroupElement.
	self middleElement: tabGroup.
	self noAlignment.

	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ self requestLayoutModeCheck ]
]

{ #category : #accessing }
ToTabPaneHeaderElement >> invisibleNodes [ 

	^ tabGroup invisibleNodes
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

	aValuable value: self startElement
]

{ #category : #accessing }
ToTabPaneHeaderElement >> tabGroup [ 

	^ tabGroup
]

{ #category : #accessing }
ToTabPaneHeaderElement >> trackElement [

	^ self tabGroup trackElement
]
