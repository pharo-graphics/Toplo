Trait {
	#name : #TToWidgetWithContextMenu,
	#instVars : [
		'contextMenuFactory',
		'contextMenuEventHandler'
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
		self addEventFilter: contextMenuEventHandler ]
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> uninstallContextMenuFactory [

	contextMenuFactory ifNotNil: [
		self removeEventFilter: contextMenuEventHandler.
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
