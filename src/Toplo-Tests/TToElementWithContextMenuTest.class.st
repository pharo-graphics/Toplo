Class {
	#name : #TToElementWithContextMenuTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenu [

	| tt e ttwin |
	tt := ToMenuItem new.
	e := ToElement new.
	space root addChild: e.
	self assert: e hasContextMenu not.
	e contextMenu: [ :win :theElement | win addItem: tt ].
	self assert: e hasContextMenu.
	ttwin := e newContextMenuEvent: nil.
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
	e contextMenu: [ :win :theElement | win addItem: ToMenuItem new ].
	self assert: e hasContextMenu.
	self assert: e rawContextMenuManager notNil.
	ttwin := e newContextMenuEvent: nil.
	self assert: ttwin isClosed.
	self assert: ttwin root hasChildren.
	ttwin popupEvent: (BlMouseDownEvent new position: 0 @ 0).
	self waitTestingSpaces.
	self assert: ttwin isOpened.
	self assert: ttwin root hasChildren.
	self assert: e contextMenuManager currentWindow notNil.
	self assert: e contextMenuManager anchorElement identicalTo: e.
	self assert: e currentContextMenu identicalTo: ttwin.
	self
		assert: e currentContextMenu
		identicalTo: e contextMenuManager currentWindow.
	ttwin close.
	self assert: ttwin isClosed.
	self assert: e currentContextMenu isNil.
	self assert: e contextMenuManager currentWindow isNil.
	self assert: e contextMenuManager anchorElement identicalTo: e.
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
	e removeContextMenuManager.
	self assert: e rawContextMenuManager isNil
]

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenuCanPopupIfElementInSpace [
	"test that context menu item are added on popup (an not on window instanciation)"

	| e ttwin |
	e := ToElement new.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuManager isNil.
	e contextMenu: [ :win :theElement | win addItem: ToMenuItem new ].
	self assert: e hasContextMenu.
	self assert: e rawContextMenuManager notNil.
	ttwin := e newContextMenuEvent: nil.
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
	self assert: e contextMenuManager currentWindow notNil.
	self assert: e contextMenuManager anchorElement identicalTo: e.
	self assert: e currentContextMenu identicalTo: ttwin.
	self
		assert: e currentContextMenu
		identicalTo: e contextMenuManager currentWindow.
	ttwin close.
	self assert: ttwin isClosed.
	self assert: e currentContextMenu isNil.
	self assert: e contextMenuManager currentWindow isNil.
	self assert: e contextMenuManager anchorElement identicalTo: e.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenuItems [

	|  e ttwin |
	e := self testContextMenu.
	self assert: e hasContextMenu.
	self assert: e contextMenuManager currentWindow isNil.
	ttwin := e newContextMenuEvent: (BlMouseDownEvent new).
	ttwin popupEvent: (BlMouseDownEvent new position: 0@0).
	self waitTestingSpaces.
	self assert: ttwin root firstChild notNil.
	e contextMenuItems: nil.
	self assert: e currentContextMenu isNil.
	self assert: e hasContextMenu not.
	self waitTestingSpaces.
	self should: [ttwin close] raise: Error.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenuManager [

	| e ttwin |
	e := ToElement new.
	space root addChild: e.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuManager isNil.
	e contextMenu: [ :win :theElement | win addItem: ToMenuItem new ].
	self assert: e hasContextMenu.
	self assert: e rawContextMenuManager notNil.
	ttwin := e newContextMenuEvent: nil.
	ttwin popupEvent: (BlMouseDownEvent new position: 0 @ 0).
	self waitTestingSpaces.
	self assert: e contextMenuManager currentWindow notNil.
	self assert: e contextMenuManager anchorElement identicalTo: e.
	ttwin close.
	self assert: e contextMenuManager currentWindow isNil.
	self assert: e contextMenuManager anchorElement identicalTo: e.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenuManagerClass [

	| e  |
	e := ToElement new.
	space root addChild: e.
	self assert: e contextMenuManagerClass identicalTo: ToContextMenuManager.
	

]

{ #category : #tests }
TToElementWithContextMenuTest >> testContextMenuRequest [

	"test that context menu item are added on popup (an not on window instanciation)"
	| e ttwin request |
	e := ToElement new.
	space root addChild: e.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuManager isNil.
	e contextMenu: [:win :theRequest | win addItem: ToMenuItem new. request := theRequest].
	ttwin := e newContextMenuEvent: nil.
	self assert: request notNil.
	self assert: request class identicalTo: ttwin manager windowRequestClass.
	self assert: request target identicalTo: e 
]

{ #category : #tests }
TToElementWithContextMenuTest >> testCurrentContextMenu [

	|  e  ttwin |
	e := self testHasContextMenu.
	self assert: e currentContextMenu isNil.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToContextMenuManager ]).
	ttwin := e newContextMenuEvent: nil.
	e contextMenuItems: { ToMenuItem new }.
	self assert: e hasContextMenu.
	self assert: e currentContextMenu notNil.
	self assert: e currentContextMenu identicalTo: ttwin.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testCurrentContextMenuWindow [

	| e |
	e := ToElement new.
	e contextMenuItems: {ToMenuItem new}.
	self assert: e hasContextMenu.
	self assert: e currentContextMenu isNil.
	e newContextMenuEvent: nil.
	self assert: e currentContextMenu notNil.
	self
		assert: e currentContextMenu class
		equals: e contextMenuManager popupWindowClass.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testHasContextMenu [

	|  e  |
	e := ToElement new.
	self assert: e hasContextMenu not.
	self should: [e newContextMenuEvent: nil] raise: Error.
	e contextMenuItems: { ToMenuItem new }.
	self assert: e hasContextMenu.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testHasOpenedContextMenu [

	| e |
	e := ToElement new.
	e contextMenuItems: { ToMenuItem new }.
	self assert: e hasOpenedContextMenu not.
	self assert: e currentContextMenu isNil.
	e newContextMenuEvent: nil.
	self assert: e hasOpenedContextMenu.
	self assert: e currentContextMenu notNil.
	self
		assert: e currentContextMenu class
		equals: e contextMenuManager popupWindowClass.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testNewContextMenuEvent [

	| e |
	e := ToElement new.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuManager isNil.
	self should: [ e newContextMenuEvent: nil ] raise: Error.
	e contextMenuItems: { }.
	self assert: e hasContextMenu.
	self assert: e rawContextMenuManager notNil.
	e newContextMenuEvent: nil.
	self assert: e contextMenuManager currentWindow notNil.
	self assert: e currentContextMenu identicalTo: e contextMenuManager currentWindow.
	^ e
]

{ #category : #tests }
TToElementWithContextMenuTest >> testRawContextMenuManager [

	| e |
	e := ToElement new.
	self assert: e rawContextMenuManager isNil.
	e contextMenuItems: { }.
	self assert: e rawContextMenuManager notNil.
	e removeContextMenuManager.
	self assert: e rawContextMenuManager isNil.

]

{ #category : #tests }
TToElementWithContextMenuTest >> testRemoveContextMenuManager [

	|  e  |
	e := self testContextMenu.
	self assert: e hasContextMenu.
	e removeContextMenuManager.
	self assert: e currentContextMenu isNil.
	self assert: e hasContextMenu not.
	^ e
]
