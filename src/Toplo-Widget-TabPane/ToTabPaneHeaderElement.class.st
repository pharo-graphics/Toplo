Class {
	#name : #ToTabPaneHeaderElement,
	#superclass : #ToTripletElement,
	#instVars : [
		'tabGroup',
		'alignment',
		'tabGroupDynamicLayoutMode'
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

{ #category : #initialization }
ToTabPaneHeaderElement >> checkTabGroupDynamicLayoutMode [

	tabGroupDynamicLayoutMode ifFalse: [ ^ self ].
	self trackElement parent isHFitContent
		ifTrue: [
				| groupEndBnds tabPaneEndBnds w |
				groupEndBnds := self tabGroup endContainer bounds inParent: self.
				tabPaneEndBnds := self endContainer bounds.
				w := tabPaneEndBnds left - groupEndBnds right.
				w < 1 ifTrue: [
						self trackElement allParentsUpTo: self tabGroup do: [ :p |
								self isHorizontal
									ifTrue: [ p hMatchParent ]
									ifFalse: [ p vMatchParent ] ] ] ]
		ifFalse: [
				self tabGroup invisibleNodes ifEmpty: [
						self trackElement allParentsUpTo: self tabGroup do: [ :p |
								self isHorizontal
									ifTrue: [ p hFitContent ]
									ifFalse: [ p vFitContent ] ] ] ]
]

{ #category : #accessing }
ToTabPaneHeaderElement >> endExtraBuilder: aValuable [

	aValuable value: self endElement
]

{ #category : #initialization }
ToTabPaneHeaderElement >> initialize [

	super initialize.
	tabGroupDynamicLayoutMode := false.
	self startElement: self newLinearContainer.
	self endElement: self newLinearContainer.
	tabGroup := self newTabGroupElement.
	self middleElement: tabGroup.
	self noAlignment.
	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ self checkTabGroupDynamicLayoutMode ]
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

{ #category : #accessing }
ToTabPaneHeaderElement >> startExtraBuilder: aValuable [

	aValuable value: self startElement
]

{ #category : #accessing }
ToTabPaneHeaderElement >> tabGroup [ 

	^ tabGroup
]

{ #category : #accessing }
ToTabPaneHeaderElement >> tabGroupDynamicLayoutMode: aBoolean [

	tabGroupDynamicLayoutMode := aBoolean.
	self checkTabGroupDynamicLayoutMode
]

{ #category : #accessing }
ToTabPaneHeaderElement >> trackElement [

	^ self tabGroup trackElement
]
