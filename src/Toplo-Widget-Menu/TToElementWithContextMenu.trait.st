Trait {
	#name : 'TToElementWithContextMenu',
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> contextMenu: aValuable [
	" aValuable take the context menu to build as first argument and the element with context menu as second argument. if aValuable is nil, then the context menu builder is removed"

	self contextMenuBuilder: aValuable
]

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> contextMenuBuilder [

	^ self contextMenuWindowHandler builder
]

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> contextMenuBuilder: aValuable [

	" aValuable take the context menu to build as first argument and the element with context menu as second aargument "
	
	aValuable 
		ifNil: [
			self contextMenuWindowHandler: nil.
			^ self ].
	self contextMenuWindowHandler builder: aValuable
]

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> contextMenuWindowHandler [

	^ self userData at: #contextMenuWindowHandler ifAbsentPut: [
		  | handler |
		  handler := ToContextMenuWindowHandler new.
		  handler
			  element: self;
			  yourself ]
]

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> contextMenuWindowHandler: aWindowHandler [

	self rawContextMenuWindowHandler = aWindowHandler ifTrue: [ ^ self ].
	self removeContextMenuWindowHandler.
	aWindowHandler ifNil: [ ^ self ].
	self userData at: #contextMenuWindowHandler put: (aWindowHandler
			 element: self;
			 yourself)
]

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> currentContextMenu [

	^ self rawContextMenuWindowHandler ifNotNil: [ :h | h currentWindow ]
]

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> hasOpenedContextMenu [
	" do not use #contextMenuWindowHandler to avoid ContextMenuWindowHandler installation here "

	^ self currentContextMenu notNil
]

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> isTopMenu [

	"need it for mouse outside event handling "
	^ false
]

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> newContextMenuEvent: anEvent [

	^ self contextMenuWindowHandler newWindowEvent: anEvent
]

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> rawContextMenuWindowHandler [

	^ self userData at: #contextMenuWindowHandler ifAbsent: [ ]
]

{ #category : 't - element with context menu' }
TToElementWithContextMenu >> removeContextMenuWindowHandler [

	| handler |
	handler := self rawContextMenuWindowHandler.
	handler ifNil: [ ^ self ].
	handler hasWindow ifTrue: [ handler closeWindow ].
	handler element: nil.
	self userData removeKey: #contextMenuWindowHandler
]
