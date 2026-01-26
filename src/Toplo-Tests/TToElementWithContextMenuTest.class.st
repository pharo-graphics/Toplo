Class {
	#name : #TToElementWithContextMenuTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenu [

	| tt e ttwin |
	e := ToElement new.
	space root addChild: e.
	self deny: e hasContextMenu.
	e contextMenuBuilder: [ :win :theElement |
		win addItem: (tt := ToMenuItem new) ].
	self deny: e hasContextMenu.
	self assert: e rawContextMenuManager notNil.
	ttwin := e newContextMenuOnEvent: nil.
	self assert: e currentContextMenu identicalTo: ttwin.
	ttwin popupEvent: (BlMouseDownEvent new position: 0 @ 0).
	self waitTestingSpaces.
	self assert: ttwin root firstChild nodes first item identicalTo: tt.
	self assert: ttwin anchorElement identicalTo: e.
	ttwin close.
	self waitTestingSpaces.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenuAddItem [
	"test that context menu item are added on popup (an not on window instanciation)"

	| e ttwin |
	e := ToElement new.
	space root addChild: e.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuManager isNil.
	e contextMenuBuilder: [ :win :theElement |
		win addItem: ToMenuItem new ].
	self assert: e rawContextMenuManager notNil.
	ttwin := e newContextMenuOnEvent: nil.
	self assert: ttwin isClosed.
	self assert: ttwin root hasChildren.
	ttwin popupEvent: (BlMouseDownEvent new position: 0 @ 0).
	self waitTestingSpaces.
	self assert: ttwin isOpened.
	self assert: ttwin root hasChildren.
	self assert: e ensuredContextMenuManager currentWindow notNil.
	self assert: e ensuredContextMenuManager anchorElement identicalTo: e.
	self assert: e currentContextMenu identicalTo: ttwin.
	self
		assert: e currentContextMenu
		identicalTo: e ensuredContextMenuManager currentWindow.
	ttwin close.
	self assert: ttwin isClosed.
	self assert: e currentContextMenu isNil.
	self assert: e ensuredContextMenuManager currentWindow isNil.
	self assert: e ensuredContextMenuManager anchorElement identicalTo: e.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenuBuilder [

	| e b |
	e := ToElement new.
	b := [ :win :theRequest | win addItem: ToMenuItem new ].
	e contextMenuBuilder: b.
	self assert: e rawContextMenuManager notNil.
	self
		assert: e rawContextMenuManager windowBuilder
		identicalTo: b.
	e removeContextMenuBuilder.
	self assert: e rawContextMenuManager isNil
]

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenuBuilder2 [

	| e ttwin |
	e := self testContextMenu.
	self assert: e ensuredContextMenuManager currentWindow isNil.
	ttwin := e newContextMenuOnEvent: BlMouseDownEvent new.
	ttwin popupEvent: (BlMouseDownEvent new position: 0 @ 0).
	self waitTestingSpaces.
	self assert: ttwin root firstChild notNil.
	e removeContextMenuBuilder.
	self assert: e currentContextMenu isNil.
	self assert: e hasContextMenu not.
	self waitTestingSpaces.
	self should: [ ttwin close ] raise: Error.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenuCanPopupIfElementInSpace [
	"test that context menu item are added on popup (an not on window instanciation)"

	| e ttwin |
	e := ToElement new.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuManager isNil.
	e contextMenuBuilder: [ :win :theElement |
		win addItem: ToMenuItem new ].
	self assert: e rawContextMenuManager notNil.
	ttwin := e newContextMenuOnEvent: nil.
	self assert: ttwin isClosed.
	self assert: ttwin root hasChildren.
	self
		should: [ ttwin popupEvent: (BlMouseDownEvent new position: 0 @ 0) ]
		raise: Error.
	self assert: ttwin isClosed.
	self assert: ttwin root hasChildren.
	space root addChild: e.
	ttwin popupEvent: (BlMouseDownEvent new position: 0 @ 0).
	self waitTestingSpaces.
	self assert: ttwin isOpened.
	self assert: ttwin root hasChildren.
	self assert: e ensuredContextMenuManager currentWindow notNil.
	self assert: e ensuredContextMenuManager anchorElement identicalTo: e.
	self assert: e currentContextMenu identicalTo: ttwin.
	self
		assert: e currentContextMenu
		identicalTo: e ensuredContextMenuManager currentWindow.
	ttwin close.
	self assert: ttwin isClosed.
	self assert: e currentContextMenu isNil.
	self assert: e ensuredContextMenuManager currentWindow isNil.
	self assert: e ensuredContextMenuManager anchorElement identicalTo: e.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenuRequest [
	"test that context menu item are added on popup (an not on window instanciation)"

	| e ttwin request |
	e := ToElement new.
	space root addChild: e.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuManager isNil.
	e contextMenuBuilder: [ :win :theRequest |
			win addItem: ToMenuItem new.
			request := theRequest ].
	ttwin := e newContextMenuOnEvent: nil.
	self assert: request notNil.
	self
		assert: request class
		identicalTo: ttwin manager windowRequestClass.
	self assert: request target identicalTo: e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testCurrentContextMenu [

	| e ttwin |
	e := self testHasContextMenu.
	self assert: e currentContextMenu isNil.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToContextMenuManager ]).
	ttwin := e newContextMenuOnEvent: nil.
	e contextMenuBuilder: [ :menu :request |
		menu addAllItems: { ToMenuItem new } ].
	self assert: e hasContextMenu.
	self assert: e currentContextMenu notNil.
	self assert: e currentContextMenu identicalTo: ttwin.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testCurrentContextMenu2 [

	| e |
	e := ToElement new.
	e contextMenuBuilder: [ :menu :request |
		menu addAllItems: { ToMenuItem new } ].
	self assert: e currentContextMenu isNil.
	e newContextMenuOnEvent: nil.
	self assert: e currentContextMenu notNil.
	self
		assert: e currentContextMenu class
		equals: e ensuredContextMenuManager defaultWindowFactory value.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testEnsuredContextMenuManager [

	| e ttwin |
	e := ToElement new.
	space root addChild: e.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuManager isNil.
	e contextMenuBuilder: [ :win :theElement |
		win addItem: ToMenuItem new ].
	self assert: e rawContextMenuManager notNil.
	ttwin := e newContextMenuOnEvent: nil.
	ttwin popupEvent: (BlMouseDownEvent new position: 0 @ 0).
	self waitTestingSpaces.
	self assert: e ensuredContextMenuManager currentWindow notNil.
	self assert: e ensuredContextMenuManager anchorElement identicalTo: e.
	ttwin close.
	self assert: e ensuredContextMenuManager currentWindow isNil.
	self assert: e ensuredContextMenuManager anchorElement identicalTo: e.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testHasContextMenu [

	| e |
	e := ToElement new.
	self assert: e rawContextMenuManager isNil.
	self should: [ e newContextMenuOnEvent: nil ] raise: Error.
	e contextMenuBuilder: [ :menu :request |
		menu addAllItems: { ToMenuItem new } ].
	self assert: e rawContextMenuManager notNil.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testNewContextMenu [

	| e |
	e := ToElement new.
	self deny: e hasContextMenu.
	e contextMenuBuilder: [ :menu :request |
		menu addAllItems: { ToMenuItem new } ].
	self assert: e currentContextMenu isNil.
	e newContextMenu.
	self assert: e hasContextMenu.
	self assert: e currentContextMenu notNil.
	self
		assert: e currentContextMenu class
		equals: e ensuredContextMenuManager defaultWindowFactory value.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testNewContextMenuOnEvent [

	| e |
	e := ToElement new.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuManager isNil.
	self should: [ e newContextMenuOnEvent: nil ] raise: Error.
	e contextMenuBuilder: [ :menu :request | menu addAllItems: {  } ].
	self assert: e rawContextMenuManager notNil.
	e newContextMenuOnEvent: nil.
	self assert: e ensuredContextMenuManager currentWindow notNil.
	self
		assert: e currentContextMenu
		identicalTo: e ensuredContextMenuManager currentWindow.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testRawContextMenuManager [

	| e |
	e := ToElement new.
	self assert: e rawContextMenuManager isNil.
	e contextMenuBuilder: [ :menu :request | menu addAllItems: {  } ].
	self assert: e rawContextMenuManager notNil.
	e removeContextMenuBuilder.
	self assert: e rawContextMenuManager isNil
]

{ #category : #tests }
TToElementWithContextMenuTest >> testRemoveContextMenuBuilder [

	|  e  |
	e := self testContextMenu.
	self assert: e rawContextMenuManager notNil.
	e removeContextMenuBuilder.
	self assert: e rawContextMenuManager isNil.
	^ e
]
