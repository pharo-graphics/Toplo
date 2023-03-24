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

	^ (contextMenuFactory cull: self) widget: self; yourself
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> contextMenuFactory: aValuable [

	aValuable = contextMenuFactory ifTrue: [ ^ self ].
	self uninstallContextMenuFactory.
	contextMenuFactory := aValuable.
	self installContextMenuFactory 
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
TToWidgetWithContextMenu >> openedContextMenu: aBoolean [

	openedContextMenu := aBoolean
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> uninstallContextMenuFactory [

	contextMenuFactory ifNotNil: [
		self removeEventHandler: contextMenuEventHandler.
		contextMenuEventHandler := nil ]
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> whenContextMenuChangedDo: aBlock [

	"Inform when contextMenuFactory property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #contextMenuFactory whenChangedDo: aBlock
]
