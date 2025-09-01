Trait {
	#name : #TToElementWithContextMenu,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenu: aValuable [
	" aValuable take the context menu to build as first argument and the request event as second argument. if aValuable is nil, then the context menu builder is removed"

	self contextMenuBuilder: aValuable
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuBuilder: aValuable [
	" aValuable take the context menu to build as first argument and the request event  as second aargument "

	aValuable ifNil: [
		self contextMenuManager: nil.
		^ self ].
	self contextMenuManager windowBuilder: aValuable
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuItems: anArray [

	anArray ifNil: [
		self removeContextMenuManager.
		^ self ].
	self contextMenuBuilder: [ :win :theRequestEvent | win addAllItems: anArray ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuManager [

	^ self userData at: #contextMenuManager ifAbsentPut: [
		  | handler |
		  handler := self contextMenuManagerClass new.
		  self addEventHandler: handler.
		  handler ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuManager: aWindowHandler [

	self rawContextMenuManager = aWindowHandler ifTrue: [ ^ self ].
	self removeContextMenuManager.
	aWindowHandler ifNil: [ ^ self ].
	self addEventHandler: aWindowHandler.
	self userData at: #contextMenuManager put: aWindowHandler
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuManagerClass [

	^ self userData at: #contextMenuManagerClass ifAbsentPut: [ self defaultContextMenuManagerClass ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuManagerClass: aHandlerClass [

	self userData at: #contextMenuManagerClass put: aHandlerClass
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> currentContextMenu [

	^ self rawContextMenuManager ifNotNil: [ :h | h currentWindow ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> defaultContextMenuManagerClass [

	^ ToContextMenuManager
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> hasContextMenu [
	" do not use #contextMenuWindowHandler to avoid ContextMenuWindowHandler installation here "

	^ self rawContextMenuManager notNil
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> hasOpenedContextMenu [
	" do not use #contextMenuWindowHandler to avoid ContextMenuWindowHandler installation here "

	^ self currentContextMenu notNil
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> newContextMenuEvent: anEvent [

	^ self rawContextMenuManager createNewWindowOnEvent: anEvent
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> rawContextMenuManager [

	^ self userData at: #contextMenuManager ifAbsent: [ ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> removeContextMenuManager [

	| manager |
	manager := self rawContextMenuManager.
	manager ifNil: [ ^ self ].
	manager hasWindow ifTrue: [ manager currentWindow close ].
	self removeEventHandler: manager.
	self userData removeKey: #contextMenuManager
]
