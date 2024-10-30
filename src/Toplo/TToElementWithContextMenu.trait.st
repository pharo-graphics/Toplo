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
TToElementWithContextMenu >> contextMenuBuilder [

	^ self contextMenuWindowManager builder
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuBuilder: aValuable [

	" aValuable take the context menu to build as first argument and the request event  as second aargument "
	
	aValuable 
		ifNil: [
			self contextMenuWindowManager: nil.
			^ self ].
	self contextMenuWindowManager builder: aValuable
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuContent: anArray [

	anArray ifNil: [
		self removeContextMenuWindowManager.
		^ self ].
	self contextMenuBuilder: [ :win :theRequestEvent | win addAllItems: anArray ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuWindowManager [

	^ self userData at: #contextMenuWindowManager ifAbsentPut: [
		  | handler |
		  handler := self contextMenuWindowManagerClass new.
		  self addEventHandler: handler.
		  handler ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuWindowManager: aWindowHandler [

	self rawContextMenuWindowManager = aWindowHandler ifTrue: [ ^ self ].
	self removeContextMenuWindowManager.
	aWindowHandler ifNil: [ ^ self ].
	self addEventHandler: aWindowHandler.
	self userData at: #contextMenuWindowManager put: aWindowHandler
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuWindowManagerClass [

	^ self userData at: #contextMenuWindowManagerClass ifAbsentPut: [ ToContextMenuWindowManager]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuWindowManagerClass: aHandlerClass [

	self userData at: #contextMenuWindowManagerClass put: aHandlerClass
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> currentContextMenu [

	^ self rawContextMenuWindowManager ifNotNil: [ :h | h currentWindow ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> hasContextMenu [
	" do not use #contextMenuWindowHandler to avoid ContextMenuWindowHandler installation here "

	^ self rawContextMenuWindowManager notNil
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> hasOpenedContextMenu [
	" do not use #contextMenuWindowHandler to avoid ContextMenuWindowHandler installation here "

	^ self currentContextMenu notNil
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> newContextMenuEvent: anEvent [

	^ self rawContextMenuWindowManager newWindowEvent: anEvent
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> rawContextMenuWindowManager [

	^ self userData at: #contextMenuWindowManager ifAbsent: [ ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> removeContextMenu [

	self removeContextMenuWindowManager
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> removeContextMenuWindowManager [

	| manager |
	manager := self rawContextMenuWindowManager.
	manager ifNil: [ ^ self ].
	manager hasWindow ifTrue: [ manager currentWindow close ].
	self removeEventHandler: manager.
	self userData removeKey: #contextMenuWindowManager
]
