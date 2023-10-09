Trait {
	#name : #TToElementWithContextMenu,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenu [

	^ self currentAssociateWindow
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> contextMenuFactory: aValuable [

	self associateWindowFactory: aValuable
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> hasOpenedContextMenu [

	^ self hasAssociateWindow 
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> installContextMenuFactory [

	self when: BlSecondaryMouseDownEvent do: [ :event |
		self contextMenu
			ifNotNil: [ :w | w close ]
			ifNil: [ self newContextMenu popupEvent: event ] ].
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> newContextMenu [

	^ self newAssociateWindow
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> popupOrCloseContextMenuEvent: anEvent [

	self contextMenu
		ifNotNil: [ :w | w close ]
		ifNil: [ self newContextMenu popupEvent: anEvent ]
]
