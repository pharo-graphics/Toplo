Trait {
	#name : #TToElementWithContextMenu,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenu: aValuable [
	" aValuable take the context menu to build as first argument and the request event as second argument "

	self
		deprecated: 'Use #contextMenuBuilder:'
		transformWith:
		'`@rcvr contextMenu: `@arg' -> '`@rcvr contextMenuBuilder: `@arg'.
	self contextMenuBuilder: aValuable
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuBuilder: aValuable [
	" aValuable take the context menu to build as first argument and the request event  as second aargument "

	self ensuredContextMenuManager windowBuilder: aValuable
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuItems: anArray [
	" syntactic sugar "

	self
		deprecated: 'Use #contextMenuBuilder:'
		transformWith: '`@rcvr contextMenuItems: `@arg'
			->
			'`@rcvr contextMenuBuilder: [:menu :request | menu addAllItems: `@arg ]'.
	self contextMenuBuilder: [ :win :theRequestEvent |
		win addAllItems: anArray ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuManager [

	self
		deprecated: 'Use #ensuredCntextMenuManager'
		transformWith:
		'`@rcvr contextMenuManager' -> '`@rcvr ensuredContextMenuManager'.	

	^ self ensuredContextMenuManager
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuManagerFactory [

	^ self userData
		  at: #contextMenuManagerFactory
		  ifAbsentPut: [ [ :myself | ToContextMenuManager new ] ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> contextMenuManagerFactory: aValuable [
	" aValuable takes the element as optional argument "

	^ self userData at: #contextMenuManagerFactory put: aValuable
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> currentContextMenu [

	^ self rawContextMenuManager ifNotNil: [ :h | h currentWindow ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> ensuredContextMenuManager [

	^ self userData
		  at: #contextMenuManager
		  ifAbsentPut: [ self installedNewContextMenuManager ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> hasContextMenu [
	" do not use #contextMenuWindowHandler to avoid ContextMenuWindowHandler installation here "

	^ self currentContextMenu notNil
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> installedNewContextMenuManager [

	| manager |
	manager := self contextMenuManagerFactory cull: self.
	self addEventHandler: manager.
	^ manager
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> newContextMenu [

	^ self newContextMenuOnEvent: nil
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> newContextMenuEvent: anEvent [

	self
		deprecated: 'Use newContextMenuOnEvent:'
		transformWith: '`@rcvr newContextMenuEvent: `@arg'
			-> '`@rcvr newContextMenuOnEvent: `@arg'.

	^ self newContextMenuOnEvent: anEvent
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> newContextMenuOnEvent: anEvent [

	^ self rawContextMenuManager createNewWindowOnEvent: anEvent
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> rawContextMenuManager [

	^ self userData at: #contextMenuManager ifAbsent: [ ]
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> removeContextMenuBuilder [

	| manager |
	manager := self rawContextMenuManager.
	manager ifNil: [ ^ self ].
	manager hasWindow ifTrue: [ manager currentWindow close ].
	self removeEventHandler: manager.
	self userData removeKey: #contextMenuManager
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> removeContextMenuManager [

	self
		deprecated: 'Use #removeContextMenuBuilder'
		transformWith:
		'`@rcvr removeContextMenuManager' -> '`@rcvr removeContextMenuBuilder'.	
	self removeContextMenuBuilder 
]

{ #category : #'t - element with context menu' }
TToElementWithContextMenu >> useCircularContextMenu [

	self contextMenuManagerFactory: [
			ToContextMenuManager new
				windowClass: ToCircularContextMenu;
				placement: ToCircularMenuPickedPlacement new;
				yourself ] 
]
