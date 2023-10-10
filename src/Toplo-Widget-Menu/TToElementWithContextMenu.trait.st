Trait {
	#name : #TToElementWithContextMenu,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> contextMenuBuilder: aValuable [

	self contextMenuWindowHandler builder: aValuable
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuWindow [

	^ self rawContextMenuWindowHandler ifNotNil: [ :h | h currentWindow ]
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> contextMenuWindowHandler [

	^ self userData
		  at: #contextMenuWindowHandler
		  ifAbsentPut: [ ToContextMenuWindowHandler new element: self; yourself]
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> contextMenuWindowHandler: aWindowHandler [

	self rawContextMenuWindowHandler = aWindowHandler ifTrue: [ ^ self ].
	self removeContextMenuWindowHandler.
	aWindowHandler ifNil: [ ^ self ].
	self userData at: #contextMenuWindowHandler put: (aWindowHandler
			 element: self;
			 yourself)
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> hasOpenedContextMenu [
	" do not use #contextMenuWindowHandler to avoid ContextMenuWindowHandler installation here "

	^ self contextMenuWindow notNil
]

{ #category : #testing }
TToElementWithContextMenu >> isTopMenu [

	"need it for mouse outside event handling "
	^ false
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> newContextMenuEvent: anEvent [

	^ self contextMenuWindowHandler newWindowEvent: anEvent
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> popupOrCloseContextMenuEvent: anEvent [

	self contextMenuWindow
		ifNotNil: [ :w | w closeWindow ]
		ifNil: [ (self newContextMenuEvent: anEvent) popupEvent: anEvent ]
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> rawContextMenuWindowHandler [

	^ self userData at: #contextMenuWindowHandler ifAbsent: [ ]
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> removeContextMenuWindowHandler [

	| handler |
	handler := self userData
		           at: #contextMenuWindowHandler
		           ifAbsent: [ ^ self ].
	handler hasWindow ifTrue: [ handler closeWindow ].
	handler element: nil.
	self userData removeKey: #contextMenuWindowHandler
]
