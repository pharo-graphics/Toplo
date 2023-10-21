Trait {
	#name : 'TToPasteUpPane',
	#category : 'Toplo-Widget-Pane',
	#package : 'Toplo-Widget-Pane'
}

{ #category : 't - paset up pane' }
TToPasteUpPane >> draggedElement [

	^ self pasteUpField firstChild
]

{ #category : 't - paset up pane' }
TToPasteUpPane >> pasteUpField [

	^ self userData at: #pasteUpField
]

{ #category : 't - paset up pane' }
TToPasteUpPane >> pasteUpField: aLayer [

	self userData at: #pasteUpField put: aLayer
]

{ #category : 't - paset up pane' }
TToPasteUpPane >> setUpAsPasteUp [

	| field |
	field := ToPlaceholderLayer new.
	field preventMeAndChildrenMouseEvents.
	field layout: BlBasicLayout new.
	self pasteUpField: field
]
