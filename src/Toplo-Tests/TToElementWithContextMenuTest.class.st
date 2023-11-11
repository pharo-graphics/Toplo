Class {
	#name : 'TToElementWithContextMenuTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
TToElementWithContextMenuTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testContextMenu [

	| tt e ttwin  |
	tt := ToMenuItem new.
	e := ToElement new.
	space root addChild: e.
	self assert: e hasContextMenu not.
	e contextMenu: [:win :theElement | win addItem: tt ].
	self assert: e hasContextMenu.
	ttwin := e newContextMenuEvent: nil.
	self assert: e currentContextMenu identicalTo: ttwin.
	ttwin popupEvent: (BlMouseDownEvent new position: 0@0).
	self assert: ttwin root firstChild identicalTo: tt.
	self assert: ttwin element identicalTo: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithPopupEventHandler ]).
	ttwin close.
	^ e
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testContextMenuAddItem [

	"test that context menu item are added on popup (an not on window instanciation)"
	| e ttwin  |
	e := ToElement new.
	space root addChild: e.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuWindowHandler isNil.
	e contextMenu: [:win :theElement | win addItem: ToMenuItem new].
	self assert: e hasContextMenu.
	self assert: e rawContextMenuWindowHandler notNil.
	ttwin := e newContextMenuEvent: nil.
	self assert: ttwin isClosed.
	self assert: ttwin root hasChildren.
	ttwin popupEvent: (BlMouseDownEvent new position: 0@0).
	self assert: ttwin isOpened.
	self assert: ttwin root hasChildren.
	self assert: e contextMenuWindowHandler currentWindow notNil.
	self assert: e contextMenuWindowHandler element identicalTo: e.
	self assert: e currentContextMenu identicalTo: ttwin.
	self assert: e currentContextMenu identicalTo: e contextMenuWindowHandler currentWindow.
	ttwin close.
	self assert: ttwin isClosed.
	self assert: e currentContextMenu isNil.
	self assert: e contextMenuWindowHandler currentWindow isNil.
	self assert: e contextMenuWindowHandler element identicalTo: e.
	^ e
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testContextMenuBuilder [

	| e b |
	e := ToElement new.
	b := [:win :theElement | win addItem: ToMenuItem new ].
	e contextMenuBuilder: b.
	self assert: e rawContextMenuWindowHandler notNil.
	self assert: e rawContextMenuWindowHandler builder identicalTo: b.
	e removeContextMenuWindowHandler.
	self assert: e rawContextMenuWindowHandler isNil.

]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testContextMenuCanPopupIfElementInSpace [

	"test that context menu item are added on popup (an not on window instanciation)"
	| e ttwin  |
	e := ToElement new.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuWindowHandler isNil.
	e contextMenu: [:win :theElement | win addItem: ToMenuItem new].
	self assert: e hasContextMenu.
	self assert: e rawContextMenuWindowHandler notNil.
	ttwin := e newContextMenuEvent: nil.
	self assert: ttwin isClosed.
	self assert: ttwin root hasChildren.
	self should: [ttwin popupEvent: (BlMouseDownEvent new position: 0@0)] raise: Error.
	self assert: ttwin isClosed.
	self assert: ttwin root hasChildren.
	space root addChild: e.
	ttwin popupEvent: (BlMouseDownEvent new position: 0@0).
	self assert: ttwin isOpened.
	self assert: ttwin root hasChildren.
	self assert: e contextMenuWindowHandler currentWindow notNil.
	self assert: e contextMenuWindowHandler element identicalTo: e.
	self assert: e currentContextMenu identicalTo: ttwin.
	self assert: e currentContextMenu identicalTo: e contextMenuWindowHandler currentWindow.
	ttwin close.
	self assert: ttwin isClosed.
	self assert: e currentContextMenu isNil.
	self assert: e contextMenuWindowHandler currentWindow isNil.
	self assert: e contextMenuWindowHandler element identicalTo: e.
	^ e
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testContextMenuContent [

	|  e ttwin |
	e := self testContextMenu.
	self assert: e hasContextMenu.
	ttwin := e newContextMenuEvent: (BlMouseDownEvent new).
	ttwin popupEvent: (BlMouseDownEvent new position: 0@0).
	self assert: ttwin root firstChild notNil.
	e contextMenuContent: nil.
	self assert: e currentContextMenu isNil.
	self assert: e hasContextMenu not.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
		eh isKindOf: ToElementWithPopupEventHandler ]) not.

	ttwin close.
	^ e
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testContextMenuWindowHandler [

	| e ttwin  |
	e := ToElement new.
	space root addChild: e.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuWindowHandler isNil.
	e contextMenu: [:win :theElement | win addItem: ToMenuItem new].
	self assert: e hasContextMenu.
	self assert: e rawContextMenuWindowHandler notNil.
	ttwin := e newContextMenuEvent: nil.
	ttwin popupEvent: (BlMouseDownEvent new position: 0@0).
	self assert: e contextMenuWindowHandler currentWindow notNil.
	self assert: e contextMenuWindowHandler element identicalTo: e.
	ttwin close.
	self assert: e contextMenuWindowHandler currentWindow isNil.
	self assert: e contextMenuWindowHandler element identicalTo: e.
	^ e
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testCurrentContextMenu [

	|  e  ttwin |
	e := self testHasContextMenu.
	self assert: e currentContextMenu isNil.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithPopupEventHandler ]).
	ttwin := e newContextMenuEvent: nil.
	e contextMenuContent: { ToMenuItem new }.
	self assert: e hasContextMenu.
	self assert: e currentContextMenu notNil.
	self assert: e currentContextMenu identicalTo: ttwin.
	ttwin close.
	^ e
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testCurrentContextMenuWindow [

	| e |
	e := ToElement new.
	e contextMenuContent: {ToMenuItem new}.
	self assert: e hasContextMenu.
	self assert: e currentContextMenu isNil.
	e newContextMenuEvent: nil.
	self assert: e currentContextMenu notNil.
	self
		assert: e currentContextMenu class
		equals: e contextMenuWindowHandler windowClass.
	^ e
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testHasContextMenu [

	|  e  |
	e := ToElement new.
	self assert: e hasContextMenu not.
	self should: [e newContextMenuEvent: nil] raise: Error.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithPopupEventHandler ]) not.
	e contextMenuContent: { ToMenuItem new }.
	self assert: e hasContextMenu.
	^ e
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testHasOpenedContextMenu [

	| e |
	e := ToElement new.
	e contextMenuContent: { ToMenuItem new }.
	self assert: e hasOpenedContextMenu not.
	self assert: e currentContextMenu isNil.
	e newContextMenuEvent: nil.
	self assert: e hasOpenedContextMenu.
	self assert: e currentContextMenu notNil.
	self
		assert: e currentContextMenu class
		equals: e contextMenuWindowHandler windowClass.
	^ e
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testNewContextMenuEvent [

	| e |
	e := ToElement new.
	self assert: e currentContextMenu isNil.
	self assert: e rawContextMenuWindowHandler isNil.
	self should: [ e newContextMenuEvent: nil ] raise: Error.
	e contextMenuContent: { }.
	self assert: e hasContextMenu.
	self assert: e rawContextMenuWindowHandler notNil.
	e newContextMenuEvent: nil.
	self assert: e contextMenuWindowHandler currentWindow notNil.
	self assert: e currentContextMenu identicalTo: e contextMenuWindowHandler currentWindow.
	^ e
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testRawContextMenuWindowHandler [

	| e |
	e := ToElement new.
	self assert: e rawContextMenuWindowHandler isNil.
	e contextMenuContent: { }.
	self assert: e rawContextMenuWindowHandler notNil.
	e removeContextMenuWindowHandler.
	self assert: e rawContextMenuWindowHandler isNil.

]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testRemoveContextMenu [

	self testRemoveContextMenuWindowHandler 
]

{ #category : 'tests' }
TToElementWithContextMenuTest >> testRemoveContextMenuWindowHandler [

	|  e  |
	e := self testContextMenu.
	self assert: e hasContextMenu.
	e removeContextMenuWindowHandler.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithPopupEventHandler ]) not.
	self assert: e currentContextMenu isNil.
	self assert: e hasContextMenu not.
	^ e
]
