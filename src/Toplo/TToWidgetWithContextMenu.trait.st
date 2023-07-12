Trait {
	#name : #TToWidgetWithContextMenu,
	#instVars : [
		'contextMenuFactory',
		'contextMenuEventHandler',
		'openedContextMenu'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - context menu accessing' }
TToWidgetWithContextMenu >> contextMenu [

	^ (contextMenuFactory cull: self) widget: self; client: self; yourself
]

{ #category : #'t - context menu accessing' }
TToWidgetWithContextMenu >> contextMenuFactory [

	^ contextMenuFactory 
]

{ #category : #'t - context menu accessing' }
TToWidgetWithContextMenu >> contextMenuFactory: aValuable [

	aValuable = contextMenuFactory ifTrue: [ ^ self ].
	self uninstallContextMenuFactory.
	contextMenuFactory := aValuable.
	self installContextMenuFactory 
]

{ #category : #'t - context menu testing' }
TToWidgetWithContextMenu >> hasOpenedContextMenu [

	^ openedContextMenu notNil and: [ openedContextMenu isAttachedToSceneGraph ]
]

{ #category : #'t - context menu accessing' }
TToWidgetWithContextMenu >> installContextMenuFactory [

	contextMenuFactory ifNotNil: [
		contextMenuEventHandler := ToWidgetWithContextMenuEventHandler new.
		self addEventHandler: contextMenuEventHandler ]
]

{ #category : #'t - context menu accessing' }
TToWidgetWithContextMenu >> openedContextMenu [

	^ openedContextMenu
]

{ #category : #'t - context menu accessing' }
TToWidgetWithContextMenu >> openedContextMenu: aContextMenu [

	openedContextMenu := aContextMenu
]

{ #category : #'t - context menu accessing' }
TToWidgetWithContextMenu >> uninstallContextMenuFactory [

	contextMenuFactory ifNotNil: [
		self removeEventHandler: contextMenuEventHandler.
		contextMenuEventHandler := nil ]
]
