Trait {
	#name : #TToWidgetWithContextMenu,
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> contextMenu [

	^ self userData at: #contextMenu ifAbsent: [  ]
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> contextMenu: aMenu [

	self userData at: #contextMenu put: aMenu
]

{ #category : #'t - accessing context menu' }
TToWidgetWithContextMenu >> contextMenuDo: aBlock [

	self contextMenu
		ifNil: [ ^ self ]
		ifNotNil: [ :m | aBlock cull: m ]
]
