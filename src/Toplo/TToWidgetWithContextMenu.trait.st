Trait {
	#name : #TToWidgetWithContextMenu,
	#instVars : [
		'contextMenuFactory',
		'contextMenuEventHandler',
		'openedContextMenu'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> contextMenu [

	^ (contextMenuFactory cull: self) widget: self; client: self; yourself
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> contextMenuFactory [

	^ contextMenuFactory 
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> contextMenuFactory: aValuable [

	aValuable = contextMenuFactory ifTrue: [ ^ self ].
	self uninstallContextMenuFactory.
	contextMenuFactory := aValuable.
	self installContextMenuFactory 
]

{ #category : #testing }
TToWidgetWithContextMenu >> hasOpenedContextMenu [

	^ openedContextMenu notNil and: [ openedContextMenu isAttachedToSceneGraph ]
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> installContextMenuFactory [

	contextMenuFactory ifNotNil: [
		contextMenuEventHandler := ToWidgetWithContextMenuEventHandler new.
		self addEventHandler: contextMenuEventHandler ]
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> openedContextMenu [

	^ openedContextMenu
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> openedContextMenu: aContextMenu [

	openedContextMenu := aContextMenu
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> uninstallContextMenuFactory [

	contextMenuFactory ifNotNil: [
		self removeEventHandler: contextMenuEventHandler.
		contextMenuEventHandler := nil ]
]
