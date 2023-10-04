Trait {
	#name : #TToElementWithContextMenu,
	#instVars : [
		'contextMenuFactory',
		'contextMenuEventHandler',
		'openedContextMenu'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> contextMenu [

	^ (contextMenuFactory cull: self) associateElement: self; yourself
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> contextMenuFactory [

	^ contextMenuFactory 
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> contextMenuFactory: aValuable [

	aValuable = contextMenuFactory ifTrue: [ ^ self ].
	self uninstallContextMenuFactory.
	contextMenuFactory := aValuable.
	self installContextMenuFactory 
]

{ #category : #'t - widget with context menu - testing' }
TToElementWithContextMenu >> hasOpenedContextMenu [

	^ openedContextMenu notNil and: [ openedContextMenu isAttachedToSceneGraph ]
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> installContextMenuFactory [

	contextMenuFactory ifNotNil: [
		contextMenuEventHandler := ToElementWithContextMenuEventHandler new.
		self addEventHandler: contextMenuEventHandler ]
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> openedContextMenu [

	^ openedContextMenu
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> openedContextMenu: aContextMenu [

	openedContextMenu := aContextMenu
]

{ #category : #'t - widget with context menu - accessing' }
TToElementWithContextMenu >> uninstallContextMenuFactory [

	contextMenuFactory ifNotNil: [
		self removeEventHandler: contextMenuEventHandler.
		contextMenuEventHandler := nil ]
]
